import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_repository/movie_repository.dart';

import 'package:movie_app_flutter/search/blocs/blocs.dart';

class MovieTile extends StatelessWidget {
  final Movie movie;

  const MovieTile({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateMovieBloc, CreateMovieState>(
      builder: (context, state) {
        return ListTile(
          key: Key(movie.imdbId),
          leading: Image.network(movie.image),
          title: Text(movie.title),
          subtitle: Text(movie.description),
          trailing: IconButton(
            icon: (state is CreateMovieLoadInProgress &&
                    state.imdbId == movie.imdbId)
                ? SizedBox(
                    width: 15,
                    height: 15,
                    child: CircularProgressIndicator(
                      key: Key('individual_loading_indicator_${movie.imdbId}'),
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(Icons.add),
            onPressed: () {
              BlocProvider.of<CreateMovieBloc>(context).add(
                CreateMovie(
                  movie: CreateMovieDto(
                    imdbId: movie.imdbId,
                    watched: false,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
