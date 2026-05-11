import 'package:drift/drift.dart';

import '../database/app_database.dart' as db;
import '../models/order.dart' as domain;
import '../models/restaurant.dart';
import '../state/cart_manager.dart';

class LocalDataRepository {
  final db.AppDatabase _database;

  LocalDataRepository(this._database);

  Future<Set<String>> loadFavorites() async {
    final ids = await _database.getFavoriteIds();
    return ids.toSet();
  }

  Future<void> setFavorite(String carId, {required bool isFavorite}) {
    return _database.setFavorite(carId, isFavorite: isFavorite);
  }

  Future<List<CartEntry>> loadCartEntries() async {
    final rows = await _database.getCartEntries();
    return rows
        .map(
          (row) => CartEntry(
            item: Item(
              name: row.itemName,
              description: row.itemDescription,
              price: row.itemPrice,
              imageUrl: row.itemImageUrl,
            ),
            restaurantId: row.restaurantId,
            restaurantName: row.restaurantName,
            quantity: row.quantity,
            rentalDays: row.rentalDays,
            withInsurance: row.withInsurance,
            withDriver: row.withDriver,
            totalPrice: row.totalPrice,
          ),
        )
        .toList(growable: false);
  }

  Future<void> saveCartEntries(List<CartEntry> entries) {
    return _database.replaceCartEntries(
      entries
          .map(
            (entry) => db.CartEntriesCompanion.insert(
              itemName: entry.item.name,
              itemDescription: entry.item.description,
              itemPrice: entry.item.price,
              itemImageUrl: entry.item.imageUrl,
              restaurantId: entry.restaurantId,
              restaurantName: entry.restaurantName,
              quantity: entry.quantity,
              rentalDays: entry.rentalDays,
              withInsurance: entry.withInsurance,
              withDriver: entry.withDriver,
              totalPrice: entry.totalPrice,
            ),
          )
          .toList(growable: false),
    );
  }

  Future<List<domain.Order>> loadOrders() async {
    final orders = await _database.getOrdersByCreatedDesc();
    final result = <domain.Order>[];
    for (final order in orders) {
      final items = await _database.getOrderItems(order.id);
      result.add(
        domain.Order(
          id: order.id,
          restaurantId: order.restaurantId,
          restaurantName: order.restaurantName,
          recipientName: order.recipientName,
          fulfillment: order.fulfillment == 'delivery'
              ? domain.FulfillmentType.delivery
              : domain.FulfillmentType.pickup,
          dateTime: DateTime.fromMillisecondsSinceEpoch(order.dateTimeMillis),
          createdAt: DateTime.fromMillisecondsSinceEpoch(order.createdAtMillis),
          deliveryAddress: order.deliveryAddress,
          items: items
              .map(
                (item) => domain.OrderItem(
                  item: Item(
                    name: item.itemName,
                    description: item.itemDescription,
                    price: item.itemPrice,
                    imageUrl: item.itemImageUrl,
                  ),
                  quantity: item.quantity,
                ),
              )
              .toList(growable: false),
        ),
      );
    }
    return result;
  }

  Future<void> addOrder(domain.Order order) {
    return _database.insertOrder(
      db.OrdersCompanion.insert(
        id: order.id,
        restaurantId: order.restaurantId,
        restaurantName: order.restaurantName,
        recipientName: order.recipientName,
        fulfillment: order.fulfillment.name,
        dateTimeMillis: order.dateTime.millisecondsSinceEpoch,
        createdAtMillis: order.createdAt.millisecondsSinceEpoch,
        deliveryAddress: order.deliveryAddress == null
            ? const Value.absent()
            : Value(order.deliveryAddress!),
      ),
      order.items
          .map(
            (item) => db.OrderItemsCompanion.insert(
              orderId: order.id,
              itemName: item.item.name,
              itemDescription: item.item.description,
              itemPrice: item.item.price,
              itemImageUrl: item.item.imageUrl,
              quantity: item.quantity,
            ),
          )
          .toList(growable: false),
    );
  }
}
