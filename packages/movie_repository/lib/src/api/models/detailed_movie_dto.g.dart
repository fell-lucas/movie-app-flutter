// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detailed_movie_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailedMovieDto _$DetailedMovieDtoFromJson(Map<String, dynamic> json) =>
    DetailedMovieDto(
      id: json['id'] as String,
      year: json['year'] as String,
      title: json['title'] as String,
      image: json['image'] as String,
      releaseDate: json['releaseDate'] as String,
      runtimeStr: json['runtimeStr'] as String,
      plot: json['plot'] as String,
      awards: json['awards'] as String,
      directorList: (json['directorList'] as List<dynamic>)
          .map((e) => Director.fromJson(e as Map<String, dynamic>))
          .toList(),
      actorList: (json['actorList'] as List<dynamic>)
          .map((e) => Actor.fromJson(e as Map<String, dynamic>))
          .toList(),
      genres: json['genres'] as String,
      languages: json['languages'] as String,
      imDbRating: json['imDbRating'] as String,
      metacriticRating: json['metacriticRating'] as String,
      keywordList: (json['keywordList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$DetailedMovieDtoToJson(DetailedMovieDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'year': instance.year,
      'title': instance.title,
      'image': instance.image,
      'releaseDate': instance.releaseDate,
      'runtimeStr': instance.runtimeStr,
      'plot': instance.plot,
      'awards': instance.awards,
      'directorList': instance.directorList,
      'actorList': instance.actorList,
      'genres': instance.genres,
      'languages': instance.languages,
      'imDbRating': instance.imDbRating,
      'metacriticRating': instance.metacriticRating,
      'keywordList': instance.keywordList,
    };

Director _$DirectorFromJson(Map<String, dynamic> json) => Director(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$DirectorToJson(Director instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Actor _$ActorFromJson(Map<String, dynamic> json) => Actor(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      asCharacter: json['asCharacter'] as String,
    );

Map<String, dynamic> _$ActorToJson(Actor instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'asCharacter': instance.asCharacter,
    };
