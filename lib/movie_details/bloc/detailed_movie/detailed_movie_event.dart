part of 'detailed_movie_bloc.dart';

abstract class DetailedMovieEvent extends Equatable {
  const DetailedMovieEvent();

  @override
  List<Object> get props => [];
}

class DetailedMovieGetDetails extends DetailedMovieEvent {
  final Movie movie;

  const DetailedMovieGetDetails({
    required this.movie,
  });

  @override
  List<Object> get props => [movie];
}
