// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:nrental/model/booking.dart';

part 'booking_response.g.dart';

@JsonSerializable()
class BookingResponse {
  bool? success;
  List<Booking>? data;

  BookingResponse({this.success, this.data});

  factory BookingResponse.fromJson(Map<String, dynamic> json) =>
      _$BookingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookingResponseToJson(this);
}
