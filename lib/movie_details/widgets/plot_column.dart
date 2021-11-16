import 'package:flutter/material.dart';

class PlotColumn extends StatelessWidget {
  final String plot;

  const PlotColumn({Key? key, required this.plot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Plot',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        Card(
          elevation: 15,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              plot,
              textAlign: TextAlign.center,
              style: const TextStyle(),
            ),
          ),
        )
      ],
    );
  }
}
