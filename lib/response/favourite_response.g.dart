// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavouriteResponse _$FavouriteResponseFromJson(Map<String, dynamic> json) {
  return FavouriteResponse(
    success: json['success'] as bool?,
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => Favourite.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FavouriteResponseToJson(FavouriteResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
