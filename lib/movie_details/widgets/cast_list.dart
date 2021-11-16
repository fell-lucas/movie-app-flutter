import 'package:flutter/material.dart';
import 'package:movie_repository/movie_repository.dart';

class CastList extends StatelessWidget {
  final List<Actor> castList;
  const CastList({
    Key? key,
    required this.castList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Cast',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        ...castList
            .map(
              (actor) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 35,
                  child: ClipOval(
                    child: Image.network(
                      actor.image,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return const Text(
                          '😢',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 26),
                        );
                      },
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return const SizedBox(
                          width: 30,
                          height: 30,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      },
                    ),
                  ),
                ),
                title: Text(
                  actor.name,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text('As ${actor.asCharacter.split("as ")[0]}'),
              ),
            )
            .toList(),
      ],
    );
  }
}
