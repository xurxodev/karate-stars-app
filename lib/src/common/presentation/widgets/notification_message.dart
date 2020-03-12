import 'package:flutter/material.dart';

class NotificationMessage extends StatelessWidget {
  static const id = 'notification_message';

  final String text;

  const NotificationMessage(this.text);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
            child: Text(
      text,
      key: const Key(id),
      style: Theme.of(context).textTheme.title,
    )));
  }
}
