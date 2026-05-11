// Unit tests for `CartManager`.
//
// Conforms to project test rules:
//   • One test file per class.
//   • All test bodies use Arrange / Act / Assert comments.
//   • `verify(...).called(N)` is used after every repository interaction.
//   • State preserved across the Act step is declared with `late`.
//   • Tests assert on observable state — not on private fields or
//     implementation details.

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:untitled2/models/order.dart' as domain;
import 'package:untitled2/models/restaurant.dart';
import 'package:untitled2/repositories/local_data_repository.dart';
import 'package:untitled2/state/cart_manager.dart';

class MockLocalDataRepository extends Mock implements LocalDataRepository {}

void main() {
  setUpAll(() {
    // mocktail needs a fallback for any non-nullable, custom type used
    // with `any()` in matchers.
    registerFallbackValue(<CartEntry>[]);
    registerFallbackValue(_FakeOrder());
  });

  group('CartManager', () {
    late MockLocalDataRepository repo;
    late CartManager cart;

    final tesla = Item(
      name: 'Tesla Model 3',
      description: 'Electric sedan',
      price: 100,
      imageUrl: '',
    );
    final corolla = Item(
      name: 'Toyota Corolla',
      description: 'Compact',
      price: 50,
      imageUrl: '',
    );
    final provider = Restaurant(
      'r1',
      'Provider 1',
      'addr',
      'attr',
      '',
      1,
      4.5,
      <Item>[],
      <Review>[],
    );

    setUp(() {
      repo = MockLocalDataRepository();
      // Default stubs: empty persistence layer.
      when(() => repo.loadCartEntries())
          .thenAnswer((_) async => <CartEntry>[]);
      when(() => repo.saveCartEntries(any())).thenAnswer((_) async {});

      cart = CartManager(repo);
    });

    group('Initial state', () {
      test('is empty when no persisted data exists', () async {
        // Arrange — flush the async hydration triggered by the constructor.
        await Future<void>.delayed(Duration.zero);

        // Act — no action; inspect the freshly built CartManager.

        // Assert
        expect(cart.isEmpty, isTrue);
        expect(cart.entries, isEmpty);
        expect(cart.totalItems, 0);
        expect(cart.totalPrice, 0);
        verify(() => repo.loadCartEntries()).called(1);
      });

      test('hydrates from the repository when persisted data exists',
          () async {
        // Arrange
        final preMock = MockLocalDataRepository();
        when(() => preMock.loadCartEntries()).thenAnswer(
          (_) async => <CartEntry>[
            CartEntry(
              item: tesla,
              restaurantId: provider.id,
              restaurantName: provider.name,
              quantity: 2,
            ),
          ],
        );
        when(() => preMock.saveCartEntries(any())).thenAnswer((_) async {});

        // Act
        final hydrated = CartManager(preMock);
        await Future<void>.delayed(Duration.zero);

        // Assert
        expect(hydrated.totalItems, 2);
        expect(hydrated.entries.single.item.name, 'Tesla Model 3');
        verify(() => preMock.loadCartEntries()).called(1);
      });
    });

    group('add()', () {
      test('adds a brand new entry and notifies listeners', () {
        // Arrange
        var notified = 0;
        cart.addListener(() => notified++);

        // Act
        cart.add(item: tesla, restaurant: provider);

        // Assert
        expect(cart.entries, hasLength(1));
        expect(cart.entries.single.quantity, 1);
        expect(cart.totalItems, 1);
        expect(cart.totalPrice, 100);
        expect(notified, 1);
        verify(() => repo.saveCartEntries(any())).called(1);
      });

      test('accumulates quantity when adding the same item twice', () {
        // Arrange — no extra setup; cart starts empty.

        // Act
        cart.add(item: tesla, restaurant: provider, quantity: 2);
        cart.add(item: tesla, restaurant: provider, quantity: 3);

        // Assert
        expect(cart.entries, hasLength(1));
        expect(cart.entries.single.quantity, 5);
        expect(cart.totalItems, 5);
        verify(() => repo.saveCartEntries(any())).called(2);
      });

      test('sorts entries alphabetically by item name', () {
        // Arrange
        cart.add(item: tesla, restaurant: provider);

        // Act
        cart.add(item: corolla, restaurant: provider);

        // Assert
        expect(
          cart.entries.map((e) => e.item.name).toList(),
          <String>['Tesla Model 3', 'Toyota Corolla'],
        );
        verify(() => repo.saveCartEntries(any())).called(2);
      });

      test(
        'applies booking config (rentalDays / insurance / driver / total)',
        () {
          // Arrange
          const booking = CartBookingConfig(
            rentalDays: 3,
            withInsurance: true,
            withDriver: false,
            totalPrice: 350,
          );

          // Act
          cart.add(
            item: tesla,
            restaurant: provider,
            bookingConfig: booking,
          );

          // Assert
          final entry = cart.entries.single;
          expect(entry.rentalDays, 3);
          expect(entry.withInsurance, isTrue);
          expect(entry.withDriver, isFalse);
          expect(entry.totalPrice, 350);
          verify(() => repo.saveCartEntries(any())).called(1);
        },
      );
    });

    group('setQuantity()', () {
      test('updates an existing entry quantity proportionally', () {
        // Arrange
        cart.add(
          item: tesla,
          restaurant: provider,
          quantity: 1,
          bookingConfig: const CartBookingConfig(
            rentalDays: 2,
            withInsurance: false,
            withDriver: false,
            totalPrice: 200,
          ),
        );
        clearInteractions(repo);

        // Act
        cart.setQuantity(tesla, 4);

        // Assert
        expect(cart.entries.single.quantity, 4);
        expect(cart.entries.single.totalPrice, 800);
        verify(() => repo.saveCartEntries(any())).called(1);
      });

      test('removes the entry when quantity drops to zero (edge case)', () {
        // Arrange
        cart.add(item: tesla, restaurant: provider);
        clearInteractions(repo);

        // Act
        cart.setQuantity(tesla, 0);

        // Assert
        expect(cart.isEmpty, isTrue);
        expect(cart.totalItems, 0);
        verify(() => repo.saveCartEntries(any())).called(1);
      });

      test('removes the entry on negative quantity (edge case)', () {
        // Arrange
        cart.add(item: tesla, restaurant: provider);
        clearInteractions(repo);

        // Act
        cart.setQuantity(tesla, -5);

        // Assert
        expect(cart.isEmpty, isTrue);
        verify(() => repo.saveCartEntries(any())).called(1);
      });

      test('silently does nothing if the item is not in the cart', () {
        // Arrange — cart is empty.

        // Act
        cart.setQuantity(tesla, 5);

        // Assert
        expect(cart.isEmpty, isTrue);
        verifyNever(() => repo.saveCartEntries(any()));
      });
    });

    group('clear()', () {
      test('empties the cart and persists', () {
        // Arrange
        cart.add(item: tesla, restaurant: provider);
        cart.add(item: corolla, restaurant: provider);
        clearInteractions(repo);

        // Act
        cart.clear();

        // Assert
        expect(cart.isEmpty, isTrue);
        expect(cart.entries, isEmpty);
        verify(() => repo.saveCartEntries(any())).called(1);
      });
    });
  });
}

class _FakeOrder extends Fake implements domain.Order {}
