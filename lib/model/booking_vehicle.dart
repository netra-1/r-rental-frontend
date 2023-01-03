import 'package:json_annotation/json_annotation.dart';
import 'package:nrental/model/vehicle.dart';

part 'booking_vehicle.g.dart';

@JsonSerializable()
class BookingVehicle {
  @JsonKey(name: '_id')
  String? id;
  String? user_id;
  Vehicle? vehicle_id;
  String? booking_date;
  String? booking_time;
  String? address;
  String? contact_no;
  int? no_of_days;
  String? status;
  BookingVehicle({
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
  factory BookingVehicle.fromJson(Map<String, dynamic> json) {
    return _$BookingVehicleFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BookingVehicleToJson(this);
}
