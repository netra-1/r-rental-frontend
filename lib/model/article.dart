import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable()
class Article {
  @JsonKey(name: '_id')
  String? id;
  String? title;
  String? date;
  String? description;
  String? rich_description;
  bool? is_featured;
  String? image;
  Article({
    this.title,
    this.date,
    this.description,
    this.rich_description,
    this.is_featured,
    this.image,
  });
  factory Article.fromJson(Map<String, dynamic> json) {
    return _$ArticleFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
