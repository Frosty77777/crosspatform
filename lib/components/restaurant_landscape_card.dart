import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/car_catalog.dart';
import '../models/restaurant.dart';
import '../state/favorites_notifier.dart';

class RestaurantLandscapeCard extends ConsumerWidget {
  final Restaurant restaurant;

  const RestaurantLandscapeCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurant = this.restaurant;
    final favoriteIds = ref.watch(favoritesProvider).value ?? <String>{};
    final representativeItem = restaurant.items.first;
    final carId = carIdFromItem(representativeItem);
    final isFavorited = favoriteIds.contains(carId);
    final textTheme = Theme.of(
      context,
    ).textTheme.apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20.0),
            ),
            child: AspectRatio(
              aspectRatio: 2,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Brand/storefront image for this rental provider.
                  Hero(
                    tag: 'car_image_${restaurant.id}',
                    child: Image.asset(
                      restaurant.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 10.0,
                    right: 10.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.35),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          isFavorited
                              ? Icons
                                    .favorite //
                              : Icons.favorite_border,
                        ),
                        iconSize: 22.0,
                        color: isFavorited ? Colors.redAccent : Colors.white,
                        onPressed: () => ref
                            .read(favoritesProvider.notifier)
                            .toggleFavorite(carId),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text(
              restaurant.name,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            subtitle: Text(
              restaurant.attributes,
              maxLines: 1,
              style: textTheme.bodySmall,
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Open full provider details with available rental options.
              context.push('/restaurant/${restaurant.id}');
            },
          ),
        ],
      ),
    );
  }
}
