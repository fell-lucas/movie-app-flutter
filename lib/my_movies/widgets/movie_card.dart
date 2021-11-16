import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_flutter/main.dart';
import 'package:movie_app_flutter/movie_details/bloc/detailed_movie/detailed_movie_bloc.dart';
import 'package:movie_app_flutter/movie_details/views/views.dart';
import 'package:movie_app_flutter/my_movies/blocs/blocs.dart';
import 'package:movie_repository/movie_repository.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'movieImage-${movie.imdbId}',
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Ink.image(
          colorFilter: !movie.watched
              ? ColorFilter.mode(
                  Colors.black.withOpacity(0.7),
                  BlendMode.multiply,
                )
              : null,
          image: NetworkImage(movie.image),
          fit: BoxFit.fill,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => DetailedMovieBloc(
                      movieRepository: getIt<MovieRepository>(),
                    ),
                    child: MovieDetailsPage(
                      movie: movie,
                    ),
                  ),
                ),
              );
            },
            onLongPress: () {
              BlocProvider.of<MyListBloc>(context).add(
                MyListUpdateOne(
                  movie: UpdateMovieDto(
                    imdbId: movie.imdbId,
                    watched: !movie.watched,
                  ),
                ),
              );
              BlocProvider.of<MyListBloc>(context).add(MyListGetAll());
            },
            child: Container(
              alignment: Alignment.bottomLeft,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                    width: double.maxFinite,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        movie.title,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 5,
        margin: const EdgeInsets.all(5),
      ),
    );
  }
}
