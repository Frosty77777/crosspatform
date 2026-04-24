import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../models/car_catalog.dart';
import '../models/restaurant.dart';
import '../state/favorites_notifier.dart';
import '../state/app_state_scope.dart';

class OrdersPage extends ConsumerWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = AppStateScope.of(context).orders;
    final favorites = ref.watch(favoritesProvider).value ?? <String>{};
    final catalog = buildCarCatalog(restaurants);
    final favoriteCars = catalog
        .where((entry) => favorites.contains(entry.car.id))
        .toList(growable: false);

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'My activity',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const TabBar(
            tabs: [
              Tab(text: 'My Orders'),
              Tab(text: 'Favorites'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                AnimatedBuilder(
                  animation: orders,
                  builder: (context, _) {
                    final items = orders.orders;
                    if (items.isEmpty) {
                      return const Center(child: Text('No orders yet.'));
                    }
                    return ListView(
                      padding: const EdgeInsets.all(16),
                      children: items
                          .map(
                            (o) => Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer,
                                  child: Icon(
                                    o.fulfillment.name == 'delivery'
                                        ? Icons.local_shipping_outlined
                                        : Icons.storefront_outlined,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                title: Text(
                                  '${o.restaurantName} · \$${o.total.toStringAsFixed(0)}',
                                ),
                                subtitle: Text(
                                  '${o.recipientName} · ${o.dateTime.toLocal()}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Text(
                                  '${o.items.length} item(s)',
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                            ),
                          )
                          .toList(growable: false),
                    );
                  },
                ),
                favoriteCars.isEmpty
                    ? const Center(child: Text('No favorite cars yet.'))
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: favoriteCars.length,
                        itemBuilder: (context, index) {
                          final entry = favoriteCars[index];
                          return Slidable(
                            key: ValueKey(entry.car.id),
                            endActionPane: ActionPane(
                              motion: const DrawerMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (_) => ref
                                      .read(favoritesProvider.notifier)
                                      .removeFavorite(entry.car.id),
                                  icon: Icons.delete_outline,
                                  label: 'Remove',
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                ),
                              ],
                            ),
                            child: Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl: entry.car.imageUrl,
                                    width: 56,
                                    height: 56,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) => const Icon(
                                      Icons.directions_car,
                                    ),
                                  ),
                                ),
                                title: AutoSizeText(
                                  entry.car.name,
                                  maxLines: 1,
                                  minFontSize: 12,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                subtitle: Text(
                                  '${entry.restaurantName} · \$${entry.car.price.toStringAsFixed(0)}/day',
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

