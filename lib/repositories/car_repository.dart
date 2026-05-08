import '../models/car.dart';

abstract class ICarRepository {
  Future<List<Car>> getCars();
  Stream<List<Car>> watchCars();
}

