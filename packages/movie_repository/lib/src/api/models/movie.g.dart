// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      imdbId: json['imdbId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      watched: json['watched'] as bool,
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'imdbId': instance.imdbId,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'watched': instance.watched,
    };
