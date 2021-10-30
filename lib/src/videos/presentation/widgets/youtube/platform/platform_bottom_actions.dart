import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/platform/platform_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../full_screen_action.dart';
import '../ios_player_controls_container.dart';
import '../playback_speed_action.dart';

class PlatformBottomActions extends PlatformWidget<Widget, Widget> {
  @override
  Widget createMaterialWidget(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        Row(
          children: [
            Row(children: [
              const SizedBox(width: 14.0),
              CurrentPosition(),
              const Text(
                ' / ',
                style: TextStyle(color: Colors.white),
              ),
              RemainingDuration(),
            ]),
            Expanded(child: Container(child: const Text(''))),
            const FullScreenAction()
          ],
        ),
        Row(
          children: [
            ProgressBar(
              isExpanded: true,
              colors: const ProgressBarColors(
                playedColor: Colors.red,
                handleColor: Colors.red,
              ),
            )
          ],
        )
      ],
    ));
  }

  @override
  Widget createCupertinoWidget(BuildContext context) {
    return Expanded(
        child: IosPlayerControlContainer(
            child: Row(
      children: [
        const SizedBox(width: 14.0),
        CurrentPosition(),
        const SizedBox(width: 8.0),
        ProgressBar(
          isExpanded: true,
          colors: const ProgressBarColors(
            playedColor: Colors.white38,
            handleColor: Colors.white,
          ),
        ),
        const SizedBox(width: 8.0),
        RemainingDuration(),
        const PlaybackSpeedAction()
      ],
    )));
  }
}
