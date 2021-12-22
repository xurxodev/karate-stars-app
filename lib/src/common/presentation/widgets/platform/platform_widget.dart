import 'package:flutter/material.dart';

abstract class PlatformWidget<I extends Widget, A extends Widget>
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.windows:
        return createMaterialWidget(context);

      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.iOS:
        return createCupertinoWidget(context);

      default:
        return createMaterialWidget(context);
    }
  }

  I createCupertinoWidget(BuildContext context);

  A createMaterialWidget(BuildContext context);
}
