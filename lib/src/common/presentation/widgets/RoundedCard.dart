import 'package:flutter/material.dart';

class RoundedCard extends StatelessWidget {
  final double? elevation;
  final BorderRadiusGeometry borderRadius;
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final Color? color;

  const RoundedCard(
      {this.elevation,
      required this.borderRadius,
      required this.child,
      this.margin,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: color ?? Theme.of(context).cardColor,
        elevation: elevation,
        margin: margin,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        child: child);
  }
}
