import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_flutter/home/blocs/blocs.dart';
import 'package:movie_app_flutter/my_movies/views/my_movies.dart';
import 'package:movie_app_flutter/search/views/views.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final _screens = [const SearchPage(), const MyMoviesPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: _screens[context.read<BottomNavigationCubit>().state],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.select(
          (BottomNavigationCubit cubit) => cubit.state,
        ),
        onTap: (index) {
          context.read<BottomNavigationCubit>().emit(index);
        },
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
