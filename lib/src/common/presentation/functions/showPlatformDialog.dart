import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<T?> showPlatformDialog<T> ({ required BuildContext context,
  required WidgetBuilder builder}){
  switch (Theme.of(context).platform) {
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
    case TargetPlatform.windows:
      return showDialog(context: context, builder: builder);

    case TargetPlatform.macOS:
    case TargetPlatform.linux:
    case TargetPlatform.iOS:
    return showCupertinoDialog(context: context, builder: builder);

    default:
      return showDialog(context: context, builder: builder);
  }
}