// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) {
  return Booking(
    user_id: json['user_id'] as String?,
    vehicle_id: json['vehicle_id'] as String?,
    booking_date: json['booking_date'] as String?,
    booking_time: json['booking_time'] as String?,
    address: json['address'] as String?,
    contact_no: json['contact_no'] as String?,
    no_of_days: json['no_of_days'] as String?,
    status: json['status'] as String?,
  )..id = json['_id'] as String?;
}

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
      '_id': instance.id,
      'user_id': instance.user_id,
      'vehicle_id': instance.vehicle_id,
      'booking_date': instance.booking_date,
      'booking_time': instance.booking_time,
      'address': instance.address,
      'contact_no': instance.contact_no,
      'no_of_days': instance.no_of_days,
      'status': instance.status,
    };
