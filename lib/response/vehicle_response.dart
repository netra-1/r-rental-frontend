// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:nrental/model/vehicle.dart';

part 'vehicle_response.g.dart';

@JsonSerializable()
class VehicleResponse {
  bool? success;
  List<Vehicle>? data;

  VehicleResponse({this.success, this.data});

  factory VehicleResponse.fromJson(Map<String, dynamic> json) =>
      _$VehicleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleResponseToJson(this);
}
