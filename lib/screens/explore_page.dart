import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/mock_yummy_service.dart';
import '../components/restaurant_section.dart';
import '../components/category_section.dart';
import '../components/post_section.dart';
import '../models/car.dart';
import '../models/restaurant.dart';
import '../providers/car_providers.dart';

class ExplorePage extends ConsumerWidget {
  final mockService = MockYummyService();

  ExplorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carsAsync = ref.watch(carsStreamProvider);

    return carsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                error.toString(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => ref.refresh(carsStreamProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      data: (cars) => FutureBuilder(
        future: mockService.getExploreData(),
        builder: (context, AsyncSnapshot<ExploreData> snapshot) {
          final categories = snapshot.data?.categories ?? [];
          final posts = snapshot.data?.friendPosts ?? [];
          final mappedRestaurants = _mapCarsToRestaurants(cars);

          if (snapshot.connectionState != ConnectionState.done) {
            return ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [RestaurantSection(restaurants: mappedRestaurants)],
            );
          }

          return ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              RestaurantSection(restaurants: mappedRestaurants),
              CategorySection(categories: categories),
              PostSection(posts: posts),
            ],
          );
        },
      ),
    );
  }
}

List<Restaurant> _mapCarsToRestaurants(List<Car> cars) {
  // Adapter to reuse existing "dealership card" UI without changing models.
  return cars.asMap().entries.map((entry) {
    final index = entry.key;
    final car = entry.value;
    return Restaurant(
      'local_$index',
      car.brand,
      'Pickup location',
      car.description,
      car.imageUrl,
      0.0,
      4.8,
      [
        Item(
          name: car.name,
          description: car.description,
          price: car.price,
          imageUrl: car.imageUrl,
        ),
      ],
      [],
    );
  }).toList(growable: false);
}