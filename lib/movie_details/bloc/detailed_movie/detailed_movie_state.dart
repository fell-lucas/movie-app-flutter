part of 'detailed_movie_bloc.dart';

abstract class DetailedMovieState extends Equatable {
  const DetailedMovieState();

  @override
  List<Object> get props => [];
}

class DetailedMovieInitial extends DetailedMovieState {}

class DetailedMovieLoadInProgress extends DetailedMovieState {}

class DetailedMovieLoadSuccessful extends DetailedMovieState {
  final DetailedMovieDto movie;

  const DetailedMovieLoadSuccessful({
    required this.movie,
  });

  @override
  List<Object> get props => [movie];
}

class DetailedMovieError extends DetailedMovieState {
  final String error;

  const DetailedMovieError({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
