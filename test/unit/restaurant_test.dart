// Unit tests for the `Restaurant` model class.
//
// One test file per class (per project test rules). All tests follow the
// Arrange / Act / Assert convention.

import 'package:flutter_test/flutter_test.dart';

import 'package:untitled2/models/restaurant.dart';

void main() {
  group('Restaurant', () {
    Restaurant buildRestaurant({
      double rating = 4.8,
      double distance = 1.234,
      List<Item> items = const <Item>[],
    }) {
      return Restaurant(
        '0',
        'Test Rental',
        'Some Street 1',
        'Premium sedans',
        'assets/restaurants/blacklogo.webp',
        distance,
        rating,
        items,
        const <Review>[],
      );
    }

    group('getRatingAndDistance', () {
      test('formats both numbers to a single decimal place', () {
        // Arrange
        final r = buildRestaurant(rating: 4.8, distance: 1.234);

        // Act
        final result = r.getRatingAndDistance();

        // Assert
        expect(result, 'Rating: 4.8 ★ | Pickup: 1.2 miles');
      });

      test('rounds half-up at the first decimal place (edge case)', () {
        // Arrange
        final r = buildRestaurant(rating: 0.96, distance: 0.96);

        // Act
        final result = r.getRatingAndDistance();

        // Assert
        expect(result, 'Rating: 1.0 ★ | Pickup: 1.0 miles');
      });

      test('handles a zero rating and zero distance (edge case)', () {
        // Arrange
        final r = buildRestaurant(rating: 0, distance: 0);

        // Act
        final result = r.getRatingAndDistance();

        // Assert
        expect(result, 'Rating: 0.0 ★ | Pickup: 0.0 miles');
      });
    });

    group('items collection', () {
      test('is empty when constructed with no items (edge case)', () {
        // Arrange
        final r = buildRestaurant();

        // Act
        final items = r.items;

        // Assert
        expect(items, isEmpty);
      });

      test('exposes the items collection as provided', () {
        // Arrange
        final corolla = Item(
          name: 'Toyota Corolla',
          description: 'Compact',
          price: 50,
          imageUrl: '',
        );

        // Act
        final r = buildRestaurant(items: <Item>[corolla]);

        // Assert
        expect(r.items, hasLength(1));
        expect(r.items.single.name, 'Toyota Corolla');
      });
    });
  });
}
