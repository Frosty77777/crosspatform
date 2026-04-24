import 'package:freezed_annotation/freezed_annotation.dart';

part 'car.freezed.dart';
part 'car.g.dart';

@freezed
sealed class Car with _$Car {
  const factory Car({
    required String id,
    required String name,
    required String brand,
    required double price,
    required String imageUrl,
    required String description,
  }) = _Car;

  factory Car.fromJson(Map<String, dynamic> json) => _$CarFromJson(json);
}
