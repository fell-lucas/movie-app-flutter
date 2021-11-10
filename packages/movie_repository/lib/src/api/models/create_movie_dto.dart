import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_movie_dto.g.dart';

@JsonSerializable()
class CreateMovieDto extends Equatable {
  final String imdbId;
  final bool watched;

  const CreateMovieDto({
    required this.imdbId,
    required this.watched,
  });

  factory CreateMovieDto.fromJson(Map<String, dynamic> json) =>
      _$CreateMovieDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CreateMovieDtoToJson(this);

  @override
  List<Object> get props {
    return [
      imdbId,
      watched,
    ];
  }
}
