class Post {
  String id;
  String profileImageUrl;
  String comment;
  String timestamp;

  Post(
    this.id,
    this.profileImageUrl,
    this.comment,
    this.timestamp,
  );
}

List<Post> posts = [
  Post(
    '1',
    'assets/profile_pics/person_cesare.jpeg',
    'Booked a Tesla for a weekend trip. Super smooth ride!',
    '12',
  ),
  Post(
    '2',
    'assets/profile_pics/person_stef.jpeg',
    'The airport pickup was fast and easy.',
    '28',
  ),
  Post(
    '3',
    'assets/profile_pics/person_crispy.png',
    'Got a family SUV for our vacation. Great experience.',
    '35',
  ),
  Post(
    '4',
    'assets/profile_pics/person_joe.jpeg',
    'Any recommendations for a budget sedan under \$70/day?',
    '43',
  ),
  Post(
    '5',
    'assets/profile_pics/person_katz.jpeg',
    'Luxury package was worth it for our anniversary drive.',
    '54',
  ),
];
