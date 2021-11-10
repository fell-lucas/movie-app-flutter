import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'models/models.dart';

const String kApiUrl = '';

class MovieApi {
  final http.Client _client;

  MovieApi({http.Client? client}) : _client = client ?? http.Client();

  Future<List<Movie>> searchMovies({required String fts}) async {
    final result = await _client.get(
      Uri.parse('https://localhost:5001/movies/search?fts=chucky'),
    );

    if (result.statusCode != 200) {
      throw const HttpException('Erro ao conectar com a API.');
    }

    List<Movie> movies = jsonDecode(result.body);
    return movies;
  }
}
