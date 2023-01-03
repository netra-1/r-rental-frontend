// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_vehicle_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingVehicleResponse _$BookingVehicleResponseFromJson(
    Map<String, dynamic> json) {
  return BookingVehicleResponse(
    success: json['success'] as bool?,
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => BookingVehicle.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BookingVehicleResponseToJson(
        BookingVehicleResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
