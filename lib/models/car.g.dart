// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Car _$CarFromJson(Map<String, dynamic> json) => _Car(
  id: json['id'] as String,
  name: json['name'] as String,
  brand: json['brand'] as String,
  price: (json['price'] as num).toDouble(),
  imageUrl: json['imageUrl'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$CarToJson(_Car instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'brand': instance.brand,
  'price': instance.price,
  'imageUrl': instance.imageUrl,
  'description': instance.description,
};
