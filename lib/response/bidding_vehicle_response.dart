// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:nrental/model/bidding_vehicle.dart';

part 'bidding_vehicle_response.g.dart';

@JsonSerializable()
class BiddingVehicleResponse {
  bool? success;
  List<BiddingVehicle>? data;

  BiddingVehicleResponse({this.success, this.data});

  factory BiddingVehicleResponse.fromJson(Map<String, dynamic> json) =>
      _$BiddingVehicleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BiddingVehicleResponseToJson(this);
}
