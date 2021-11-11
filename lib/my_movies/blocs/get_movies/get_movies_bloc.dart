import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_repository/movie_repository.dart';

part 'get_movies_event.dart';
part 'get_movies_state.dart';

class GetMoviesBloc extends Bloc<GetMoviesEvent, GetMoviesState> {
  final MovieRepository movieRepository;

  GetMoviesBloc({
    required this.movieRepository,
  }) : super(GetMoviesInitial());

  @override
  Stream<GetMoviesState> mapEventToState(GetMoviesEvent event) async* {
    yield GetMoviesLoadInProgress();
    if (event is GetMovies) {
      yield* _mapGetMoviesToState(event);
    }
  }

  Stream<GetMoviesState> _mapGetMoviesToState(GetMovies event) async* {
    try {
      final movies = await movieRepository.getMovies();
      yield GetMoviesLoadSuccessful(movies: movies);
    } on HttpException catch (e) {
      yield GetMoviesError(error: e.message);
    }
  }
}
