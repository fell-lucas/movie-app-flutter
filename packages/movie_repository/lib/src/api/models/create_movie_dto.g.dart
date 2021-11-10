// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_movie_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateMovieDto _$CreateMovieDtoFromJson(Map<String, dynamic> json) =>
    CreateMovieDto(
      imdbId: json['imdbId'] as String,
      watched: json['watched'] as bool,
    );

Map<String, dynamic> _$CreateMovieDtoToJson(CreateMovieDto instance) =>
    <String, dynamic>{
      'imdbId': instance.imdbId,
      'watched': instance.watched,
    };
