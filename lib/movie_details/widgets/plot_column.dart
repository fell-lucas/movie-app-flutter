import 'package:flutter/material.dart';
import 'package:movie_app_flutter/movie_details/widgets/widgets.dart';

class PlotColumn extends StatelessWidget {
  final String plot;

  const PlotColumn({Key? key, required this.plot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Plot'),
        Card(
          elevation: 15,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              plot,
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
