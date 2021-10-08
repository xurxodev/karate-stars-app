import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class PlatformWidget<I extends Widget, A extends Widget>
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.windows:
        return createAndroidWidget(context);

      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.iOS:
      return createIosWidget(context);

      default:
        return createAndroidWidget(context);
    }
  }

  I createIosWidget(BuildContext context);

  A createAndroidWidget(BuildContext context);
}