import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'persistent_search_bar.dart';
import '../components/restaurant_landscape_card.dart';
import '../models/restaurant.dart';

class RestaurantSection extends ConsumerStatefulWidget {
  final List<Restaurant> restaurants;
  const RestaurantSection({super.key, required this.restaurants});

  @override
  ConsumerState<RestaurantSection> createState() => _RestaurantSectionState();
}

class _RestaurantSectionState extends ConsumerState<RestaurantSection> {
  String _query = '';

  List<Restaurant> get _filteredRestaurants {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return widget.restaurants;
    return widget.restaurants.where((restaurant) {
      final inName = restaurant.name.toLowerCase().contains(query);
      final inAttributes = restaurant.attributes.toLowerCase().contains(query);
      final inItems = restaurant.items.any(
        (item) =>
            item.name.toLowerCase().contains(query) ||
            item.description.toLowerCase().contains(query),
      );
      return inName || inAttributes || inItems;
    }).toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    final restaurants = _filteredRestaurants;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Text(
              'Cars near me',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: PersistentSearchBar(
              hintText: 'Search cars, brands, specs',
              onQueryChanged: (value) => setState(() => _query = value),
            ),
          ),
          SizedBox(
            height: 230,
            // Horizontal list keeps car cards easy to scan quickly.
            child: restaurants.isEmpty
                ? const Center(child: Text('No cars found'))
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      return _StaggeredListItem(
                        index: index,
                        child: SizedBox(
                          width: 300,
                          child: RestaurantLandscapeCard(
                            restaurant: restaurants[index],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _StaggeredListItem extends StatefulWidget {
  final int index;
  final Widget child;
  const _StaggeredListItem({required this.index, required this.child});

  @override
  State<_StaggeredListItem> createState() => _StaggeredListItemState();
}

class _StaggeredListItemState extends State<_StaggeredListItem> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(Duration(milliseconds: widget.index * 70), () {
      if (mounted) {
        setState(() => _visible = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
      offset: _visible ? Offset.zero : const Offset(0, 0.2),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 350),
        opacity: _visible ? 1 : 0,
        child: widget.child,
      ),
    );
  }
}
