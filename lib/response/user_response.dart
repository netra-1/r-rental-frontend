// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:nrental/model/user.dart';
import 'package:nrental/model/vehicle.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  bool? success;
  User? data;

  UserResponse({this.success, this.data});

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
