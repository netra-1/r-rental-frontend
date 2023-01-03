import 'package:json_annotation/json_annotation.dart';
import 'package:nrental/model/user.dart';
import 'package:nrental/model/vehicle.dart';

part 'bidding_vehicle.g.dart';

@JsonSerializable()
class BiddingVehicle {
  @JsonKey(name: '_id')
  String? id;
  Vehicle? vehicle_id;
  User? user_id;
  String? price;
  String? status;
  BiddingVehicle({
    this.user_id,
    this.vehicle_id,
    this.status,
    this.id,
    this.price,
  });

  //1. flutter clean
  //2. flutter pub get

//3. flutter pub run build_runner build
  factory BiddingVehicle.fromJson(Map<String, dynamic> json) {
    return _$BiddingVehicleFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BiddingVehicleToJson(this);
}
