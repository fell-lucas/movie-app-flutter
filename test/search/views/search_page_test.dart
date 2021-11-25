import 'dart:io';
import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app_flutter/search/blocs/blocs.dart';
import 'package:movie_app_flutter/search/views/search_page.dart';
import 'package:movie_repository/movie_repository.dart';

class MockCreateMovieBloc extends MockBloc<CreateMovieEvent, CreateMovieState>
    implements CreateMovieBloc {}

class MockSearchMovieBloc extends MockBloc<SearchMovieEvent, SearchMovieState>
    implements SearchMovieBloc {}

class MockRepository extends Mock implements MovieRepository {}

class FakeSearchMovieEvent extends Fake implements SearchMovieEvent {}

class FakeSearchMovieState extends Fake implements SearchMovieState {}

class FakeCreateMovieEvent extends Fake implements CreateMovieEvent {}

class FakeCreateMovieState extends Fake implements CreateMovieState {}

void main() {
  Movie generateMovie() {
    final rand = Random();
    var str = rand.nextInt(1000).toString();
    return Movie(
      description: str,
      image: 'http://example.com',
      imdbId: str,
      title: str,
      watched: rand.nextBool(),
    );
  }

  late CreateMovieBloc createMovieBloc;
  late SearchMovieBloc searchMovieBloc;
  late MovieRepository repository;
  Movie movieToAdd = generateMovie();
  CreateMovieDto createMovieDto = CreateMovieDto(
    imdbId: movieToAdd.imdbId,
    watched: movieToAdd.watched,
  );

  setUpAll(() {
    HttpOverrides.global = null;
    repository = MockRepository();
    registerFallbackValue(createMovieDto);
    registerFallbackValue(FakeSearchMovieEvent());
    registerFallbackValue(FakeSearchMovieState());
    registerFallbackValue(FakeCreateMovieEvent());
    registerFallbackValue(FakeCreateMovieState());
    createMovieBloc = CreateMovieBloc(movieRepository: repository);
    searchMovieBloc = MockSearchMovieBloc();
    // when(() => createMovieBloc.state).thenReturn(CreateMovieInitial());
    when(() => searchMovieBloc.state).thenReturn(SearchMovieInitial());
  });

  Widget createWidgetUnderTest() {
    return (MaterialApp(
      home: Material(
        child: Scaffold(
          body: SearchPage(
            createMovieBloc: createMovieBloc,
            searchMovieBloc: searchMovieBloc,
          ),
        ),
      ),
    ));
  }

  testWidgets('snackbar called on success', (tester) async {
    // Arrange
    var movieToAdd = generateMovie();
    when(() => repository.createMovie(movie: any(named: 'movie')))
        .thenAnswer((_) async => movieToAdd);
    var snackbarText = '${movieToAdd.title} added to watchlist!';
    // Act
    await tester.pumpWidget(createWidgetUnderTest());
    // Assert
    expect(find.text(snackbarText), findsNothing);
    createMovieBloc.emit(CreateMovieLoadSuccessful(movie: movieToAdd));
    await tester.pump();
    expect(find.text(snackbarText), findsOneWidget);
  });
  testWidgets('loading indicator on SearchMovieLoadInProgress', (tester) async {
    when(() => searchMovieBloc.state).thenReturn(SearchMovieLoadInProgress());
    await tester.pumpWidget(createWidgetUnderTest());
    final loadIndicator = find.byKey(const Key('search_load_indicator'));
    expect(loadIndicator, findsOneWidget);
  });
}
