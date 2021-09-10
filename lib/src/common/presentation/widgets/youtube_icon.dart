import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/icons/custom_icons.dart';

class YoutubeIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Icon(CustomIcons.youtube_play,
        size: 16, color: Color(0xFFFF0000));
  }
}
