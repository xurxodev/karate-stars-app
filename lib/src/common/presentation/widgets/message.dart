import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/keys.dart';

enum MessageType { info, success, error }

class Message extends StatelessWidget {
  final String text;
  final MessageType type;

  const Message({required this.text, required this.type});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildIcon(),
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text,
              key: const Key(Keys.notification_message),
              style: Theme.of(context).textTheme.headline6,
            ))
      ],
    ));
  }

  Icon _buildIcon() {
    switch (type) {
      case MessageType.info:
        {
          return const Icon(
            Icons.error,
            color: Colors.blue,
            size: 40,
          );
        }
      case MessageType.error:
        {
          return const Icon(
            Icons.error,
            color: Colors.red,
            size: 40,
          );
        }
      case MessageType.success:
        {
          return const Icon(
            Icons.error,
            color: Colors.green,
            size: 40,
          );
        }
    }
  }
}
