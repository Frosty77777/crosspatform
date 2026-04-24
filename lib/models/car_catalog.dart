import 'car.dart';
import 'restaurant.dart';

class CarCatalogEntry {
  final String restaurantId;
  final String restaurantName;
  final Car car;

  const CarCatalogEntry({
    required this.restaurantId,
    required this.restaurantName,
    required this.car,
  });
}

String carIdFromItem(Item item, {String? restaurantId}) {
  final normalizedName = item.name.toLowerCase().replaceAll(' ', '_');
  if (restaurantId == null || restaurantId.isEmpty) {
    return normalizedName;
  }
  return '${restaurantId}_$normalizedName';
}

List<CarCatalogEntry> buildCarCatalog(List<Restaurant> source) {
  return source
      .expand(
        (restaurant) => restaurant.items.map(
          (item) => CarCatalogEntry(
            restaurantId: restaurant.id,
            restaurantName: restaurant.name,
            car: Car(
              id: carIdFromItem(item),
              name: item.name,
              brand: restaurant.name,
              price: item.price,
              imageUrl: item.imageUrl,
              description: item.description,
            ),
          ),
        ),
      )
      .toList(growable: false);
}
