import 'dart:math';

import 'package:movie_repository/movie_repository.dart';

Movie generateMovie() {
  final rand = Random();
  var str = rand.nextInt(1000).toString();
  return Movie(
    description: str,
    image: 'http://example.com',
    imdbId: str,
    title: str,
    watched: rand.nextBool(),
  );
}
