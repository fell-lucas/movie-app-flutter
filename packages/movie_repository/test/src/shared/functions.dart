import 'dart:math';

import 'package:movie_repository/movie_repository.dart';

CreateMovieDto generateCreateMovie() {
  final rand = Random();
  var str = rand.nextInt(1000).toString();
  return CreateMovieDto(
    imdbId: str,
    watched: rand.nextBool(),
  );
}

Movie generateMovie() {
  final rand = Random();
  var str = rand.nextInt(1000).toString();
  return Movie(
    description: str,
    image: str,
    imdbId: str,
    title: str,
    watched: rand.nextBool(),
  );
}

DetailedMovieDto generateDetailedMovie() {
  final rand = Random();
  var str = rand.nextInt(1000).toString();
  return DetailedMovieDto(
    year: str,
    actorList: [Actor(id: str, name: str, image: str, asCharacter: str)],
    awards: str,
    directorList: [Director(id: str, name: str)],
    genres: str,
    id: str,
    imDbRating: str,
    keywordList: [str, str, str],
    languages: str,
    metacriticRating: str,
    plot: str,
    releaseDate: str,
    runtimeStr: str,
    image: str,
    title: str,
  );
}
