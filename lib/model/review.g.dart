// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) {
  return Review(
    user_id: json['user_id'] == null
        ? null
        : User.fromJson(json['user_id'] as Map<String, dynamic>),
    vehicle_id: json['vehicle_id'] as String?,
    rating: json['rating'] as String?,
    review: json['review'] as String?,
  )..id = json['_id'] as String?;
}

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      '_id': instance.id,
      'user_id': instance.user_id,
      'vehicle_id': instance.vehicle_id,
      'rating': instance.rating,
      'review': instance.review,
    };
