import 'package:flutter/material.dart';

class FilterAction extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? tooltip;
  final bool? applied;

  const FilterAction({Key? key, this.tooltip, this.onPressed, this.applied})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        tooltip: tooltip,
        icon:
            Icon(Icons.filter_list, color: applied == true ? Colors.red : null),
        onPressed: onPressed);
  }
}
