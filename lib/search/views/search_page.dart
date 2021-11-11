import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_flutter/main.dart';
import 'package:movie_app_flutter/search/blocs/blocs.dart';
import 'package:movie_app_flutter/search/widgets/widgets.dart';
import 'package:movie_repository/movie_repository.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreateMovieBloc(
            movieRepository: getIt<MovieRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => SearchMovieBloc(
            movieRepository: getIt<MovieRepository>(),
          ),
        ),
      ],
      child: BlocListener<CreateMovieBloc, CreateMovieState>(
        listener: (context, state) {
          ScaffoldMessenger.of(context).clearSnackBars();
          if (state is CreateMovieLoadSuccessful) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text('${state.movie.title} salvo na watchlist!'),
              ),
            );
          } else if (state is CreateMovieError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.error),
              ),
            );
          }
        },
        child: Column(
          children: [
            MovieSearch(),
            const SizedBox(height: 15.0),
            const MovieList()
          ],
        ),
      ),
    );
  }
}
