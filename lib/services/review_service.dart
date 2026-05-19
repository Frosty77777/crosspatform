import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/restaurant.dart';

class ReviewService {
  final FirebaseFirestore _firestore;

  ReviewService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<Review>> getReviews(String restaurantId) {
    return _firestore
        .collection('reviews')
        .doc(restaurantId)
        .collection('entries')
        .orderBy('date', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map(Review.fromFirestore).toList(growable: false),
        );
  }

  Future<void> addReview(String restaurantId, Review review) async {
    await _firestore
        .collection('reviews')
        .doc(restaurantId)
        .collection('entries')
        .add(review.toMap());
  }
}
