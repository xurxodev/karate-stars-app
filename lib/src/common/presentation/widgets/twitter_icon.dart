import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/icons/custom_icons.dart';

class TwitterIcon extends StatelessWidget {
  const TwitterIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(CustomIcons.twitter, size: 16, color: Color(0xFF1DA1F2));
  }
}
