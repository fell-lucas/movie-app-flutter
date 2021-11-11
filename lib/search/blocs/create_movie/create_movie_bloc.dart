import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_repository/movie_repository.dart';

part 'create_movie_event.dart';
part 'create_movie_state.dart';

class CreateMovieBloc extends Bloc<CreateMovieEvent, CreateMovieState> {
  final MovieRepository movieRepository;

  CreateMovieBloc({
    required this.movieRepository,
  }) : super(CreateMovieInitial());

  @override
  Stream<CreateMovieState> mapEventToState(CreateMovieEvent event) async* {
    if (event is CreateMovie) {
      yield CreateMovieLoadInProgress(imdbId: event.movie.imdbId);
      yield* _mapCreateMovieToState(event);
    }
  }

  Stream<CreateMovieState> _mapCreateMovieToState(CreateMovie event) async* {
    try {
      Movie movie = await movieRepository.createMovie(movie: event.movie);
      yield CreateMovieLoadSuccessful(movie: movie);
    } on HttpException catch (e) {
      yield CreateMovieError(error: e.message);
    }
  }
}
