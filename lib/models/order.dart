import 'restaurant.dart';

enum FulfillmentType { delivery, pickup }

class OrderItem {
  final Item item;
  final int quantity;
  const OrderItem({required this.item, required this.quantity});
}

class Order {
  final String id;
  final String restaurantId;
  final String restaurantName;
  final String recipientName;
  final FulfillmentType fulfillment;
  final DateTime dateTime;
  final DateTime createdAt;
  final List<OrderItem> items;
  final String? deliveryAddress;

  const Order({
    required this.id,
    required this.restaurantId,
    required this.restaurantName,
    required this.recipientName,
    required this.fulfillment,
    required this.dateTime,
    required this.createdAt,
    required this.items,
    this.deliveryAddress,
  });

  double get total =>
      items.fold(0, (sum, oi) => sum + (oi.item.price * oi.quantity));
}
