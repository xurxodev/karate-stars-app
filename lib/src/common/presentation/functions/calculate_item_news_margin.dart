import 'package:flutter/material.dart';

EdgeInsets calculateItemNewsMargin(BuildContext context) {
  final mediaQueryData = MediaQuery.of(context);

  const fixed = 4.0;
  final bigMargin = mediaQueryData.size.width * 0.20;
  final smallMargin = mediaQueryData.size.width * 0.10;

  if (mediaQueryData.orientation == Orientation.portrait) {
    if (mediaQueryData.size.width > 600) {
      return EdgeInsets.symmetric(vertical: fixed, horizontal: smallMargin);
    } else {
      return const EdgeInsets.symmetric(vertical: fixed, horizontal: 12.0);
    }
  } else {
    if (mediaQueryData.size.width > 600) {
      return EdgeInsets.symmetric(vertical: fixed, horizontal: bigMargin);
    } else {
      return const EdgeInsets.symmetric(vertical: fixed, horizontal: 20.0);
    }
  }
}
