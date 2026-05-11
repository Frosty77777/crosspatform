import 'package:flutter/foundation.dart';

import '../models/order.dart';
import '../repositories/local_data_repository.dart';

class OrderManager extends ChangeNotifier {
  final LocalDataRepository _repository;
  final List<Order> _orders = [];

  OrderManager(this._repository) {
    _hydrate();
  }

  List<Order> get orders => List.unmodifiable(_orders);

  void addOrder(Order order) {
    _orders.insert(0, order);
    _repository.addOrder(order);
    notifyListeners();
  }

  Future<void> _hydrate() async {
    final persisted = await _repository.loadOrders();
    if (persisted.isEmpty) return;
    _orders
      ..clear()
      ..addAll(persisted);
    notifyListeners();
  }
}

