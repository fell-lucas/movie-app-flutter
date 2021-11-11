import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app_flutter/home/home.dart';
import 'package:movie_repository/movie_repository.dart';

import 'home/blocs/blocs.dart';
import 'my_movies/blocs/blocs.dart';

GetIt getIt = GetIt.instance;

class DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = DevHttpOverrides();
  getIt.registerSingleton<MovieApi>(MovieApi());
  getIt.registerSingleton<MovieRepository>(
    Repository(movieApi: getIt<MovieApi>()),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        snackBarTheme: const SnackBarThemeData(
          contentTextStyle: TextStyle(color: Colors.white),
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BottomNavigationCubit(),
          ),
          BlocProvider(
            create: (context) => GetMoviesBloc(
              movieRepository: getIt<MovieRepository>(),
            ),
          ),
        ],
        child: HomePage(),
      ),
    );
  }
}
