// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bidding_vehicle_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BiddingVehicleResponse _$BiddingVehicleResponseFromJson(
    Map<String, dynamic> json) {
  return BiddingVehicleResponse(
    success: json['success'] as bool?,
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => BiddingVehicle.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BiddingVehicleResponseToJson(
        BiddingVehicleResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
