import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app_flutter/search/blocs/blocs.dart';
import 'package:movie_repository/movie_repository.dart';

import '../../../shared/functions.dart';

class MockRepository extends Mock implements MovieRepository {}

void main() {
  late SearchMovieBloc searchMovieBloc;
  late MovieRepository repository;
  setUp(() {
    repository = MockRepository();
    searchMovieBloc = SearchMovieBloc(movieRepository: repository);
  });

  group('SearchMovieBloc', () {
    List<Movie> movieList = [
      generateMovie(),
      generateMovie(),
      generateMovie(),
    ];
    const String errorString = 'error';
    test('Check initial state', () {
      expect(searchMovieBloc.state, SearchMovieInitial());
    });

    blocTest<SearchMovieBloc, SearchMovieState>(
      'emits [SearchMovieLoadInProgress, SearchMovieLoadSuccessful] when SearchMovies is added.',
      build: () {
        when(() => repository.searchMovies(fts: any(named: 'fts')))
            .thenAnswer((_) async => movieList);
        return searchMovieBloc;
      },
      act: (bloc) => bloc.add(SearchMovies(fts: 'abc')),
      expect: () => <SearchMovieState>[
        SearchMovieLoadInProgress(),
        SearchMovieLoadSuccessful(movies: movieList),
      ],
    );
    blocTest<SearchMovieBloc, SearchMovieState>(
      'emits [SearchMovieLoadInProgress, SearchMovieError] when SearchMovies is added.',
      build: () {
        when(() => repository.searchMovies(fts: any(named: 'fts')))
            .thenThrow(const HttpException(errorString));
        return searchMovieBloc;
      },
      act: (bloc) => bloc.add(SearchMovies(fts: 'abc')),
      expect: () => <SearchMovieState>[
        SearchMovieLoadInProgress(),
        SearchMovieError(error: errorString),
      ],
    );
  });
}
