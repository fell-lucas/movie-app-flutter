part of 'movie_bloc.dart';

@immutable
abstract class MovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoadInProgress extends MovieState {}

class MovieSearchLoadSuccessful extends MovieState {
  final List<Movie> movies;

  MovieSearchLoadSuccessful({
    required this.movies,
  });

  @override
  List<Object?> get props => [movies];
}

class MovieCreateLoadSuccessful extends MovieState {
  final Movie movie;

  MovieCreateLoadSuccessful({
    required this.movie,
  });

  @override
  List<Object?> get props => [movie];
}

class MovieError extends MovieState {
  final String error;

  MovieError({
    required this.error,
  });

  @override
  List<Object?> get props => [error];
}
