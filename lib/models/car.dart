class Car {
  String id;
  String name;
  String brand;
  double pricePerDay;
  double rating;
  String imageUrl;
  String description;

  Car(
    this.id,
    this.name,
    this.brand,
    this.pricePerDay,
    this.rating,
    this.imageUrl,
    this.description,
  );
}

List<Car> cars = [
  Car(
    '1',
    'Model S',
    'Tesla',
    120,
    4.8,
    'assets/cars/tesla.png',
    'Electric luxury sedan',
  ),
  Car(
    '2',
    'Civic',
    'Honda',
    60,
    4.5,
    'assets/cars/civic.png',
    'Reliable compact car',
  ),
];
