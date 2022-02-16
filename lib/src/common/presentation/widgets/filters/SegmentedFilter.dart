import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/states/option.dart';

class SegmentedOptions extends StatelessWidget {
  final ValueChanged<String>? onValueChanged;
  final List<Option> options;
  final String value;
  final EdgeInsetsGeometry padding;

  const SegmentedOptions(
      {required this.options,
      this.onValueChanged,
      required this.value,
      this.padding = const EdgeInsets.all(0)});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: CupertinoSlidingSegmentedControl<String>(
        thumbColor: Theme.of(context).colorScheme.secondary,
        children: Map<String, Widget>.fromIterable(options,
            key: (item) => item.id, value: (item) => Text(item.name)),
        onValueChanged: (String? id) {
          if (id != null && onValueChanged != null) {
            onValueChanged!(id);
          }
        },
        groupValue: value,
      ),
    );
  }
}
