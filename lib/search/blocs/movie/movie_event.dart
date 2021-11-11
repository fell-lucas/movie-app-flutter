part of 'movie_bloc.dart';

@immutable
abstract class MovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchMovies extends MovieEvent {
  final String fts;

  SearchMovies({
    required this.fts,
  });

  @override
  List<Object?> get props => [fts];
}
