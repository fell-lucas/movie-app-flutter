part of 'create_movie_bloc.dart';

@immutable
abstract class CreateMovieState extends Equatable {
  const CreateMovieState();

  @override
  List<Object?> get props => [];
}

class CreateMovieInitial extends CreateMovieState {}

class CreateMovieLoadInProgress extends CreateMovieState {
  final String imdbId;

  const CreateMovieLoadInProgress({
    required this.imdbId,
  });

  @override
  List<Object?> get props => [imdbId];
}

class CreateMovieLoadSuccessful extends CreateMovieState {
  final Movie movie;

  const CreateMovieLoadSuccessful({
    required this.movie,
  });

  @override
  List<Object?> get props => [movie];
}

class CreateMovieError extends CreateMovieState {
  final String error;

  const CreateMovieError({
    required this.error,
  });

  @override
  List<Object?> get props => [error];
}
