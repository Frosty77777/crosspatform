import 'package:flutter/material.dart';

class ThemeManager extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void setDarkMode(bool isDarkMode) {
    final nextMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    if (nextMode == _themeMode) return;
    _themeMode = nextMode;
    notifyListeners();
  }
}

class ThemeManagerScope extends InheritedNotifier<ThemeManager> {
  const ThemeManagerScope({
    super.key,
    required ThemeManager manager,
    required super.child,
  }) : super(notifier: manager);

  static ThemeManager of(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<ThemeManagerScope>();
    assert(scope != null, 'No ThemeManagerScope found in context');
    return scope!.notifier!;
  }
}
