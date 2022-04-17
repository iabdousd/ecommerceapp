import 'package:flutter/material.dart';

class AppDropDown<T> extends StatelessWidget {
  final String label;
  final Iterable<T> items;
  final Widget Function(T) titleBuilder;
  final Widget? prefixIcon;

  final ValueChanged<T?>? onChanged;
  final T? value;
  final bool disabled;
  final EdgeInsets margin;

  const AppDropDown({
    Key? key,
    required this.label,
    required this.items,
    required this.titleBuilder,
    this.prefixIcon,
    this.onChanged,
    this.value,
    this.disabled = false,
    this.margin = const EdgeInsets.symmetric(vertical: 8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      borderSide: BorderSide(color: Colors.black26),
    );

    return Padding(
      padding: margin,
      child: DropdownButtonFormField<T>(
        decoration: InputDecoration(
          labelText: label,
          // prefixIcon: prefixIcon,
          prefixIcon: prefixIcon != null ? Center(child: prefixIcon!) : null,
          prefixIconConstraints: const BoxConstraints.tightFor(
            width: 48,
            height: 36,
          ),
          fillColor: Theme.of(context).colorScheme.surface,
          border: border,
          enabledBorder: border,
          focusedBorder: border.copyWith(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12,
          ),
          filled: true,
          alignLabelWithHint: true,
        ),
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
      ),
    );
  }
}
