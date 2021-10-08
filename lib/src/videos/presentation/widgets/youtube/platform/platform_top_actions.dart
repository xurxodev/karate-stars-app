import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/platform/platform_widget.dart';
import 'package:karate_stars_app/src/videos/presentation/widgets/youtube/full_screen_action.dart';
import 'package:karate_stars_app/src/videos/presentation/widgets/youtube/volume_action.dart';

import '../ios_player_controls_container.dart';

class PlatformTopActions extends PlatformWidget<Widget, Widget> {
  @override
  Widget createAndroidWidget(BuildContext context) {
    return Container();
  }

  @override
  Widget createIosWidget(BuildContext context) {
    return Expanded(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
          IosPlayerControlContainer(
              padding: EdgeInsets.all(0.0), child: FullScreenAction()),
          IosPlayerControlContainer(
              padding: EdgeInsets.all(0.0), child: VolumeAction())
        ]));
  }
}
