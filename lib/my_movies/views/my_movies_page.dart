import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_flutter/my_movies/blocs/blocs.dart';
import 'package:movie_app_flutter/my_movies/widgets/widgets.dart';

class MyMoviesPage extends StatefulWidget {
  const MyMoviesPage({Key? key}) : super(key: key);

  @override
  State<MyMoviesPage> createState() => _MyMoviesPageState();
}

class _MyMoviesPageState extends State<MyMoviesPage> {
  @override
  void initState() {
    BlocProvider.of<MyListBloc>(context).add(MyListGetAll());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyListBloc, MyListState>(
      listener: (context, state) {
        if (state is MyListUpdateOneLoadSuccessful) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text('Filme atualizado!'),
            ),
          );
        } else if (state is MyListUpdateOneError) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.error),
            ),
          );
        }
      },
      child: BlocBuilder<MyListBloc, MyListState>(
        builder: (context, state) {
          if (state is MyListGetAllLoadSuccessful) {
            if (state.movies.isNotEmpty) {
              return GridView.count(
                crossAxisCount: 3,
                children: state.movies
                    .map((movie) => MovieCard(movie: movie))
                    .toList(),
              );
            } else {
              return const Center(
                child: Text('Add a few movies to begin!'),
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
