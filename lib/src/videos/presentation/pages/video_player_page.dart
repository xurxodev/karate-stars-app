import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/Progress.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/videos/domain/entities/video.dart';
import 'package:karate_stars_app/src/videos/presentation/widgets/youtube/platform/platform_bottom_actions.dart';
import 'package:karate_stars_app/src/videos/presentation/widgets/youtube/platform/platform_top_actions.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerPage extends StatefulWidget {
  static const routeName = '/video';

  const VideoPlayerPage({
    Key? key,
  }) : super(key: key);

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPage();
}

class _VideoPlayerPage extends State<VideoPlayerPage> {
  VideoLink? _videoLink;

  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      setState(() {
        _videoLink = ModalRoute.of(context)!.settings.arguments as VideoLink;
      });

      if (_videoLink != null) {
        _initializePlayer(_videoLink!.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _controller == null ? Progress() : YoutubePlayerBuilder(
        onExitFullScreen: () {
          // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
/*          SystemChrome.setPreferredOrientations(
              [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);*/
        },
        player: YoutubePlayer(
          actionsPadding: const EdgeInsets.all(20.0),
          controller: _controller!,
          showVideoProgressIndicator: true,
          topActions: [PlatformTopActions()],
          bottomActions: [PlatformBottomActions()],
        ),
        builder: (context, player) {
          return Scaffold(
              appBar: AppBar(
                  centerTitle: false,
                  title: Text(
                    Strings.video_player_appbar_title,
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.headline6!.fontSize),
                  )),
              body: SafeArea(child: player));
        });
  }

  Future<void> _initializePlayer(String videoId) async {
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }
}
