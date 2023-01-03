import 'package:json_annotation/json_annotation.dart';

part 'booking.g.dart';

@JsonSerializable()
class Booking {
  @JsonKey(name: '_id')
  String? id;
  String? user_id;
  String? vehicle_id;
  String? booking_date;
  String? booking_time;
  String? address;
  String? contact_no;
  String? no_of_days;
  String? status;
  Booking({
    this.user_id,
    this.vehicle_id,
    this.booking_date,
    this.booking_time,
    this.address,
    this.contact_no,
    this.no_of_days,
    this.status,
  });

  //1. flutter clean
  //2. flutter pub get

//3. flutter pub run build_runner build
  factory Booking.fromJson(Map<String, dynamic> json) {
    return _$BookingFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BookingToJson(this);
}
