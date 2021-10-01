import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SegmentedFilter extends StatelessWidget {
  final ValueChanged<int> onValueChanged;
  final Map<int, String> options;
  final int value;
  final EdgeInsetsGeometry padding;

  const SegmentedFilter(
      {required this.options, required this.onValueChanged, this.value = 0, this.padding = const EdgeInsets.all(0)});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: CupertinoSlidingSegmentedControl(
        thumbColor: Theme.of(context).colorScheme.secondary,
        children: options.map((key, value) => MapEntry(key, Text(value))),
        onValueChanged: (int? index) {
          if (index != null) {
            onValueChanged(index);
          }
        },
        groupValue: value,
      ),
    );
  }
}
