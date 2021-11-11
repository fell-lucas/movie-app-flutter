import 'package:movie_repository/src/api/api.dart';
import 'package:movie_repository/src/api/models/models.dart';

abstract class MovieRepository {
  Future<List<Movie>> searchMovies({required String fts});
  Future<List<Movie>> getMovies();
  Future<Movie> createMovie({required CreateMovieDto movie});
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

  @override
  Future<List<Movie>> getMovies() {
    return movieApi.getMovies();
  }

  @override
  Future<Movie> createMovie({required CreateMovieDto movie}) {
    return movieApi.createMovie(movie: movie);
  }
}
