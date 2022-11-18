import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/keys.dart';

@Deprecated('Use Message widget instead')
class NotificationMessage extends StatelessWidget {
  final String text;

  const NotificationMessage(this.text);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text,
              key: const Key(Keys.notification_message),
              style: Theme.of(context).textTheme.headline6,
            )));
  }
}
