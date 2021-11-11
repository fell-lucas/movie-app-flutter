import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_flutter/search/blocs/blocs.dart';

class MovieSearch extends StatelessWidget {
  MovieSearch({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        if (_controller.text != '') {
          BlocProvider.of<MovieBloc>(context).add(
            SearchMovies(fts: _controller.text),
          );
        }
      },
      decoration: InputDecoration(
        label: const Text('Ex.: Chuck Norris'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        suffixIcon: const Icon(Icons.search),
      ),
    );
  }
}
