// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Favourite _$FavouriteFromJson(Map<String, dynamic> json) {
  return Favourite(
    user_id: json['user_id'] as String?,
    vehicle_id: json['vehicle_id'] == null
        ? null
        : Vehicle.fromJson(json['vehicle_id'] as Map<String, dynamic>),
  )..id = json['_id'] as String?;
}

Map<String, dynamic> _$FavouriteToJson(Favourite instance) => <String, dynamic>{
      '_id': instance.id,
      'user_id': instance.user_id,
      'vehicle_id': instance.vehicle_id,
    };
