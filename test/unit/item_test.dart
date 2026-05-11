// Unit tests for the `Item` model class.
//
// One test file per class (per project test rules). All tests follow the
// Arrange / Act / Assert convention.

import 'package:flutter_test/flutter_test.dart';

import 'package:untitled2/models/restaurant.dart';

void main() {
  group('Item', () {
    test('stores all required fields exactly as provided', () {
      // Arrange
      const name = 'Tesla Model 3';
      const description = 'Electric sedan';
      const price = 120.0;
      const imageUrl = 'https://example.com/tesla.jpg';

      // Act
      final item = Item(
        name: name,
        description: description,
        price: price,
        imageUrl: imageUrl,
      );

      // Assert
      expect(item.name, name);
      expect(item.description, description);
      expect(item.price, price);
      expect(item.imageUrl, imageUrl);
    });

    test('accepts an empty description and image url (edge case)', () {
      // Arrange — bare-minimum item with empty strings and zero price.

      // Act
      final item = Item(
        name: 'Bare Car',
        description: '',
        price: 0,
        imageUrl: '',
      );

      // Assert
      expect(item.description, isEmpty);
      expect(item.imageUrl, isEmpty);
      expect(item.price, 0);
    });

    test('preserves the exact price value without rounding', () {
      // Arrange
      const fractionalPrice = 59.99;

      // Act
      final item = Item(
        name: 'Honda Civic',
        description: 'Reliable',
        price: fractionalPrice,
        imageUrl: '',
      );

      // Assert
      expect(item.price, fractionalPrice);
    });
  });
}
