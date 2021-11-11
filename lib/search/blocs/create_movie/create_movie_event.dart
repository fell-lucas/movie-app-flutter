part of 'create_movie_bloc.dart';

@immutable
abstract class CreateMovieEvent extends Equatable {
  const CreateMovieEvent();

  @override
  List<Object?> get props => [];
}

class CreateMovie extends CreateMovieEvent {
  final CreateMovieDto movie;

  const CreateMovie({
    required this.movie,
  });

  @override
  List<Object?> get props => [movie];
}
