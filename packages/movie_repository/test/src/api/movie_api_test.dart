import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:movie_repository/movie_repository.dart';
import '../shared/functions.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late http.Client mockedClient;
  late Map<String, http.Response> mockedResponses;
  late MovieApi api;

  setUpAll(() {
    mockedClient = MockHttpClient();
    api = MovieApi(client: mockedClient);
    registerFallbackValue(Uri.parse(''));
  });

  group('searchMovies', () {
    setUpAll(() {
      mockedResponses = {
        'success': http.Response(
          jsonEncode([
            generateMovie(),
            generateMovie(),
            generateMovie(),
          ]),
          200,
        ),
        'empty': http.Response('[]', 200),
        'error': http.Response('', 404)
      };
    });
    test('success', () async {
      when(() => mockedClient.get(any()))
          .thenAnswer((_) async => mockedResponses['success']!);
      var movies = await api.searchMovies(fts: '');
      expect(jsonEncode(movies), mockedResponses['success']!.body);
    });
    test('error', () {
      when(() => mockedClient.get(any()))
          .thenAnswer((_) async => mockedResponses['error']!);
      expect(() => api.searchMovies(fts: ''), throwsA(isA<HttpException>()));
    });
    test('empty', () async {
      when(() => mockedClient.get(any()))
          .thenAnswer((_) async => mockedResponses['empty']!);
      var movies = await api.searchMovies(fts: '');
      expect(movies, []);
    });
  });
  group('createMovie', () {
    setUpAll(() {
      mockedResponses = {
        'success': http.Response(jsonEncode(generateMovie()), 201),
        'error': http.Response('', 409)
      };
    });
    test('success', () async {
      when(() => mockedClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => mockedResponses['success']!);
      var movieToCreate = Movie.fromJson(
        jsonDecode(mockedResponses['success']!.body),
      );
      var createdMovie = await api.createMovie(
          movie: CreateMovieDto(
        imdbId: movieToCreate.imdbId,
        watched: movieToCreate.watched,
      ));
      expect(movieToCreate.imdbId, createdMovie.imdbId);
    });
    test('error', () async {
      when(() => mockedClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => mockedResponses['error']!);
      expect(
        () => api.createMovie(movie: generateCreateMovie()),
        throwsA(
          isA<HttpException>(),
        ),
      );
    });
  });

  group('getMovies', () {
    setUpAll(() {
      mockedResponses = {
        'success': http.Response(
          jsonEncode([
            generateMovie(),
            generateMovie(),
            generateMovie(),
          ]),
          200,
        ),
        'empty': http.Response('[]', 200),
        'error': http.Response('', 404)
      };
    });
    test('success', () async {
      when(() => mockedClient.get(any()))
          .thenAnswer((_) async => mockedResponses['success']!);
      var movies = await api.getMovies();
      expect(jsonEncode(movies), mockedResponses['success']!.body);
    });
    test('error', () {
      when(() => mockedClient.get(any()))
          .thenAnswer((_) async => mockedResponses['error']!);
      expect(() async => await api.getMovies(), throwsA(isA<HttpException>()));
    });
    test('empty', () async {
      when(() => mockedClient.get(any()))
          .thenAnswer((_) async => mockedResponses['empty']!);
      var movies = await api.getMovies();
      expect(movies, []);
    });
  });

  group('updateMovie', () {
    setUpAll(() {
      mockedResponses = {
        'success': http.Response('', 204),
        'error': http.Response('', 404)
      };
    });
    test('success', () {
      when(() => mockedClient.put(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => mockedResponses['success']!);
      expect(
        () async => await api.updateMovie(movie: generateUpdateMovie()),
        isA<void>(),
      );
    });
    test('error', () async {
      when(() => mockedClient.put(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => mockedResponses['error']!);
      expect(
        () async => await api.updateMovie(movie: generateUpdateMovie()),
        throwsA(
          isA<HttpException>(),
        ),
      );
    });
  });
}
