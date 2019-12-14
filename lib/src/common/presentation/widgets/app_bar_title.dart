import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  final String title;
  final bool showIcon;

  const AppBarTitle(this.title, this.showIcon);

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    const Key titleKey = Key('app_bar_title');

    if (showIcon) {
      children.addAll([
        Image.asset(
          'assets/images/logo.png',
          width: 40,
        ),
        const SizedBox(
          width: 8.0,
        ),
        Text(title,
            key: titleKey,
            style: const TextStyle(
                fontFamily: 'Billabong',
                fontSize: 30))
      ]);
    } else {
      children.add(Text(title,
          key: titleKey,
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.title.fontSize)));
    }

    return Row(
        crossAxisAlignment: CrossAxisAlignment.center, children: children);
  }
}
