import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class PlatformWidget<I extends Widget, A extends Widget>
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return createIosWidget(context);
    } else {
      return createAndroidWidget(context);
    }
  }

  I createIosWidget(BuildContext context);

  A createAndroidWidget(BuildContext context);
}