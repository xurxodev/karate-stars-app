import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class ItemVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const ItemVideoPlayer({required this.videoUrl});

  @override
  _ItemVideoPlayerState createState() => _ItemVideoPlayerState();
}

class _ItemVideoPlayerState extends State<ItemVideoPlayer> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

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
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: Chewie(controller: _chewieController));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController.dispose();
  }
}
