import 'package:json_annotation/json_annotation.dart';
import 'package:nrental/model/favourite.dart';
part 'favourite_response.g.dart';

@JsonSerializable()
class FavouriteResponse {
  bool? success;
  List<Favourite>? data;

  FavouriteResponse({this.success, this.data});

  factory FavouriteResponse.fromJson(Map<String, dynamic> json) =>
      _$FavouriteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FavouriteResponseToJson(this);
}




