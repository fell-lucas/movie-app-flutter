part of 'search_movie_bloc.dart';

@immutable
abstract class SearchMovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchMovieInitial extends SearchMovieState {}

class SearchMovieLoadInProgress extends SearchMovieState {}

class SearchMovieLoadSuccessful extends SearchMovieState {
  final List<Movie> movies;

  SearchMovieLoadSuccessful({
    required this.movies,
  });

  @override
  List<Object?> get props => [movies];
}

class SearchMovieError extends SearchMovieState {
  final String error;

  SearchMovieError({
    required this.error,
  });

  @override
  List<Object?> get props => [error];
}
