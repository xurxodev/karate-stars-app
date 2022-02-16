import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/states/option.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/platform/platform_widget.dart';

class PlatformDropdown extends PlatformWidget<CupertinoButton, DropdownButton> {
  final List<Option> options;
  final String value;
  final ValueChanged<String>? onChanged;
  final String? hint;

  PlatformDropdown(
      {required this.options, this.onChanged, required this.value, this.hint});

  @override
  DropdownButton createMaterialWidget(BuildContext context) {
    return DropdownButton<Option>(
      isExpanded: true,
      value: options.firstWhere((option) => option.id == value),
      onChanged: (option) {
        if (onChanged != null && option != null) {
          onChanged!(option.id);
        }
      },
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
  CupertinoButton createCupertinoWidget(BuildContext context) {
    final selectedOption = options.firstWhere((option) => option.id == value);

    return CupertinoButton(
        minSize: 32.0,
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
        color: Theme.of(context).colorScheme.secondary,
        child: Text(selectedOption.name,
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
                          onChanged!(options[index].id);
                        }
                      },
                      scrollController: FixedExtentScrollController(
                          initialItem: options.indexOf(selectedOption)),
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
