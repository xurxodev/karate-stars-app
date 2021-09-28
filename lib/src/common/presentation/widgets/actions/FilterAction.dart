import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/keys.dart';

class FilterAction extends StatelessWidget {
  final VoidCallback? onPressed;

  const FilterAction({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        key: const Key(Keys.home_filter),
        icon: const Icon(Icons.filter_list),
        onPressed: onPressed);
  }
}
