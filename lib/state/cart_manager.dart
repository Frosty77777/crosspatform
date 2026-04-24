import 'package:flutter/foundation.dart';

import '../models/restaurant.dart';

class CartEntry {
  final Item item;
  final String restaurantId;
  final String restaurantName;
  int quantity;
  int rentalDays;
  bool withInsurance;
  bool withDriver;
  double totalPrice;

  CartEntry({
    required this.item,
    required this.restaurantId,
    required this.restaurantName,
    required this.quantity,
    this.rentalDays = 1,
    this.withInsurance = false,
    this.withDriver = false,
    double? totalPrice,
  }) : totalPrice = totalPrice ?? item.price * quantity;
}

class CartBookingConfig {
  final int rentalDays;
  final bool withInsurance;
  final bool withDriver;
  final double totalPrice;

  const CartBookingConfig({
    required this.rentalDays,
    required this.withInsurance,
    required this.withDriver,
    required this.totalPrice,
  });
}

class CartManager extends ChangeNotifier {
  final Map<String, CartEntry> _entriesByItemName = {};

  List<CartEntry> get entries => _entriesByItemName.values.toList()
    ..sort((a, b) => a.item.name.compareTo(b.item.name));

  int get totalItems =>
      _entriesByItemName.values.fold(0, (sum, e) => sum + e.quantity);

  double get totalPrice => _entriesByItemName.values.fold(
        0,
        (sum, e) => sum + e.totalPrice,
      );

  bool get isEmpty => _entriesByItemName.isEmpty;

  void add({
    required Item item,
    required Restaurant restaurant,
    int quantity = 1,
    CartBookingConfig? bookingConfig,
  }) {
    final key = item.name;
    final existing = _entriesByItemName[key];
    final rentalDays = bookingConfig?.rentalDays ?? 1;
    final withInsurance = bookingConfig?.withInsurance ?? false;
    final withDriver = bookingConfig?.withDriver ?? false;
    final configuredTotal = bookingConfig?.totalPrice ?? (item.price * quantity);
    if (existing != null) {
      existing.quantity += quantity;
      // Keep latest booking choices so checkout reflects most recent configuration.
      existing.rentalDays = rentalDays;
      existing.withInsurance = withInsurance;
      existing.withDriver = withDriver;
      existing.totalPrice = configuredTotal * existing.quantity;
    } else {
      _entriesByItemName[key] = CartEntry(
        item: item,
        restaurantId: restaurant.id,
        restaurantName: restaurant.name,
        quantity: quantity,
        rentalDays: rentalDays,
        withInsurance: withInsurance,
        withDriver: withDriver,
        totalPrice: configuredTotal,
      );
    }
    notifyListeners();
  }

  void setQuantity(Item item, int quantity) {
    final key = item.name;
    final existing = _entriesByItemName[key];
    if (existing == null) return;
    if (quantity <= 0) {
      _entriesByItemName.remove(key);
    } else {
      final previousQuantity = existing.quantity;
      final perUnitConfiguredPrice =
          existing.totalPrice / (previousQuantity == 0 ? 1 : previousQuantity);
      existing.quantity = quantity;
      existing.totalPrice = perUnitConfiguredPrice * quantity;
    }
    notifyListeners();
  }

  void clear() {
    _entriesByItemName.clear();
    notifyListeners();
  }
}

