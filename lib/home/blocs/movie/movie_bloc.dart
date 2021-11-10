import 'dart:html';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie_repository/movie_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  MovieBloc({
    required this.movieRepository,
  }) : super(MovieInitial());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    yield MovieLoadInProgress();
    if (event is SearchMovies) {
      yield* _mapSearchMoviesToState(event);
    }
  }

  Stream<MovieState> _mapSearchMoviesToState(SearchMovies event) async* {
    try {
      List<Movie> movies = await movieRepository.searchMovies(fts: event.fts);
      yield MovieSearchLoadSuccessful(movies: movies);
    } on HttpException catch (e) {
      yield MovieError(error: e.message);
    }
  }
}
