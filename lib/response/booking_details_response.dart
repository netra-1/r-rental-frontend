// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:nrental/model/booking_vehicle.dart';

part 'booking_details_response.g.dart';

@JsonSerializable()
class BookingDetailsResponse {
  bool? success;
  BookingVehicle? data;

  BookingDetailsResponse({this.success, this.data});

  factory BookingDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$BookingDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookingDetailsResponseToJson(this);
}
