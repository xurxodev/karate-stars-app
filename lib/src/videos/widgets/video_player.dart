import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  final String videoUrl;

  const VideoPlayer({required this.videoUrl});

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
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
        ],
        placeholder: const Center(
          child: CircularProgressIndicator(),
        ));
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