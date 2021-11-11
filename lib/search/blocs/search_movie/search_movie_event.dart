part of 'search_movie_bloc.dart';

@immutable
abstract class SearchMovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchMovies extends SearchMovieEvent {
  final String fts;

  SearchMovies({
    required this.fts,
  });

  @override
  List<Object?> get props => [fts];
}
