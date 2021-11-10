import 'package:movie_repository/src/api/api.dart';
import 'package:movie_repository/src/api/models/models.dart';

abstract class MovieRepository {
  Future<List<Movie>> searchMovies({required String fts});
}

class Repository extends MovieRepository {
  final MovieApi movieApi;

  Repository({
    required this.movieApi,
  });

  @override
  Future<List<Movie>> searchMovies({required String fts}) {
    return movieApi.searchMovies(fts: fts);
  }
}
