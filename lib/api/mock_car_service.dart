import '../models/car.dart';

class ExploreData {
  final List<Car> cars;

  ExploreData(this.cars);
}

class MockCarService {
  Future<ExploreData> getExploreData() async {
    await Future.delayed(const Duration(seconds: 1));
    return ExploreData(cars);
  }
}
