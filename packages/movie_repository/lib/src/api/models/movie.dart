import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie extends Equatable {
  final String imdbId;
  final String title;
  final String description;
  final String image;
  final bool watched;

  const Movie({
    required this.imdbId,
    required this.title,
    required this.description,
    required this.image,
    required this.watched,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);

  @override
  List<Object> get props {
    return [
      imdbId,
      title,
      description,
      image,
      watched,
    ];
  }
}
