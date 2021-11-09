import 'package:movie_repository/src/api/models/models.dart';

abstract class MovieRepository {
  Future<Movie> fetchMovies({required String fts});
}
