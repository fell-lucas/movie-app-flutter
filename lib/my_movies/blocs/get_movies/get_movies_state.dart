part of 'get_movies_bloc.dart';

abstract class GetMoviesState extends Equatable {
  const GetMoviesState();

  @override
  List<Object> get props => [];
}

class GetMoviesInitial extends GetMoviesState {}

class GetMoviesLoadInProgress extends GetMoviesState {}

class GetMoviesLoadSuccessful extends GetMoviesState {
  final List<Movie> movies;

  const GetMoviesLoadSuccessful({
    required this.movies,
  });

  @override
  List<Object> get props => [movies];
}

class GetMoviesError extends GetMoviesState {
  final String error;

  const GetMoviesError({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
