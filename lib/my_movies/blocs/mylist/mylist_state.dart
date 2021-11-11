part of 'mylist_bloc.dart';

abstract class MyListState extends Equatable {
  const MyListState();

  @override
  List<Object> get props => [];
}

class MyListInitial extends MyListState {}

class MyListGetAllLoadInProgress extends MyListState {}

class MyListGetAllLoadSuccessful extends MyListState {
  final List<Movie> movies;

  const MyListGetAllLoadSuccessful({
    required this.movies,
  });

  @override
  List<Object> get props => [movies];
}

class MyListGetAllError extends MyListState {
  final String error;

  const MyListGetAllError({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class MyListUpdateOneLoadInProgress extends MyListState {}

class MyListUpdateOneLoadSuccessful extends MyListState {}

class MyListUpdateOneError extends MyListState {
  final String error;

  const MyListUpdateOneError({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
