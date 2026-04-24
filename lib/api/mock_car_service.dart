import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/car.dart';

class ExploreData {
  final List<Car> cars;

  ExploreData(this.cars);
}

class MockCarService {
  Future<ExploreData> getExploreData() async {
    await Future.delayed(const Duration(seconds: 1));
    final raw = await rootBundle.loadString('assets/data/car_catalog.json');
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    final carsJson = (decoded['cars'] as List<dynamic>).cast<Map<String, dynamic>>();
    final cars = carsJson.map(Car.fromJson).toList(growable: false);
    return ExploreData(cars);
  }
}
