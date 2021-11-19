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
    setUp(() {
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
    test('error', () async {
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
}
