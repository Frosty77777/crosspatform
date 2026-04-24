import 'package:flutter/foundation.dart';

import '../models/order.dart';

class OrderManager extends ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => List.unmodifiable(_orders);

  void addOrder(Order order) {
    _orders.insert(0, order);
    notifyListeners();
  }
}

