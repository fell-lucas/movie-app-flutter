import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_flutter/main.dart';
import 'package:movie_app_flutter/my_movies/blocs/blocs.dart';
import 'package:movie_app_flutter/my_movies/widgets/widgets.dart';
import 'package:movie_repository/movie_repository.dart';

class MyMoviesPage extends StatefulWidget {
  const MyMoviesPage({Key? key}) : super(key: key);

  @override
  State<MyMoviesPage> createState() => _MyMoviesPageState();
}

class _MyMoviesPageState extends State<MyMoviesPage> {
  @override
  void initState() {
    BlocProvider.of<GetMoviesBloc>(context).add(GetMovies());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMoviesBloc, GetMoviesState>(
      builder: (context, state) {
        if (state is GetMoviesLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetMoviesLoadSuccessful) {
          return GridView.count(
            crossAxisCount: 2,
            children:
                state.movies.map((movie) => MovieCard(movie: movie)).toList(),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Clique abaixo para tentar carregar os filmes manualmente.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<GetMoviesBloc>(context).add(GetMovies());
                },
                child: const Text('Carregar'),
              )
            ],
          );
        }
      },
    );
    ;
  }
}
