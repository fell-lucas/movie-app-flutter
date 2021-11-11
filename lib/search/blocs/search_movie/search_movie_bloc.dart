import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie_repository/movie_repository.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final MovieRepository movieRepository;

  SearchMovieBloc({
    required this.movieRepository,
  }) : super(SearchMovieInitial());

  @override
  Stream<SearchMovieState> mapEventToState(SearchMovieEvent event) async* {
    yield SearchMovieLoadInProgress();
    if (event is SearchMovies) {
      yield* _mapSearchMoviesToState(event);
    }
  }

  Stream<SearchMovieState> _mapSearchMoviesToState(SearchMovies event) async* {
    try {
      List<Movie> movies = await movieRepository.searchMovies(fts: event.fts);
      yield SearchMovieLoadSuccessful(movies: movies);
    } on HttpException catch (e) {
      yield SearchMovieError(error: e.message);
    }
  }
}
