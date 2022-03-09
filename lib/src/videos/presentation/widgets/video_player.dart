import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/Progress.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPlayer extends StatefulWidget {
  final String videoUrl;
  final bool fullScreenByDefault;
  final bool autoPlay;

  const VideoPlayer(
      {required this.videoUrl,
      this.fullScreenByDefault = false,
      this.autoPlay = false});

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late VideoPlayerController _controller;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..setLooping(true);

    await _controller.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized,
      // even before the play button has been pressed.
      setState(() {});
    });

    _chewieController = ChewieController(
        videoPlayerController: _controller,
        fullScreenByDefault: widget.fullScreenByDefault,
        autoPlay: widget.autoPlay,
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return _chewieController != null &&
            _chewieController!.videoPlayerController.value.isInitialized
        ? VisibilityDetector(
            key: const Key('video-visible-detector'),
            onVisibilityChanged: (visibilityInfo) {
              final visiblePercentage = visibilityInfo.visibleFraction * 100;

              if (visiblePercentage == 0) {
                _chewieController?.pause();
              }
            },
            child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Chewie(controller: _chewieController!)))
        : Progress();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController?.dispose();
  }
}
