import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_movie_dto.g.dart';

@JsonSerializable()
class UpdateMovieDto extends Equatable {
  final String imdbId;
  final bool watched;

  const UpdateMovieDto({
    required this.imdbId,
    required this.watched,
  });

  factory UpdateMovieDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateMovieDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateMovieDtoToJson(this);

  @override
  List<Object> get props {
    return [
      imdbId,
      watched,
    ];
  }
}
