import 'dart:io';
import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app_flutter/search/blocs/blocs.dart';
import 'package:movie_app_flutter/search/views/search_page.dart';
import 'package:movie_repository/movie_repository.dart';

import '../../shared/shared.dart';

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
  late CreateMovieBloc realCreateMovieBloc;
  late CreateMovieBloc mockedCreateMovieBloc;
  late SearchMovieBloc searchMovieBloc;
  late MovieRepository repository;
  Movie movieToAdd = generateMovie();
  CreateMovieDto createMovieDto = CreateMovieDto(
    imdbId: movieToAdd.imdbId,
    watched: movieToAdd.watched,
  );

  setUpAll(() {
    HttpOverrides.global = null;
    registerFallbackValue(createMovieDto);
    registerFallbackValue(FakeSearchMovieEvent());
    registerFallbackValue(FakeSearchMovieState());
    registerFallbackValue(FakeCreateMovieEvent());
    registerFallbackValue(FakeCreateMovieState());
  });

  setUp(() {
    repository = MockRepository();
    realCreateMovieBloc = CreateMovieBloc(movieRepository: repository);
    mockedCreateMovieBloc = MockCreateMovieBloc();
    searchMovieBloc = MockSearchMovieBloc();
    when(() => searchMovieBloc.state).thenReturn(SearchMovieInitial());
    when(() => mockedCreateMovieBloc.state).thenReturn(CreateMovieInitial());
  });

  Widget createWidgetUnderTest({bool realCreateBloc = true}) {
    return (MaterialApp(
      home: Material(
        child: Scaffold(
          body: SearchPage(
            createMovieBloc:
                realCreateBloc ? realCreateMovieBloc : mockedCreateMovieBloc,
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
    realCreateMovieBloc.emit(CreateMovieLoadSuccessful(movie: movieToAdd));
    await tester.pump();
    expect(find.text(snackbarText), findsOneWidget);
  });
  testWidgets('snackbar called on error', (tester) async {
    // Arrange
    const snackbarText = 'error';
    // Act
    await tester.pumpWidget(createWidgetUnderTest());
    // Assert
    expect(find.text(snackbarText), findsNothing);
    realCreateMovieBloc.emit(const CreateMovieError(error: snackbarText));
    await tester.pump();
    expect(find.text(snackbarText), findsOneWidget);
  });

  testWidgets('loading indicator on SearchMovieLoadInProgress', (tester) async {
    when(() => searchMovieBloc.state).thenReturn(SearchMovieLoadInProgress());
    await tester.pumpWidget(createWidgetUnderTest());
    final loadIndicator = find.byKey(const Key('search_load_indicator'));
    expect(loadIndicator, findsOneWidget);
  });

  testWidgets('error message on SearchMovieError', (tester) async {
    const String error = 'error';
    when(() => searchMovieBloc.state)
        .thenReturn(SearchMovieError(error: error));
    await tester.pumpWidget(createWidgetUnderTest());
    final loadIndicator = find.byKey(const Key('search_error'));
    expect(loadIndicator, findsOneWidget);
  });

  testWidgets('loading indicator on CreateMovieLoadInProgress', (tester) async {
    when(() => mockedCreateMovieBloc.state)
        .thenReturn(CreateMovieLoadInProgress(
      imdbId: movieToAdd.imdbId,
    ));
    when(() => searchMovieBloc.state).thenReturn(SearchMovieLoadSuccessful(
      movies: [
        movieToAdd,
        generateMovie(),
        generateMovie(),
      ],
    ));
    await tester.pumpWidget(createWidgetUnderTest(realCreateBloc: false));
    final loadIndicator = find.byKey(
      Key('individual_loading_indicator_${movieToAdd.imdbId}'),
    );
    expect(loadIndicator, findsOneWidget);
  });
}
