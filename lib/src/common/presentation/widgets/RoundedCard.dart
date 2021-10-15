import 'package:flutter/material.dart';

class RoundedCard extends StatelessWidget {
  final double? elevation;
  final BorderRadiusGeometry borderRadius;
  final Widget child;
  final EdgeInsetsGeometry? margin;

  const RoundedCard(
      {this.elevation,
      required this.borderRadius,
      required this.child,
      this.margin});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: elevation,
        margin: margin,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        child: child);
  }
}
