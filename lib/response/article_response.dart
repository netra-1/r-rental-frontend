// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:nrental/model/article.dart';

part 'article_response.g.dart';

@JsonSerializable()
class ArticleResponse {
  bool? success;
  List<Article>? data;

  ArticleResponse({this.success, this.data});

  factory ArticleResponse.fromJson(Map<String, dynamic> json) =>
      _$ArticleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleResponseToJson(this);
}




