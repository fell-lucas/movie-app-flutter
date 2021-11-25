import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_flutter/search/blocs/blocs.dart';
import 'package:movie_app_flutter/search/widgets/widgets.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    Key? key,
    required this.createMovieBloc,
    required this.searchMovieBloc,
  }) : super(key: key);

  final CreateMovieBloc createMovieBloc;
  final SearchMovieBloc searchMovieBloc;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CreateMovieBloc>(create: (context) => createMovieBloc),
        BlocProvider<SearchMovieBloc>(create: (context) => searchMovieBloc),
      ],
      child: BlocListener<CreateMovieBloc, CreateMovieState>(
        listener: (context, state) {
          ScaffoldMessenger.of(context).clearSnackBars();
          if (state is CreateMovieLoadSuccessful) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(
                  '${state.movie.title} added to watchlist!',
                  key: const Key('snackbar_success'),
                ),
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
