import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_flutter/home/blocs/blocs.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: TextField(
                  controller: _controller,
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                    if (_controller.text != '') {
                      BlocProvider.of<MovieBloc>(context)
                          .add(SearchMovies(fts: _controller.text));
                    }
                  },
                  decoration: InputDecoration(
                    label: Text('Keywords, ImdbId...'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              Expanded(
                flex: 5,
                child: BlocBuilder<MovieBloc, MovieState>(
                  builder: (context, state) {
                    if (state is MovieSearchLoadSuccessful) {
                      return ListView(
                        children: state.movies
                            .map((movie) => ListTile(
                                  leading: Image.network(movie.image),
                                  title: Text(movie.title),
                                  subtitle: Text(movie.description),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {},
                                  ),
                                  shape: RoundedRectangleBorder(),
                                ))
                            .toList(),
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
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.house),
          ),
          BottomNavigationBarItem(
            label: 'My Movies',
            icon: Icon(Icons.list),
          ),
        ],
      ),
    );
  }
}
