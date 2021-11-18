import 'package:flutter/material.dart';
import 'package:movie_app_flutter/movie_details/widgets/widgets.dart';
import 'package:movie_repository/movie_repository.dart';

class CastList extends StatelessWidget {
  final List<Actor> castList;
  const CastList({
    Key? key,
    required this.castList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...castList
                .map(
                  (actor) => PeopleTile(
                    img: actor.image,
                    title: actor.name,
                    subtitle: 'As ${actor.asCharacter.split("as ")[0]}',
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
