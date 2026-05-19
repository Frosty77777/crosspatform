import 'package:flutter/material.dart';

/// App-wide Carrent logo (login, drawer, launcher).
const kAppLogoAsset = 'assets/brand/car_rent_logo.png';

/// CashAuto Rent provider logo on explore carousel cards.
const kCashAutoLogoAsset = 'assets/restaurants/blacklogo.webp';

enum ColorSelection {
  deepPurple('Deep Purple', Colors.deepPurple),
  purple('Purple', Colors.purple),
  indigo('Indigo', Colors.indigo),
  blue('Blue', Colors.blue),
  teal('Teal', Colors.teal),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  orange('Orange', Colors.orange),
  deepOrange('Deep Orange', Colors.deepOrange),
  pink('Pink', Colors.pink);

  const ColorSelection(this.label, this.color);
  final String label;
  final Color color;
}
