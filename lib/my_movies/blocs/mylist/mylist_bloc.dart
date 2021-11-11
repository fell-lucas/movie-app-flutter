import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_repository/movie_repository.dart';

part 'mylist_event.dart';
part 'mylist_state.dart';

class MyListBloc extends Bloc<MyListEvent, MyListState> {
  final MovieRepository movieRepository;

  MyListBloc({
    required this.movieRepository,
  }) : super(MyListInitial());

  @override
  Stream<MyListState> mapEventToState(MyListEvent event) async* {
    if (event is MyListGetAll) {
      yield* _mapGetAllToState(event);
    } else if (event is MyListUpdateOne) {
      yield* _mapUpdateOneToState(event);
    }
  }

  Stream<MyListState> _mapGetAllToState(MyListGetAll event) async* {
    yield MyListGetAllLoadInProgress();
    try {
      final movies = await movieRepository.getMovies();
      yield MyListGetAllLoadSuccessful(movies: movies);
    } on HttpException catch (e) {
      yield MyListGetAllError(error: e.message);
    }
  }

  Stream<MyListState> _mapUpdateOneToState(MyListUpdateOne event) async* {
    yield MyListUpdateOneLoadInProgress();
    try {
      await movieRepository.updateMovie(movie: event.movie);
      yield MyListUpdateOneLoadSuccessful();
    } on HttpException catch (e) {
      yield MyListUpdateOneError(error: e.message);
    }
  }
}
