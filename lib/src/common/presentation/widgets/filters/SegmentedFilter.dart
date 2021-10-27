import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/states/option.dart';

class SegmentedFilter extends StatelessWidget {
  final ValueChanged<int> onValueChanged;
  final Map<int, String> options;
  final int value;
  final EdgeInsetsGeometry padding;

  const SegmentedFilter(
      {required this.options,
      required this.onValueChanged,
      this.value = 0,
      this.padding = const EdgeInsets.all(0)});

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

class SegmentedOptions extends StatelessWidget {
  final ValueChanged<Option>? onValueChanged;
  final List<Option> options;
  final Option value;
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
            onValueChanged!(options.firstWhere((option) => option.id == id));
          }
        },
        groupValue: value.id,
      ),
    );
  }
}
