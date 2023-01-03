import 'package:json_annotation/json_annotation.dart';
import 'package:nrental/model/user.dart';

part 'review.g.dart';

@JsonSerializable()
class Review {
  @JsonKey(name: '_id')
  String? id;
  User? user_id;
  String? vehicle_id;
  String? rating;
  String? review;
  Review({
    this.user_id,
    this.vehicle_id,
    this.rating,
    this.review,
  });

  //1. flutter clean
  //2. flutter pub get

//3. flutter pub run build_runner build
  factory Review.fromJson(Map<String, dynamic> json) {
    return _$ReviewFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
