import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ItemVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const ItemVideoPlayer({required this.videoUrl});

  @override
  _ItemVideoPlayerState createState() => _ItemVideoPlayerState();
}

class _ItemVideoPlayerState extends State<ItemVideoPlayer> {
  VideoPlayerController? _controller;

  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..addListener(() {
        final bool isPlaying = _controller?.value.isPlaying ?? false;

        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized,
        // even before the play button has been pressed.
        setState(() {});
      })
      ..setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    final video = _controller?.value.isInitialized ?? false
        ? AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: VideoPlayer(_controller!))
        : Container();

    final playOrPauseVideo = () {
      _controller!.value.isPlaying
          ? _controller!.pause()
          : _controller!.play();
    };

    return GestureDetector(
        onTap: playOrPauseVideo,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            video,
            Opacity(
              opacity: _isPlaying ? 0.0 : 1.0,
              child: FloatingActionButton(
                backgroundColor: Colors.redAccent,
                elevation: 0,
                child: const Icon(Icons.play_arrow),
                onPressed: playOrPauseVideo,
              ),
            )
          ],
        ));
  }

  @override
  void dispose() {
    super.dispose();
    if (_controller != null){
      _controller!.dispose();
    }
  }
}
