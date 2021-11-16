import 'package:flutter/material.dart';
import 'package:movie_app_flutter/movie_details/widgets/widgets.dart';
import 'package:movie_repository/movie_repository.dart';

class DirectorList extends StatelessWidget {
  final List<Director> directorList;
  const DirectorList({
    Key? key,
    required this.directorList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: 'Director${directorList.length > 1 ? "s" : ""}'),
        ...directorList
            .map(
              (director) => ListTile(
                leading: const Icon(Icons.movie_creation, color: Colors.grey),
                title: Text(director.name),
              ),
            )
            .toList(),
      ],
    );
  }
}
