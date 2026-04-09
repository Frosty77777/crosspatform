class Item {
  // Represents a rentable car option shown inside a provider page.
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Item({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

class Review {
  final String reviewerName;
  final double rating;
  final String comment;
  final String date;
  final String imageUrl;


  Review({
    required this.reviewerName,
    required this.rating,
    required this.comment,
    required this.date,
    this.imageUrl = '',
  });
}

class Restaurant {
  // Kept as "Restaurant" to avoid breaking existing widget imports.
  String id;
  String name;
  String address;
  String attributes;
  String imageUrl;
  double distance;
  double rating;
  List<Item> items;
  List<Review> reviews;

  Restaurant(
    this.id,
    this.name,
    this.address,
    this.attributes,
    this.imageUrl,
    this.distance,
    this.rating,
    this.items,
    this.reviews,
  );

  String getRatingAndDistance() {
    return 'Rating: ${rating.toStringAsFixed(1)} ★ | Pickup: ${distance.toStringAsFixed(1)} miles';
  }
}

List<Restaurant> restaurants = [
  Restaurant(
    '0',
    'cashauto rent',
    'Zhaidarman2/1',
    'Sedan, SUV, Luxury',
    'assets/restaurants/blacklogo.webp',
    1.2,
    4.8,
    [
      Item(
        name: 'Tesla Model 3',
        description: 'Electric sedan, autopilot, premium interior.',
        price: 120,
        imageUrl:
            'https://images.unsplash.com/photo-1560958089-b8a1929cea89',
      ),
      Item(
        name: 'Toyota Corolla',
        description: 'Fuel efficient compact car, perfect for city travel.',
        price: 55,
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/f/f6/Toyota_Corolla_Limousine_Hybrid_Genf_2019_1Y7A5576.jpg',
      ),
      Item(
        name: 'BMW X5',
        description: 'Luxury SUV with spacious cabin and strong performance.',
        price: 145,
        imageUrl:
            'https://hips.hearstapps.com/hmg-prod/images/2024-bmw-x5-m60i-134-6602d491051b2.jpg?crop=0.686xw:0.514xh;0.152xw,0.341xh&resize=1200:*',
      ),
    ],
    [
      Review(
        reviewerName: 'Aruzhan S.',
        rating: 5.0,
        comment: 'Very clean cars and quick pickup. Booking was smooth.',
        date: '2 days ago',
        imageUrl: 'assets/profile_pics/person_stef.jpeg',
      ),
      Review(
        reviewerName: 'Daniel K.',
        rating: 4.5,
        comment: 'Tesla was in perfect condition. Staff was friendly.',
        date: '1 week ago',
        imageUrl: 'assets/profile_pics/person_cesare.jpeg',
      ),
      Review(
        reviewerName: 'Mira T.',
        rating: 4.8,
        comment: 'Great service and no hidden fees. Will rent again.',
        date: '2 weeks ago',
        imageUrl: 'assets/profile_pics/person_crispy.png',
      ),
    ],
  ),
  Restaurant(
    '1',
    'Urban Auto',
    'Mangilik el 23',
    'Budget, Family, Long Trip',
    'assets/restaurants/img.png',
    0.9,
    4.6,
    [
      Item(
        name: 'Honda Civic',
        description: 'Reliable compact sedan with modern safety features.',
        price: 60,
        imageUrl:
            'https://jdmenginezone.com/cdn/shop/articles/Honda_Civic_Type_R__FK__France__front_view_3edb2843-93c6-4601-9a77-4c01767a5cb6.jpg?v=1690241945',
      ),
      Item(
        name: 'Hyundai Tucson',
        description: 'Comfortable SUV for family road trips.',
        price: 85,
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqRKwHAxwD9IzyRRWodXcQ96yTK1BkeLjBJA&s',
      ),
      Item(
        name: 'Ford Mustang',
        description: 'Sporty coupe for weekend drives and special occasions.',
        price: 130,
        imageUrl:
            'https://s.auto.drom.ru/img4/catalog/photos/fullsize/ford/mustang/ford_mustang_120501.jpg',
      ),
    ],
    [
      Review(
        reviewerName: 'Ruslan A.',
        rating: 4.7,
        comment: 'Affordable prices and easy return process.',
        date: '3 days ago',
        imageUrl: 'assets/profile_pics/person_kevin.jpeg',
      ),
      Review(
        reviewerName: 'Sofia M.',
        rating: 4.4,
        comment: 'Booked a Tucson for family travel. Very comfortable.',
        date: '6 days ago',
        imageUrl: 'assets/profile_pics/person_sandra.jpeg',
      ),
      Review(
        reviewerName: 'Nurlan P.',
        rating: 4.6,
        comment: 'Helpful support and flexible booking times.',
        date: '10 days ago',
        imageUrl: 'assets/profile_pics/person_katz.jpeg',
      ),
    ],
  ),
];
