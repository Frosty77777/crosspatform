import 'dart:async';


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../components/checkout_sheet.dart';
import '../components/restaurant_item.dart';
import '../models/car_review.dart';
import '../models/chat_message.dart';
import '../models/restaurant.dart';
import '../services/chat_service.dart';
import '../services/review_service.dart';
import '../state/app_state_scope.dart';
import '../state/cart_manager.dart';
import '../state/theme_manager.dart';

class RestaurantPage extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantPage({super.key, required this.restaurant});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  static const desktopThreshold = 700;
  static const double largeScreenPercentage = 0.9;
  static const double maxWidth = 1000;
  Timer? _checkoutBarTimer;
  bool _showCheckoutBar = false;
  final ReviewService _reviewService = ReviewService();
  final ChatService _chatService = ChatService();
  final TextEditingController _reviewController = TextEditingController();
  final TextEditingController _chatController = TextEditingController();
  double _pendingRating = 5;

  double _calculateConstrainedWidth(double screenWidth) {
    return (screenWidth > desktopThreshold
            ? screenWidth *
                  largeScreenPercentage //
            : screenWidth)
        .clamp(0.0, maxWidth);
  }

  int calculateColumnCount(double screenWidth) {
    // Use a 2-column grid on wider screens for better density.
    return screenWidth > desktopThreshold ? 2 : 1;
  }

  CustomScrollView _buildCustomScrollView() {
    return CustomScrollView(
      slivers: [
        _buildSliverAppBar(),
        _buildInfoSection(),
        _buildGridViewSection('Rental options'),
        _buildReviewsSection('Customer reviews'),
        _buildSupportChatSection('Chat with support'),
      ],
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 300.0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        // Large visual header to highlight rental provider branding.
        background: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 64.0),
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 30.0),
                  child: Hero(
                    tag: 'car_image_${widget.restaurant.id}',
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(24.0),
                        image: DecorationImage(
                          image: AssetImage(widget.restaurant.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 0.0,
                  left: 16.0,
                  child: CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.directions_car, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildInfoSection() {
    final textTheme = Theme.of(context).textTheme;
    final restaurant = widget.restaurant;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              restaurant.name,
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(restaurant.address, style: textTheme.bodySmall),
            const SizedBox(height: 2),
            Text(restaurant.getRatingAndDistance(), style: textTheme.bodySmall),
            const SizedBox(height: 8),
            Text(restaurant.attributes, style: textTheme.labelMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(int index) {
    final item = widget.restaurant.items[index];
    return InkWell(
      onTap: () {
        // Keep this hook for future booking action/details.
      },
      child: RestaurantItem(
        item: item,
        onBook: (rentalDays, withInsurance, withDriver, total) {
          final cart = AppStateScope.of(context).cart;
          cart.add(
            item: item,
            restaurant: widget.restaurant,
            bookingConfig: CartBookingConfig(
              rentalDays: rentalDays,
              withInsurance: withInsurance,
              withDriver: withDriver,
              totalPrice: total,
            ),
          );
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          _showCheckoutSummaryBar();
        },
      ),
    );
  }

  void _showCheckoutSummaryBar() {
    _checkoutBarTimer?.cancel();
    setState(() => _showCheckoutBar = true);
    _checkoutBarTimer = Timer(
      const Duration(seconds: 4),
      _hideCheckoutSummaryBar,
    );
  }

  void _hideCheckoutSummaryBar() {
    _checkoutBarTimer?.cancel();
    if (mounted) {
      setState(() => _showCheckoutBar = false);
    }
  }

  Widget _buildCheckoutSummaryBar() {
    final cart = AppStateScope.of(context).cart;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedSlide(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      offset: _showCheckoutBar ? Offset.zero : const Offset(0, 1),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: _showCheckoutBar ? 1 : 0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: GestureDetector(
            onVerticalDragEnd: (details) {
              if ((details.primaryVelocity ?? 0) > 350) {
                _hideCheckoutSummaryBar();
              }
            },
            onTap: () async {
              _hideCheckoutSummaryBar();
              await CheckoutSheet.show(context);
            },
            child: Material(
              elevation: 4,
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(18),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                child: AnimatedBuilder(
                  animation: cart,
                  builder: (context, _) => Row(
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        color: colorScheme.onPrimaryContainer,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Added to checkout',
                              style: textTheme.titleSmall?.copyWith(
                                color: colorScheme.onPrimaryContainer,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '${cart.totalItems} item(s) · \$${cart.totalPrice.toStringAsFixed(0)}',
                              style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Swipe down to dismiss',
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }

  GridView _buildGridView(int columns) {
    return GridView.builder(
      padding: const EdgeInsets.all(0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 3.5,
        crossAxisCount: columns,
      ),
      itemBuilder: (context, index) => _buildGridItem(index),
      itemCount: widget.restaurant.items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  SliverToBoxAdapter _buildGridViewSection(String title) {
    final columns = calculateColumnCount(MediaQuery.of(context).size.width);
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_sectionTitle(title), _buildGridView(columns)],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildReviewsSection(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle(title),
            const SizedBox(height: 8),
            StreamBuilder<List<CarReview>>(
              stream: _reviewService.watchReviewsForCar(widget.restaurant.id),
              builder: (context, snapshot) {
                final reviews = snapshot.data ?? <CarReview>[];
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (snapshot.hasError) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text('Unable to load reviews right now.'),
                  );
                }
                if (reviews.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text('No reviews yet. Be the first reviewer.'),
                  );
                }
                return Column(
                  children: reviews
                      .map(
                        (review) => Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 22,
                                  child: Text(
                                    review.userName.isNotEmpty
                                        ? review.userName[0].toUpperCase()
                                        : 'U',
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              review.userName,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                            ),
                                          ),
                                          Text(
                                            '${review.rating.toStringAsFixed(1)} ★',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodySmall,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        review.comment,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        '${review.timestamp}',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelSmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(growable: false),
                );
              },
            ),
            const SizedBox(height: 8),
            Slider(
              min: 1,
              max: 5,
              divisions: 8,
              label: _pendingRating.toStringAsFixed(1),
              value: _pendingRating,
              onChanged: (value) => setState(() => _pendingRating = value),
            ),
            TextField(
              controller: _reviewController,
              decoration: const InputDecoration(
                labelText: 'Write a review',
                border: OutlineInputBorder(),
              ),
              minLines: 2,
              maxLines: 3,
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton(
                onPressed: _submitReview,
                child: const Text('Submit review'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSupportChatSection(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle(title),
            const SizedBox(height: 8),
            SizedBox(
              height: 220,
              child: StreamBuilder<List<ChatMessage>>(
                stream: _chatService.watchSupportMessages(),
                builder: (context, snapshot) {
                  final messages = snapshot.data ?? <ChatMessage>[];
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Chat unavailable.'));
                  }
                  if (messages.isEmpty) {
                    return const Center(
                      child: Text('No messages yet. Start a support chat.'),
                    );
                  }
                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];
                      return ListTile(
                        dense: true,
                        title: Text(msg.senderName),
                        subtitle: Text(msg.text),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chatController,
                    decoration: const InputDecoration(
                      hintText: 'Message support...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: _sendSupportMessage,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitReview() async {
    final appState = AppStateScope.of(context);
    final reviewText = _reviewController.text.trim();
    if (reviewText.isEmpty) return;
    try {
      await _reviewService.addReview(
        carId: widget.restaurant.id,
        userName: appState.user.username.isEmpty
            ? 'Car Rent User'
            : appState.user.username,
        rating: _pendingRating,
        comment: reviewText,
      );
      _reviewController.clear();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> _sendSupportMessage() async {
    final appState = AppStateScope.of(context);
    final text = _chatController.text.trim();
    if (text.isEmpty) return;
    try {
      await _chatService.sendSupportMessage(
        text: text,
        senderName: appState.user.username.isEmpty
            ? 'Car Rent User'
            : appState.user.username,
      );
      _chatController.clear();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final constrainedWidth = _calculateConstrainedWidth(screenWidth);
    final themeManager = ThemeManagerScope.of(context);

    return Scaffold(
      drawer: NavigationDrawer(
        onDestinationSelected: (index) {
          Navigator.pop(context);
          if (index == 0) context.go('/explore');
          if (index == 1) context.go('/orders');
          if (index == 2) context.go('/account');
        },
        children: [
          const SizedBox(height: 12),
          const NavigationDrawerDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: Text('Explore'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.list_outlined),
            selectedIcon: Icon(Icons.list),
            label: Text('Orders'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.person_2_outlined),
            selectedIcon: Icon(Icons.person),
            label: Text('Account'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              Navigator.pop(context);
              await AppStateScope.of(context).user.logout();
            },
          ),
          SwitchListTile.adaptive(
            contentPadding: const EdgeInsets.symmetric(horizontal: 28),
            secondary: const Icon(Icons.dark_mode),
            title: const Text('Dark Mode'),
            value: themeManager.isDarkMode,
            onChanged: themeManager.setDarkMode,
          ),
        ],
      ),
      body: Center(
        child: Stack(
          children: [
            SizedBox(width: constrainedWidth, child: _buildCustomScrollView()),
            Align(
              alignment: Alignment.bottomCenter,
              child: IgnorePointer(
                ignoring: !_showCheckoutBar,
                child: _buildCheckoutSummaryBar(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _checkoutBarTimer?.cancel();
    _reviewController.dispose();
    _chatController.dispose();
    super.dispose();
  }
}
