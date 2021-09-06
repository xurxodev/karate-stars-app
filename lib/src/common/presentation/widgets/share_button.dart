import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShareButton extends StatelessWidget {
  final Color? color;
  final VoidCallback? onPressed;

  const ShareButton({Key? key, this.onPressed, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    return IconButton(
      icon: const ShareButtonIcon(),
      color: color,
      onPressed: onPressed,
      iconSize: Theme.of(context).platform == TargetPlatform.iOS ? 28.0 : 24.0,
    );
  }
}

class ShareButtonIcon extends StatelessWidget {
  const ShareButtonIcon({Key? key}) : super(key: key);

  static IconData _getIconData(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return Icons.share;
      case TargetPlatform.iOS:
        return CupertinoIcons.share;
      default:
        {
          return Icons.share;
        }
    }
  }

  @override
  Widget build(BuildContext context) =>
      Icon(_getIconData(Theme.of(context).platform));
}
