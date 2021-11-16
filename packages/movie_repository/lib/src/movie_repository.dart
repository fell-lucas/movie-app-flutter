import 'package:movie_repository/src/api/api.dart';
import 'package:movie_repository/src/api/models/detailed_movie_dto.dart';
import 'package:movie_repository/src/api/models/models.dart';

abstract class MovieRepository {
  Future<List<Movie>> searchMovies({required String fts});
  Future<List<Movie>> getMovies();
  Future<Movie> createMovie({required CreateMovieDto movie});
  Future<void> updateMovie({required UpdateMovieDto movie});
  Future<DetailedMovieDto> getDetailedMovie({required String imdbId});
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

  @override
  Future<void> updateMovie({required UpdateMovieDto movie}) {
    return movieApi.updateMovie(movie: movie);
  }

  @override
  Future<DetailedMovieDto> getDetailedMovie({required String imdbId}) {
    return movieApi.getDetailedMovie(imdbId: imdbId);
  }
}
