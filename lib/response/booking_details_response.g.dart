// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingDetailsResponse _$BookingDetailsResponseFromJson(
    Map<String, dynamic> json) {
  return BookingDetailsResponse(
    success: json['success'] as bool?,
    data: json['data'] == null
        ? null
        : BookingVehicle.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BookingDetailsResponseToJson(
        BookingDetailsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
