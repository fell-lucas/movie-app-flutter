import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'models/models.dart';

const String kApiUrl = 'http://192.168.1.7:5000';

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
    final result = await _client.post(
      Uri.parse('$kApiUrl/movies'),
      body: movie.toJson(),
    );

    if (result.statusCode != 200) {
      throw const HttpException('Erro ao conectar com a API.');
    }

    return Movie.fromJson(jsonDecode(result.body));
  }
}
