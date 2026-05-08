import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/car.dart';
import '../repositories/car_repository.dart';
import '../repositories/local_car_repository.dart';

final carRepositoryProvider = Provider<ICarRepository>((ref) {
  return const LocalCarRepository();
});

final carsProvider = FutureProvider<List<Car>>((ref) async {
  final repo = ref.watch(carRepositoryProvider);
  return repo.getCars();
});

final carsStreamProvider = StreamProvider<List<Car>>((ref) {
  final repo = ref.watch(carRepositoryProvider);
  return repo.watchCars();
});

