import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_flutter/movie_details/views/views.dart';
import 'package:movie_repository/movie_repository.dart';

part 'detailed_movie_event.dart';
part 'detailed_movie_state.dart';

class DetailedMovieBloc extends Bloc<DetailedMovieEvent, DetailedMovieState> {
  final MovieRepository movieRepository;

  DetailedMovieBloc({
    required this.movieRepository,
  }) : super(DetailedMovieInitial());

  @override
  Stream<DetailedMovieState> mapEventToState(DetailedMovieEvent event) async* {
    if (event is DetailedMovieGetDetails) {
      yield* _mapGetDetailsToState(event);
    }
  }

  Stream<DetailedMovieState> _mapGetDetailsToState(
      DetailedMovieGetDetails event) async* {
    yield DetailedMovieLoadInProgress();
    try {
      final detailedMovie =
          await movieRepository.getDetailedMovie(imdbId: event.movie.imdbId);
      yield DetailedMovieLoadSuccessful(movie: detailedMovie);
    } on HttpException catch (e) {
      yield DetailedMovieError(error: e.message);
    } catch (e) {
      yield const DetailedMovieError(error: 'Algo inesperado aconteceu.');
    }
  }
}
