import 'package:flutter/widgets.dart';

import 'cart_manager.dart';
import 'order_manager.dart';
import 'user_manager.dart';

class AppState {
  final UserManager user;
  final CartManager cart;
  final OrderManager orders;

  const AppState({
    required this.user,
    required this.cart,
    required this.orders,
  });
}

class AppStateScope extends InheritedWidget {
  final AppState state;

  const AppStateScope({
    super.key,
    required this.state,
    required super.child,
  });

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    assert(scope != null, 'No AppStateScope found in context');
    return scope!.state;
  }

  @override
  bool updateShouldNotify(covariant AppStateScope oldWidget) =>
      oldWidget.state != state;
}

