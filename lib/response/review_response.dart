import 'package:json_annotation/json_annotation.dart';
import 'package:nrental/model/review.dart';

part 'review_response.g.dart';

@JsonSerializable()
class ReviewResponse {
  bool? success;
  List<Review>? data;

  ReviewResponse({this.success, this.data});

  factory ReviewResponse.fromJson(Map<String, dynamic> json) =>
      _$ReviewResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewResponseToJson(this);
}




