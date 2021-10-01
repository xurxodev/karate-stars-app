import 'package:flutter/material.dart';

class FilterAction extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? tooltip;

  const FilterAction({Key? key, this.tooltip, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        tooltip: tooltip,
        icon: const Icon(Icons.filter_list),
        onPressed: onPressed);
  }
}
