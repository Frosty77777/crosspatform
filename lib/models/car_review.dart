import 'package:cloud_firestore/cloud_firestore.dart';

class CarReview {
  final String id;
  final String carId;
  final String userId;
  final String userName;
  final double rating;
  final String comment;
  final DateTime timestamp;

  const CarReview({
    required this.id,
    required this.carId,
    required this.userId,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.timestamp,
  });

  factory CarReview.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};
    return CarReview(
      id: doc.id,
      carId: data['carId'] as String? ?? '',
      userId: data['userId'] as String? ?? '',
      userName: data['userName'] as String? ?? 'Anonymous',
      rating: (data['rating'] as num?)?.toDouble() ?? 0,
      comment: data['comment'] as String? ?? '',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
