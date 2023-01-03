// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:nrental/model/booking_vehicle.dart';

part 'booking_vehicle_response.g.dart';

@JsonSerializable()
class BookingVehicleResponse {
  bool? success;
  List<BookingVehicle>? data;

  BookingVehicleResponse({this.success, this.data});

  factory BookingVehicleResponse.fromJson(Map<String, dynamic> json) =>
      _$BookingVehicleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookingVehicleResponseToJson(this);
}
