import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app_flutter/search/blocs/blocs.dart';
import 'package:movie_repository/movie_repository.dart';

import '../../../shared/functions.dart';

class MockRepository extends Mock implements MovieRepository {}

void main() {
  late CreateMovieBloc createMovieBloc;
  late MovieRepository repository;
  Movie movieToCreate = generateMovie();
  const String errorString = 'error';

  setUpAll(() {
    registerFallbackValue(generateCreateMovie());
  });

  setUp(() {
    repository = MockRepository();
    createMovieBloc = CreateMovieBloc(movieRepository: repository);
  });

  test('Check initial state', () {
    expect(createMovieBloc.state, CreateMovieInitial());
  });

  blocTest<CreateMovieBloc, CreateMovieState>(
    'emits [CreateMovieLoadInProgress, CreateMovieLoadSuccessful] when CreateMovie is added.',
    build: () {
      when(() => repository.createMovie(movie: any(named: 'movie')))
          .thenAnswer((_) async => movieToCreate);
      return createMovieBloc;
    },
    act: (bloc) => bloc.add(CreateMovie(
      movie: CreateMovieDto(
        imdbId: movieToCreate.imdbId,
        watched: movieToCreate.watched,
      ),
    )),
    expect: () => <CreateMovieState>[
      CreateMovieLoadInProgress(imdbId: movieToCreate.imdbId),
      CreateMovieLoadSuccessful(movie: movieToCreate)
    ],
  );

  blocTest<CreateMovieBloc, CreateMovieState>(
    'emits [CreateMovieLoadInProgress, CreateMovieError] when CreateMovie is added.',
    build: () {
      when(() => repository.createMovie(movie: any(named: 'movie')))
          .thenThrow(const HttpException(errorString));
      return createMovieBloc;
    },
    act: (bloc) => bloc.add(CreateMovie(
      movie: CreateMovieDto(
        imdbId: movieToCreate.imdbId,
        watched: movieToCreate.watched,
      ),
    )),
    expect: () => <CreateMovieState>[
      CreateMovieLoadInProgress(imdbId: movieToCreate.imdbId),
      const CreateMovieError(error: errorString)
    ],
  );
}
