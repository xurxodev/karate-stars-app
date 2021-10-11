import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// A widget to display the full screen toggle button.
class FullScreenAction extends StatefulWidget {
  /// Overrides the default [YoutubePlayerController].
  final YoutubePlayerController? controller;

  /// Creates [FullScreenAction] widget.
  const FullScreenAction({
    this.controller,
  });

  @override
  _FullScreenActionState createState() => _FullScreenActionState();
}

class _FullScreenActionState extends State<FullScreenAction> {
  late YoutubePlayerController _controller;

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
      iconSize: 18.0,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      constraints: const BoxConstraints(),
      icon: Icon(
        _controller.value.isFullScreen
            ? Theme.of(context).platform == TargetPlatform.iOS
                ? Icons.close_fullscreen_sharp
                : Icons.fullscreen_exit_sharp
            : Theme.of(context).platform == TargetPlatform.iOS
                ? Icons.open_in_full_sharp
                : Icons.fullscreen_sharp,
        color: Colors.white,
      ),
      onPressed: () {
        _controller.toggleFullScreenMode();
      },
    );
  }
}
