import 'package:json_annotation/json_annotation.dart';
import 'package:nrental/model/vehicle.dart';

part 'favourite.g.dart';

@JsonSerializable()
class Favourite {
  @JsonKey(name: '_id')
  String? id;
  String? user_id;
  Vehicle? vehicle_id;

  Favourite({
    this.user_id,
    this.vehicle_id,
  });

  factory Favourite.fromJson(Map<String, dynamic> json) {
    return _$FavouriteFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FavouriteToJson(this);
}
