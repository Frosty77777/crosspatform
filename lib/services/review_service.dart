import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/car_review.dart';

class ReviewService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  ReviewService({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
       _auth = auth ?? FirebaseAuth.instance;

  Stream<List<CarReview>> watchReviewsForCar(String carId) {
    return _firestore
        .collection('car_reviews')
        .where('carId', isEqualTo: carId)
        .orderBy('timestamp', descending: true)
        .limit(50)
        .snapshots()
        .map((snapshot) => snapshot.docs.map(CarReview.fromDoc).toList());
  }

  Future<void> addReview({
    required String carId,
    required String userName,
    required double rating,
    required String comment,
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('Please sign in to add a review.');
    }

    await _firestore.collection('car_reviews').add({
      'carId': carId,
      'userId': user.uid,
      'userName': userName,
      'rating': rating,
      'comment': comment,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
