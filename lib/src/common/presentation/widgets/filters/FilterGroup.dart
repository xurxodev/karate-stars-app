import 'package:flutter/material.dart';

class FilterGroup extends StatelessWidget {
  final Widget child;
  final String label;

  const FilterGroup({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(label.toUpperCase(),
                  style: Theme.of(context).textTheme.caption),
            )),
        const SizedBox(height: 10),
        child
      ],
    );
  }
}
