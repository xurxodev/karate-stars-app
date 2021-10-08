import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// A widget to display the full screen toggle button.
class VolumeAction extends StatefulWidget {
  /// Overrides the default [YoutubePlayerController].
  final YoutubePlayerController? controller;

  /// Defines color of the button.
  final Color color;

  /// Creates [VolumeAction] widget.
  const VolumeAction({
    this.controller,
    this.color = Colors.white,
  });

  @override
  _FullScreenButtonState createState() => _FullScreenButtonState();
}

class _FullScreenButtonState extends State<VolumeAction> {
  late YoutubePlayerController _controller;
  bool _muted = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final controller = YoutubePlayerController.of(context);
    if (controller == null) {
      assert(
        widget.controller != null,
        '\n\nNo controller could be found in the provided context.\n\n'
        'Try passing the controller explicitly.',
      );
      _controller = widget.controller!;
    } else {
      _controller = controller;
    }
    _controller.removeListener(listener);
    _controller.addListener(listener);
  }

  @override
  void dispose() {
    _controller.removeListener(listener);
    super.dispose();
  }

  void listener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        iconSize: 15.0,
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
        constraints: const BoxConstraints(),
        icon: Icon(_muted ? Icons.volume_off_sharp : Icons.volume_up_sharp,
            color: Colors.white),
        onPressed: () {
          _muted ? _controller.unMute() : _controller.mute();
          setState(() {
            _muted = !_muted;
          });
        });
  }
}
