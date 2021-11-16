import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final double max;
  final String logo;
  final double actual;
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
    return ListTile(
      leading: SizedBox(
        width: 75,
        child: Image.asset(logo),
      ),
      title: Text(
        '$actual / ${max.floor()}',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: actual <= max * 0.4
              ? Colors.red
              : actual <= max * 0.7
                  ? Colors.yellow
                  : Colors.green,
        ),
      ),
      trailing: Text(
        helperText,
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
