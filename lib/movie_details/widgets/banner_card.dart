import 'package:flutter/material.dart';
import 'package:movie_repository/movie_repository.dart';

class BannerCard extends StatelessWidget {
  const BannerCard({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(16),
      ),
      child: Stack(
        children: [
          Hero(
            tag: 'movieImage-${movie.imdbId}',
            child: Image.network(
              movie.image,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.6, 0.95],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  begin: Alignment.center,
                  end: Alignment.topCenter,
                  stops: const [0.6, 1],
                ),
              ),
            ),
          ),
          Positioned(
            width: 200,
            left: 20,
            bottom: 20,
            child: Text(
              movie.title,
              overflow: TextOverflow.fade,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SafeArea(
            child: BackButton(),
          )
        ],
      ),
    );
  }
}
