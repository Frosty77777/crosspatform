import 'dart:async';
import '../data/restaurant.dart';
import '../models/car.dart';
import 'car_repository.dart';

class LocalCarRepository implements ICarRepository {
  const LocalCarRepository();

  @override
  Future<List<Car>> getCars() async {
    return _buildCars();
  }

  @override
  Stream<List<Car>> watchCars() {
    final controller = StreamController<List<Car>>();
    Timer? timer;

    void emitCars() => controller.add(_buildCars());

    controller.onListen = () {
      emitCars();
      timer = Timer.periodic(const Duration(minutes: 5), (_) {
        emitCars();
      });
    };

    controller.onCancel = () async {
      timer?.cancel();
      await controller.close();
    };

    return controller.stream.distinct(_sameCars);
  }

  List<Car> _buildCars() {
    return restaurants.map((dealership) {
      final featuredCar = dealership.items.first;

      return Car(
        id: dealership.id,
        name: featuredCar.name,
        brand: dealership.name,
        price: featuredCar.price,
        imageUrl: dealership.imageUrl,
        description: dealership.attributes,
      );
    }).toList(growable: false);
  }

  bool _sameCars(List<Car> previous, List<Car> next) {
    if (previous.length != next.length) return false;

    for (var index = 0; index < previous.length; index++) {
      if (previous[index] != next[index]) {
        return false;
      }
    }

    return true;
  }
}

