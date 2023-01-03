// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
    title: json['title'] as String?,
    date: json['date'] as String?,
    description: json['description'] as String?,
    rich_description: json['rich_description'] as String?,
    is_featured: json['is_featured'] as bool?,
    image: json['image'] as String?,
  )..id = json['_id'] as String?;
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'date': instance.date,
      'description': instance.description,
      'rich_description': instance.rich_description,
      'is_featured': instance.is_featured,
      'image': instance.image,
    };
