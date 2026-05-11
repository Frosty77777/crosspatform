// Chapter 18 — Unit tests for CartManager.
//
// CartManager has one external dependency: LocalDataRepository (used to
// persist the cart). To test in isolation we provide a hand-rolled FAKE
// implementation that records calls in memory. This is a textbook
// example of "test double" / "fake" pattern — no extra packages needed.
//
// Note: CartManager is a ChangeNotifier, so we also verify that
// notifyListeners is invoked when state changes.

import 'package:flutter_test/flutter_test.dart';

import 'package:untitled2/models/order.dart' as domain;
import 'package:untitled2/models/restaurant.dart';
import 'package:untitled2/repositories/local_data_repository.dart';
import 'package:untitled2/state/cart_manager.dart';

/// In-memory fake repository. It satisfies the same interface as the
/// real one but does not touch the database at all.
class FakeLocalDataRepository implements LocalDataRepository {
  List<CartEntry> stored = <CartEntry>[];
  int saveCallCount = 0;

  /// Seed the "persisted" cart so we can test hydration.
  void seedCart(List<CartEntry> entries) => stored = entries;

  @override
  Future<List<CartEntry>> loadCartEntries() async => stored;

  @override
  Future<void> saveCartEntries(List<CartEntry> entries) async {
    saveCallCount += 1;
    stored = List<CartEntry>.from(entries);
  }

  // The methods below aren't exercised by CartManager but must exist
  // because we `implements` the concrete class.
  @override
  Future<Set<String>> loadFavorites() async => <String>{};

  @override
  Future<void> setFavorite(String carId, {required bool isFavorite}) async {}

  @override
  Future<List<domain.Order>> loadOrders() async => <domain.Order>[];

  @override
  Future<void> addOrder(domain.Order order) async {}
}

void main() {
  late FakeLocalDataRepository repo;
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
    repo = FakeLocalDataRepository();
    cart = CartManager(repo);
  });

  group('Initial state', () {
    test('is empty when no persisted data exists', () {
      expect(cart.isEmpty, isTrue);
      expect(cart.entries, isEmpty);
      expect(cart.totalItems, 0);
      expect(cart.totalPrice, 0);
    });

    test('hydrates from the repository when persisted data exists', () async {
      final pre = FakeLocalDataRepository()
        ..seedCart([
          CartEntry(
            item: tesla,
            restaurantId: provider.id,
            restaurantName: provider.name,
            quantity: 2,
          ),
        ]);
      final hydrated = CartManager(pre);
      // Hydration is asynchronous; flush the microtask queue.
      await Future<void>.delayed(Duration.zero);

      expect(hydrated.totalItems, 2);
      expect(hydrated.entries.single.item.name, 'Tesla Model 3');
    });
  });

  group('add()', () {
    test('adds a brand new entry and notifies listeners', () {
      var notified = 0;
      cart.addListener(() => notified++);

      cart.add(item: tesla, restaurant: provider);

      expect(cart.entries, hasLength(1));
      expect(cart.entries.single.quantity, 1);
      expect(cart.totalItems, 1);
      expect(cart.totalPrice, 100);
      expect(notified, 1, reason: 'must call notifyListeners exactly once');
      expect(repo.saveCallCount, 1, reason: 'must persist after mutation');
    });

    test('accumulates quantity when adding the same item twice', () {
      cart.add(item: tesla, restaurant: provider, quantity: 2);
      cart.add(item: tesla, restaurant: provider, quantity: 3);

      expect(cart.entries, hasLength(1));
      expect(cart.entries.single.quantity, 5);
      expect(cart.totalItems, 5);
    });

    test('sorts entries alphabetically by item name', () {
      cart.add(item: tesla, restaurant: provider);
      cart.add(item: corolla, restaurant: provider);

      expect(
        cart.entries.map((e) => e.item.name).toList(),
        <String>['Tesla Model 3', 'Toyota Corolla'],
      );
    });

    test('applies booking config (rentalDays / insurance / driver / total)',
        () {
      cart.add(
        item: tesla,
        restaurant: provider,
        bookingConfig: const CartBookingConfig(
          rentalDays: 3,
          withInsurance: true,
          withDriver: false,
          totalPrice: 350,
        ),
      );

      final entry = cart.entries.single;
      expect(entry.rentalDays, 3);
      expect(entry.withInsurance, isTrue);
      expect(entry.withDriver, isFalse);
      expect(entry.totalPrice, 350);
    });
  });

  group('setQuantity()', () {
    test('updates an existing entry quantity proportionally', () {
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

      cart.setQuantity(tesla, 4);

      expect(cart.entries.single.quantity, 4);
      expect(cart.entries.single.totalPrice, 800);
    });

    test('removes the entry when quantity drops to zero (edge case)', () {
      cart.add(item: tesla, restaurant: provider);
      cart.setQuantity(tesla, 0);

      expect(cart.isEmpty, isTrue);
      expect(cart.totalItems, 0);
    });

    test('removes the entry on negative quantity (edge case)', () {
      cart.add(item: tesla, restaurant: provider);
      cart.setQuantity(tesla, -5);

      expect(cart.isEmpty, isTrue);
    });

    test('silently does nothing if the item is not in the cart', () {
      cart.setQuantity(tesla, 5);
      expect(cart.isEmpty, isTrue);
    });
  });

  group('clear()', () {
    test('empties the cart and persists', () {
      cart.add(item: tesla, restaurant: provider);
      cart.add(item: corolla, restaurant: provider);

      cart.clear();

      expect(cart.isEmpty, isTrue);
      expect(cart.entries, isEmpty);
      expect(repo.stored, isEmpty);
    });
  });
}
