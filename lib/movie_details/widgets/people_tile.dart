import 'package:flutter/material.dart';

class PeopleTile extends StatelessWidget {
  final String img;
  final String title;
  final String? subtitle;
  const PeopleTile({
    Key? key,
    required this.img,
    required this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 35,
        child: ClipOval(
          child: Image.network(
            img,
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
        title,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: subtitle != null ? Text(subtitle!) : null,
    );
  }
}
