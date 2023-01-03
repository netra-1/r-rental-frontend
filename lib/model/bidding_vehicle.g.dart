// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bidding_vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BiddingVehicle _$BiddingVehicleFromJson(Map<String, dynamic> json) {
  return BiddingVehicle(
    user_id: json['user_id'] == null
        ? null
        : User.fromJson(json['user_id'] as Map<String, dynamic>),
    vehicle_id: json['vehicle_id'] == null
        ? null
        : Vehicle.fromJson(json['vehicle_id'] as Map<String, dynamic>),
    status: json['status'] as String?,
    id: json['_id'] as String?,
    price: json['price'] as String?,
  );
}

Map<String, dynamic> _$BiddingVehicleToJson(BiddingVehicle instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'vehicle_id': instance.vehicle_id,
      'user_id': instance.user_id,
      'price': instance.price,
      'status': instance.status,
    };
