import 'package:flutter/material.dart';

import '../models/restaurant.dart';
import '../screens/restaurant_page.dart';

class RestaurantLandscapeCard extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantLandscapeCard({
    super.key,
    required this.restaurant,
  });

  @override
  State<RestaurantLandscapeCard> createState() =>
      _RestaurantLandscapeCardState();
}

class _RestaurantLandscapeCardState extends State<RestaurantLandscapeCard> {
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20.0)),
            child: AspectRatio(
              aspectRatio: 2,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Brand/storefront image for this rental provider.
                  Image.asset(
                    widget.restaurant.imageUrl,
                    fit: BoxFit.cover,
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
                          _isFavorited
                              ? Icons.favorite //
                              : Icons.favorite_border,
                        ),
                        iconSize: 22.0,
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            _isFavorited = !_isFavorited;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text(
              widget.restaurant.name,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            subtitle: Text(
              widget.restaurant.attributes,
              maxLines: 1,
              style: textTheme.bodySmall,
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Open full provider details with available rental options.
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RestaurantPage(
                          restaurant: widget.restaurant,
                        )),
              );
            },
          ),
        ],
      ),
    );
  }
}
