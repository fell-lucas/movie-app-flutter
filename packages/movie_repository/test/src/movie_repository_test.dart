import 'dart:convert';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_repository/movie_repository.dart';

class MockMovieApi extends Mock implements MovieApi {}

void main() {
  late MovieApi api;
  late MovieRepository repository;
  var rand = Random();

  setUp(() {
    api = MockMovieApi();
    repository = Repository(movieApi: api);
  });

  setUpAll(() {
    registerFallbackValue(const UpdateMovieDto(imdbId: 'a', watched: false));
  });

  Movie generateMovie() {
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

  test('searchMovies', () async {
    var movieList = List.generate(10, (i) {
      return generateMovie();
    });
    when(() => api.searchMovies(fts: any(named: 'fts')))
        .thenAnswer((_) async => movieList);
    List<Movie> repositoryMovies = await repository.searchMovies(fts: 'abc');
    expect(repositoryMovies, movieList);
  });

  test('getMovies', () async {
    var movieList = List.generate(10, (i) {
      return generateMovie();
    });
    when(() => api.getMovies()).thenAnswer((_) async => movieList);
    List<Movie> repositoryMovies = await repository.getMovies();
    expect(repositoryMovies, movieList);
  });

  test('createMovie', () async {
    var createdMovie = generateMovie();
    var movieToCreate = CreateMovieDto(
      imdbId: createdMovie.imdbId,
      watched: createdMovie.watched,
    );
    when(() => api.createMovie(movie: movieToCreate))
        .thenAnswer((_) async => createdMovie);
    Movie repositoryMovie = await repository.createMovie(movie: movieToCreate);
    expect(repositoryMovie, createdMovie);
  });

  test('updateMovie', () async {
    var movieToUpdate = UpdateMovieDto(
      imdbId: generateMovie().imdbId,
      watched: generateMovie().watched,
    );
    when(() => api.updateMovie(movie: any(named: 'movie')))
        .thenAnswer((_) async {
      return;
    });
    await repository.updateMovie(movie: movieToUpdate);
    verify(() => api.updateMovie(movie: any(named: 'movie'))).called(1);
  });

  test('getDetailedMovie', () async {
    var detailedMovie = generateDetailedMovie();
    when(() => api.getDetailedMovie(imdbId: any(named: 'imdbId')))
        .thenAnswer((_) async => detailedMovie);
    var repositoryDetailedMovie = await repository.getDetailedMovie(
      imdbId: detailedMovie.id,
    );
    expect(detailedMovie, repositoryDetailedMovie);
  });
}
