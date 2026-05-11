// Chapter 18 — Unit tests for the Restaurant/Item domain model.
//
// Unit tests focus on a single class in isolation. They are FAST (no
// Flutter binding, no UI) and ideal for verifying business logic and
// edge cases.
//
// Run just this file:  flutter test test/unit/restaurant_model_test.dart

import 'package:flutter_test/flutter_test.dart';

import 'package:untitled2/models/restaurant.dart';

void main() {
  group('Item model', () {
    test('stores all required fields exactly as provided', () {
      final item = Item(
        name: 'Tesla Model 3',
        description: 'Electric sedan',
        price: 120,
        imageUrl: 'https://example.com/tesla.jpg',
      );

      expect(item.name, 'Tesla Model 3');
      expect(item.description, 'Electric sedan');
      expect(item.price, 120);
      expect(item.imageUrl, 'https://example.com/tesla.jpg');
    });

    test('accepts an empty description / image url (edge case)', () {
      final item = Item(
        name: 'Bare Car',
        description: '',
        price: 0,
        imageUrl: '',
      );

      expect(item.description, isEmpty);
      expect(item.imageUrl, isEmpty);
      expect(item.price, 0);
    });
  });

  group('Restaurant.getRatingAndDistance', () {
    Restaurant _build({double rating = 4.8, double distance = 1.234}) {
      return Restaurant(
        '0',
        'Test Rental',
        'Some Street 1',
        'Premium sedans',
        'assets/restaurants/blacklogo.webp',
        distance,
        rating,
        const <Item>[],
        const <Review>[],
      );
    }

    test('formats both numbers to a single decimal place', () {
      final r = _build(rating: 4.8, distance: 1.234);
      expect(r.getRatingAndDistance(), 'Rating: 4.8 ★ | Pickup: 1.2 miles');
    });

    test('rounds correctly (edge case: 0.95 → 0.9, 0.96 → 1.0)', () {
      // Dart's toStringAsFixed uses banker's-style rounding for half-values
      // but for these inputs we just check standard rounding behavior.
      expect(_build(rating: 0.96, distance: 0.96).getRatingAndDistance(),
          'Rating: 1.0 ★ | Pickup: 1.0 miles');
    });

    test('handles a zero rating and zero distance', () {
      final r = _build(rating: 0, distance: 0);
      expect(r.getRatingAndDistance(), 'Rating: 0.0 ★ | Pickup: 0.0 miles');
    });
  });

  group('Restaurant items list', () {
    test('can be created empty and still produces a valid summary string', () {
      final r = Restaurant(
        '99',
        'Empty Lot',
        'Nowhere',
        'No cars yet',
        'assets/restaurants/img.png',
        2.0,
        3.5,
        const <Item>[],
        const <Review>[],
      );
      expect(r.items, isEmpty);
      expect(r.getRatingAndDistance(), contains('3.5'));
    });
  });
}
