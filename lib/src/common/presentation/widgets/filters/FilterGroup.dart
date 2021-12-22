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
          child: Text(label,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 10),
        child
      ],
    );
  }
}
