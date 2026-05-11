import 'package:drift/drift.dart';
import 'connection/connection_stub.dart'
    if (dart.library.io) 'connection/connection_native.dart'
    if (dart.library.js_interop) 'connection/connection_web.dart' as connection;

part 'app_database.g.dart';

class FavoriteCars extends Table {
  TextColumn get carId => text()();

  @override
  Set<Column<Object>> get primaryKey => {carId};
}

class CartEntries extends Table {
  TextColumn get itemName => text()();
  TextColumn get itemDescription => text()();
  RealColumn get itemPrice => real()();
  TextColumn get itemImageUrl => text()();
  TextColumn get restaurantId => text()();
  TextColumn get restaurantName => text()();
  IntColumn get quantity => integer()();
  IntColumn get rentalDays => integer()();
  BoolColumn get withInsurance => boolean()();
  BoolColumn get withDriver => boolean()();
  RealColumn get totalPrice => real()();

  @override
  Set<Column<Object>> get primaryKey => {itemName};
}

class Orders extends Table {
  TextColumn get id => text()();
  TextColumn get restaurantId => text()();
  TextColumn get restaurantName => text()();
  TextColumn get recipientName => text()();
  TextColumn get fulfillment => text()();
  IntColumn get dateTimeMillis => integer()();
  IntColumn get createdAtMillis => integer()();
  TextColumn get deliveryAddress => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class OrderItems extends Table {
  IntColumn get localId => integer().autoIncrement()();
  TextColumn get orderId => text().references(Orders, #id)();
  TextColumn get itemName => text()();
  TextColumn get itemDescription => text()();
  RealColumn get itemPrice => real()();
  TextColumn get itemImageUrl => text()();
  IntColumn get quantity => integer()();
}

@DriftDatabase(tables: [FavoriteCars, CartEntries, Orders, OrderItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(connection.openDatabaseConnection());

  @override
  int get schemaVersion => 1;

  Future<List<String>> getFavoriteIds() async {
    final rows = await select(favoriteCars).get();
    return rows.map((row) => row.carId).toList(growable: false);
  }

  Future<void> setFavorite(String carId, {required bool isFavorite}) async {
    if (isFavorite) {
      await into(favoriteCars).insertOnConflictUpdate(
        FavoriteCarsCompanion.insert(carId: carId),
      );
      return;
    }

    await (delete(favoriteCars)..where((tbl) => tbl.carId.equals(carId))).go();
  }

  Future<void> replaceCartEntries(List<CartEntriesCompanion> entries) async {
    await transaction(() async {
      await delete(cartEntries).go();
      if (entries.isNotEmpty) {
        await batch((batch) => batch.insertAll(cartEntries, entries));
      }
    });
  }

  Future<List<CartEntry>> getCartEntries() => select(cartEntries).get();

  Future<void> insertOrder(
    OrdersCompanion order,
    List<OrderItemsCompanion> items,
  ) async {
    await transaction(() async {
      await into(orders).insertOnConflictUpdate(order);
      if (items.isNotEmpty) {
        await batch((batch) => batch.insertAll(orderItems, items));
      }
    });
  }

  Future<List<Order>> getOrdersByCreatedDesc() async {
    final rows = await (select(orders)
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAtMillis)]))
        .get();
    return rows;
  }

  Future<List<OrderItem>> getOrderItems(String parentOrderId) {
    return (select(orderItems)..where((tbl) => tbl.orderId.equals(parentOrderId)))
        .get();
  }
}

