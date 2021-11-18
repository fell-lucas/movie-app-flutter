import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_repository/movie_repository.dart';

import 'package:movie_app_flutter/movie_details/bloc/blocs.dart';
import 'package:movie_app_flutter/movie_details/widgets/widgets.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;
  const MovieDetailsPage({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  void initState() {
    BlocProvider.of<DetailedMovieBloc>(context).add(
      DetailedMovieGetDetails(movie: widget.movie),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BannerCard(movie: widget.movie),
                BlocBuilder<DetailedMovieBloc, DetailedMovieState>(
                  builder: (context, state) {
                    if (state is DetailedMovieLoadSuccessful) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PlotColumn(plot: state.movie.plot),
                                const SectionTitle(title: 'Cast'),
                                CastList(castList: state.movie.actorList),
                                DirectorList(
                                  directorList: state.movie.directorList,
                                ),
                                const SectionTitle(title: 'Genres'),
                                ListTile(
                                  leading: const Icon(
                                    Icons.theater_comedy_rounded,
                                    color: Colors.grey,
                                  ),
                                  title: Text(state.movie.genres),
                                ),
                                const SectionTitle(title: 'Languages'),
                                ListTile(
                                  leading: const Icon(
                                    Icons.language,
                                    color: Colors.grey,
                                  ),
                                  title: Text(state.movie.languages),
                                ),
                                const SectionTitle(title: 'Ratings'),
                                Rating(
                                  max: 10,
                                  logo: 'assets/images/imdb-logo.png',
                                  actual: state.movie.imDbRating,
                                  helperText: 'IMDb',
                                ),
                                Rating(
                                  max: 100,
                                  logo: 'assets/images/metacritic-logo.png',
                                  actual: state.movie.metacriticRating,
                                  helperText: 'Metacritic',
                                ),
                                const SectionTitle(title: 'Keywords'),
                              ],
                            ),
                            KeywordList(keywordList: state.movie.keywordList)
                          ],
                        ),
                      );
                    } else if (state is DetailedMovieLoadInProgress) {
                      return Column(
                        children: const [
                          SizedBox(height: 35),
                          CircularProgressIndicator(),
                        ],
                      );
                    } else if (state is DetailedMovieError) {
                      return Column(
                        children: [
                          const SizedBox(height: 35),
                          SizedBox(
                            width: double.maxFinite,
                            child: Text(
                              state.error,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                )
              ],
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 75,
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black.withOpacity(0.9)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: const [0, 1],
              ),
            ),
            child: const SafeArea(child: BackButton()),
          )
        ],
      ),
    );
  }
}
