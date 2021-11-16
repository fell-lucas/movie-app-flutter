import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final double max;
  final String logo;
  final String actual;
  final String helperText;

  const Rating({
    Key? key,
    required this.max,
    required this.logo,
    required this.actual,
    required this.helperText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Text text;
    try {
      var parsed = double.parse(actual);
      text = Text(
        '$parsed / ${max.floor()}',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: parsed <= max * 0.4
              ? Colors.red
              : parsed <= max * 0.7
                  ? Colors.yellow
                  : Colors.green,
        ),
      );
    } catch (e) {
      text = const Text(
        'Unavailable',
        style: TextStyle(color: Colors.grey),
      );
    }

    return ListTile(
      leading: SizedBox(
        width: 75,
        child: Image.asset(logo),
      ),
      title: text,
      trailing: Text(
        helperText,
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
