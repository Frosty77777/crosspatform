class FoodCategory {
  String name;
  int numberOfRestaurants;
  String imageUrl;

  FoodCategory(this.name, this.numberOfRestaurants, this.imageUrl);
}

List<FoodCategory> categories = [
  FoodCategory('Sedan', 24, 'assets/categories/sedan.webp'),
  FoodCategory('SUV', 18, 'assets/categories/Suv.jpg'),
  FoodCategory('Luxury', 12, 'assets/categories/Luxury.jpg'),
  FoodCategory('Electric', 15, 'assets/categories/Cybertruck-fremont-cropped.jpg'),
  FoodCategory('Sport', 10, 'assets/categories/sport.jpg'),
  FoodCategory('Family', 20, 'assets/categories/family.jpg'),
];
