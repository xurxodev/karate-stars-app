import 'package:flutter/material.dart';

class NotificationText extends StatelessWidget {
  final String data;

  const NotificationText(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      data,
      style: Theme.of(context).textTheme.title,
    ));
  }
}
