import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_flutter/search/blocs/blocs.dart';
import 'package:movie_app_flutter/search/widgets/widgets.dart';

class MovieList extends StatelessWidget {
  const MovieList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieSearchLoadSuccessful) {
            return ListView(
              children:
                  state.movies.map((movie) => MovieTile(movie: movie)).toList(),
            );
          } else if (state is MovieLoadInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieError) {
            return Center(
              child: Text(
                state.error,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 24.0,
                ),
              ),
            );
          } else {
            return const Center(
              child: Text(
                'Search the movies you always wanted to watch and add them to your watchlist',
                textAlign: TextAlign.center,
              ),
            );
          }
        },
      ),
    );
  }
}
