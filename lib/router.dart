import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'components/checkout_sheet.dart';
import 'screens/explore_page.dart';
import 'screens/account_page.dart';
import 'screens/login_page.dart';
import 'screens/orders_page.dart';
import 'screens/restaurant_page.dart';
import 'models/restaurant.dart';
import 'state/app_state_scope.dart';
import 'state/cart_manager.dart';
import 'state/order_manager.dart';
import 'state/theme_manager.dart';
import 'state/user_manager.dart';

/// Chapter 8 — go_router configuration
///
/// ShellRoute keeps the bottom NavigationBar alive during sub-navigation.
/// The 'redirect' callback is a stub — replace with your real auth check.

final _userManager = UserManager();
final _cartManager = CartManager();
final _orderManager = OrderManager();
final _appState = AppState(
  user: _userManager,
  cart: _cartManager,
  orders: _orderManager,
);

final appRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  refreshListenable: _userManager,

  // ── auth guard (stub) ────────────────────────────────────────────────────
  redirect: (context, state) {
    final loggingIn = state.matchedLocation == '/login';
    if (!_userManager.isLoggedIn) {
      return loggingIn ? null : '/login';
    }
    if (loggingIn) return '/explore';
    return null;
  },

  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) =>
          AppStateScope(state: _appState, child: const LoginPage()),
    ),
    // ── Shell keeps BottomNavigationBar / Drawer alive ────────────────────
    ShellRoute(
      builder: (context, state, child) => AppStateScope(
        state: _appState,
        child: AppShell(location: state.uri.path, child: child),
      ),
      routes: [
        GoRoute(
          path: '/explore',
          name: 'explore',
          builder: (context, state) => ExplorePage(),
        ),
        GoRoute(
          path: '/orders',
          name: 'orders',
          builder: (context, state) => const OrdersPage(),
        ),
        GoRoute(
          path: '/account',
          name: 'account',
          builder: (context, state) => const AccountPage(),
        ),
      ],
    ),

    // ── Full-screen routes (no shell / no bottom bar) ────────────────────
    GoRoute(
      path: '/restaurant/:id',
      name: 'restaurant',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        final restaurant = restaurants.firstWhere(
          (r) => r.id == id,
          orElse: () => restaurants.first,
        );
        return AppStateScope(
          state: _appState,
          child: RestaurantPage(restaurant: restaurant),
        );
      },
    ),
  ],
);

// ── AppShell ────────────────────────────────────────────────────────────────
/// Wraps the ShellRoute child with a Scaffold that has both a
/// NavigationDrawer (hamburger) and a bottom NavigationBar.

class AppShell extends StatelessWidget {
  final Widget child;
  final String location;
  const AppShell({super.key, required this.child, required this.location});

  // Map each tab path to a numeric index
  static const _tabs = ['/explore', '/orders', '/account'];

  int _locationToIndex(String location) {
    final idx = _tabs.indexWhere((t) => location.startsWith(t));
    return idx < 0 ? 0 : idx;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _locationToIndex(location);
    final cart = AppStateScope.of(context).cart;
    final themeManager = ThemeManagerScope.of(context);

    return Scaffold(
      // ── AppBar ──────────────────────────────────────────────────────────
      appBar: AppBar(
        title: const Text(
          'Car Rent',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        // Hamburger opens the drawer
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
        actions: [const SizedBox(width: 8)],
      ),

      // ── Navigation Drawer (sidebar) ─────────────────────────────────────
      drawer: NavigationDrawer(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          context.go(_tabs[index]);
          Navigator.pop(context); // close drawer
        },
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 24, 16, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.primaryContainer,
                  child: Icon(
                    Icons.directions_car,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Car Rent',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Find your perfect ride',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
          const Divider(),
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
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            onTap: () => Navigator.pop(context),
            contentPadding: const EdgeInsets.symmetric(horizontal: 28),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              AppStateScope.of(context).user.logout();
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 28),
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

      // ── Body (injected by ShellRoute) ───────────────────────────────────
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: child,
      ),

      floatingActionButton: AnimatedBuilder(
        animation: cart,
        builder: (context, _) => FloatingActionButton.extended(
          onPressed: () => CheckoutSheet.show(context),
          icon: const Icon(Icons.shopping_cart_outlined),
          label: Text('Cart (${cart.totalItems})'),
        ),
      ),

      // ── Bottom NavigationBar ────────────────────────────────────────────
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: NavigationBar(
            selectedIndex: currentIndex,
            onDestinationSelected: (index) => context.go(_tabs[index]),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Explore',
              ),
              NavigationDestination(
                icon: Icon(Icons.list_outlined),
                selectedIcon: Icon(Icons.list),
                label: 'Orders',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_2_outlined),
                selectedIcon: Icon(Icons.person),
                label: 'Account',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
