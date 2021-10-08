import 'package:flutter/material.dart';

class IosPlayerControlContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const IosPlayerControlContainer({required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding ?? const EdgeInsets.all(4.0),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(88, 88, 88, 0.8),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: child);
  }
}
