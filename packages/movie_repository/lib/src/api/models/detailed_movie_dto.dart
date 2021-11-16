import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detailed_movie_dto.g.dart';

@JsonSerializable()
class DetailedMovieDto extends Equatable {
  final String id;
  final String year;
  final String title;
  final String image;
  final String releaseDate;
  final String runtimeStr;
  final String plot;
  final String awards;
  final List<Director> directorList;
  final List<Actor> actorList;
  final String genres;
  final String languages;
  final String imDbRating;
  final String metacriticRating;
  final List<String> keywordList;

  const DetailedMovieDto({
    required this.id,
    required this.year,
    required this.title,
    required this.image,
    required this.releaseDate,
    required this.runtimeStr,
    required this.plot,
    required this.awards,
    required this.directorList,
    required this.actorList,
    required this.genres,
    required this.languages,
    required this.imDbRating,
    required this.metacriticRating,
    required this.keywordList,
  });

  factory DetailedMovieDto.fromJson(Map<String, dynamic> json) =>
      _$DetailedMovieDtoFromJson(json);
  Map<String, dynamic> toJson() => _$DetailedMovieDtoToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      year,
      title,
      image,
      releaseDate,
      runtimeStr,
      plot,
      awards,
      directorList,
      actorList,
      genres,
      languages,
      imDbRating,
      metacriticRating,
      keywordList,
    ];
  }
}

@JsonSerializable()
class Director extends Equatable {
  final String id;
  final String name;

  const Director({
    required this.id,
    required this.name,
  });

  factory Director.fromJson(Map<String, dynamic> json) =>
      _$DirectorFromJson(json);
  Map<String, dynamic> toJson() => _$DirectorToJson(this);

  @override
  List<Object?> get props => [id, name];
}

@JsonSerializable()
class Actor extends Equatable {
  final String id;
  final String name;
  final String image;
  final String asCharacter;

  const Actor({
    required this.id,
    required this.name,
    required this.image,
    required this.asCharacter,
  });

  factory Actor.fromJson(Map<String, dynamic> json) => _$ActorFromJson(json);
  Map<String, dynamic> toJson() => _$ActorToJson(this);

  @override
  List<Object?> get props => [id, name, image, asCharacter];
}
