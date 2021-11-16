import 'dart:math';

import 'package:flutter/material.dart';

class KeywordList extends StatelessWidget {
  final List<String> keywordList;
  const KeywordList({
    Key? key,
    required this.keywordList,
  }) : super(key: key);

  final List<Color> possibleColors = const [
    Color(0xFFAEEBDC),
    Color(0xFFFFF2CF),
    Color(0xFFFFD9F9),
    Color(0xFFDED0F2),
    Color(0xFFF6DCAB),
    Color(0xFFCFCFC4),
    Color(0xFFE6A38E),
    Color(0xFFFFEEB5),
    Color(0xFFB4BBFA),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 10,
        runSpacing: 10,
        children: keywordList.map(
          (keyword) {
            var colorIndex = Random().nextInt(possibleColors.length);
            return Material(
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
              color: possibleColors[colorIndex].withAlpha(75),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  keyword,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: possibleColors[colorIndex],
                  ),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
