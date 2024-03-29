import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/videos/presentation/widgets/youtube/platform/platform_bottom_actions.dart';
import 'package:karate_stars_app/src/videos/presentation/widgets/youtube/platform/platform_top_actions.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayer extends StatefulWidget {
  final String youtubeVideoId;
  final bool? isLive;
  final Widget Function(BuildContext, Widget) builder;
  final void Function(YoutubeMetaData metaData)? onEnded;

  const YoutubeVideoPlayer(
      {required this.youtubeVideoId,
      required this.builder,
      this.onEnded,
      this.isLive});

  @override
  State<YoutubeVideoPlayer> createState() => _YoutubeVideoPlayerState();
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();

    _initializePlayer(widget.youtubeVideoId);
  }

  @override
  void didUpdateWidget(YoutubeVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_controller != null &&
        oldWidget.youtubeVideoId != widget.youtubeVideoId) {
      _controller!.load(widget.youtubeVideoId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          actionsPadding: const EdgeInsets.all(20.0),
          controller: _controller!,
          showVideoProgressIndicator: true,
          topActions: [PlatformTopActions()],
          bottomActions: [
              PlatformBottomActions(isLive:widget.isLive ?? false)
          ],
          onEnded: widget.onEnded,
        ),
        builder: widget.builder);
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
