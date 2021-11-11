part of 'get_movies_bloc.dart';

abstract class GetMoviesEvent extends Equatable {
  const GetMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetMovies extends GetMoviesEvent {}
