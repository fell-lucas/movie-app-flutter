// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_movie_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateMovieDto _$UpdateMovieDtoFromJson(Map<String, dynamic> json) =>
    UpdateMovieDto(
      imdbId: json['imdbId'] as String,
      watched: json['watched'] as bool,
    );

Map<String, dynamic> _$UpdateMovieDtoToJson(UpdateMovieDto instance) =>
    <String, dynamic>{
      'imdbId': instance.imdbId,
      'watched': instance.watched,
    };
