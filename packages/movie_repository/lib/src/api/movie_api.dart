import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'models/models.dart';

const String kApiUrl = 'https://192.168.1.7:5001';

class MovieApi {
  final http.Client _client;

  MovieApi({http.Client? client}) : _client = client ?? http.Client();

  Future<List<Movie>> searchMovies({required String fts}) async {
    final result = await _client.get(
      Uri.parse('$kApiUrl/movies/search?fts=$fts'),
    );

    if (result.statusCode != 200) {
      throw const HttpException('Erro ao conectar com a API.');
    }

    List<dynamic> moviesDynamic = jsonDecode(result.body);
    final movies = moviesDynamic.map((movie) => Movie.fromJson(movie)).toList();
    return movies;
  }

  Future<Movie> createMovie({required CreateMovieDto movie}) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final result = await _client.post(
      Uri.parse('$kApiUrl/movies'),
      headers: headers,
      body: jsonEncode({"imdbId": movie.imdbId, "watched": movie.watched}),
    );
    if (result.statusCode == 409) {
      throw const HttpException('Filme já adicionado.');
    } else if (result.statusCode != 201) {
      throw const HttpException('Erro ao conectar com a API.');
    }

    return Movie.fromJson(jsonDecode(result.body));
  }

  Future<List<Movie>> getMovies() async {
    final result = await _client.get(Uri.parse('$kApiUrl/movies'));

    if (result.statusCode != 200) {
      throw const HttpException('Erro ao conectar com a API.');
    }

    List<dynamic> moviesDynamic = jsonDecode(result.body);
    final movies = moviesDynamic.map((movie) => Movie.fromJson(movie)).toList();
    return movies;
  }

  Future<void> updateMovie({required UpdateMovieDto movie}) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final result = await _client.put(
      Uri.parse('$kApiUrl/movies/${movie.imdbId}'),
      headers: headers,
      body: jsonEncode({"watched": movie.watched}),
    );

    if (result.statusCode != 204) {
      throw const HttpException('Erro ao conectar com a API.');
    }
  }
}
