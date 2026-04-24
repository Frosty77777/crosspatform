import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'constants.dart';
import 'router.dart';
import 'state/theme_manager.dart';

void main() {
  runApp(const ProviderScope(child: CarRent()));
}

class CarRent extends StatefulWidget {
  const CarRent({super.key});

  @override
  State<CarRent> createState() => _CarRentState();
}

class _CarRentState extends State<CarRent> {
  ColorSelection colorSelected = ColorSelection.pink;
  final ThemeManager _themeManager = ThemeManager();

  void changeColor(int value) {
    setState(() {
      colorSelected = ColorSelection.values[value];
    });
  }

  @override
  void dispose() {
    _themeManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeManagerScope(
      manager: _themeManager,
      child: AnimatedBuilder(
        animation: _themeManager,
        builder: (context, _) => MaterialApp.router(
          // ── Chapter 8: swap MaterialApp for MaterialApp.router ──────────────
          routerConfig: appRouter,
          title: 'Car Rent',
          debugShowCheckedModeBanner: false,
          themeMode: _themeManager.themeMode,
          theme: ThemeData(
            colorSchemeSeed: colorSelected.color,
            useMaterial3: true,
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFF7F7F9),
            appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0),
            cardTheme: CardThemeData(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            navigationBarTheme: NavigationBarThemeData(
              indicatorColor: colorSelected.color.withValues(alpha: 0.15),
              height: 72,
              labelTextStyle: const WidgetStatePropertyAll(
                TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          darkTheme: ThemeData(
            colorSchemeSeed: colorSelected.color,
            useMaterial3: true,
            brightness: Brightness.dark,
            appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0),
            cardTheme: CardThemeData(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            navigationBarTheme: NavigationBarThemeData(
              indicatorColor: colorSelected.color.withValues(alpha: 0.30),
              height: 72,
              labelTextStyle: const WidgetStatePropertyAll(
                TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
