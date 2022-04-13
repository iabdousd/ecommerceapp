import 'package:flutter/material.dart';

class AppDropDown<T> extends StatelessWidget {
  final String label;
  final Iterable<T> items;
  final Widget Function(T) titleBuilder;
  final ValueChanged<T?>? onChanged;
  final T? value;
  final bool disabled;
  const AppDropDown({
    Key? key,
    required this.label,
    required this.items,
    required this.titleBuilder,
    this.onChanged,
    this.value,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(labelText: label),
      items: items
          .map(
            (item) => DropdownMenuItem<T>(
              child: titleBuilder(item),
              value: item,
            ),
          )
          .toList(),
      onChanged: onChanged,
      value: value,
    );
  }
}
