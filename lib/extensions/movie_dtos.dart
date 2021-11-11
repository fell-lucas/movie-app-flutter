import 'package:movie_repository/movie_repository.dart';

extension AsUpdateMovieDto on Movie {
  UpdateMovieDto asUpdateMovieDto() {
    return UpdateMovieDto(imdbId: imdbId, watched: watched);
  }
}
