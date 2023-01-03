import 'package:json_annotation/json_annotation.dart';

part 'vehicle.g.dart';

@JsonSerializable()
class Vehicle {
  @JsonKey(name: '_id')
  String? id;
  String? vehicle_name;
  String? vehicle_image;
  String? vehicle_company;
  String? vehicle_desc;
  String? booking_cost;
  String? vehicle_sku;
  String? vehicle_category;
  bool? is_featured;
  String? vehicle_rich_desc;

  Vehicle(
      {this.vehicle_name,
      this.vehicle_image,
      this.vehicle_company,
      this.vehicle_desc,
      this.booking_cost,
      this.vehicle_sku,
      this.vehicle_category,
      this.is_featured,
      this.vehicle_rich_desc});

  //1. flutter clean
  //2. flutter pub get

//3. flutter pub run build_runner build
  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return _$VehicleFromJson(json);
  }

  Map<String, dynamic> toJson() => _$VehicleToJson(this);
}
