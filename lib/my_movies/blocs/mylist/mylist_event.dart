part of 'mylist_bloc.dart';

abstract class MyListEvent extends Equatable {
  const MyListEvent();

  @override
  List<Object> get props => [];
}

class MyListGetAll extends MyListEvent {}

class MyListUpdateOne extends MyListEvent {
  final UpdateMovieDto movie;

  const MyListUpdateOne({
    required this.movie,
  });

  @override
  List<Object> get props => [movie];
}
