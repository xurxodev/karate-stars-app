import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/platform/platform_widget.dart';

class Option {
  final String id;
  final String name;

  Option(this.id, this.name);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Option &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class PlatformDropdown extends PlatformWidget<CupertinoButton, DropdownButton> {
  final List<Option> options;
  final Option? value;
  final ValueChanged<Option?>? onChanged;
  final String? hint;

  PlatformDropdown(
      {required this.options, required this.onChanged, this.value, this.hint});

  @override
  DropdownButton createAndroidWidget(BuildContext context) {
    return DropdownButton<Option>(
      isExpanded: true,
      value: value,
      onChanged: onChanged,
      hint: Text(hint ?? ''),
      items: options.map<DropdownMenuItem<Option>>((Option value) {
        return DropdownMenuItem<Option>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
    );
  }

  @override
  CupertinoButton createIosWidget(BuildContext context) {
    return CupertinoButton(
        minSize: 32.0,
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
        color: Theme.of(context).colorScheme.secondary,
        child: Text(value?.name ?? hint ?? '',
            style: Theme.of(context).textTheme.subtitle1),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                    height: 200.0,
                    child: CupertinoPicker(
                      itemExtent: 32.0,
                      onSelectedItemChanged: (int index) {
                        if (onChanged != null) {
                          onChanged!(options[index]);
                        }
                      },
                      scrollController: value != null
                          ? FixedExtentScrollController(
                              initialItem: options.indexOf(value!))
                          : null,
                      children: options.map((Option option) {
                        return Center(
                          child: Text(option.name),
                        );
                      }).toList(),
                    ));
              });
        });
  }
}
