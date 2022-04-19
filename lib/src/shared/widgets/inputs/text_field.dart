import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final GlobalKey<FormFieldState>? fieldKey;
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final String? initialValue;
  final bool autofocus;
  final int? minLines, maxLines, maxLength;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged, onSubmitted;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final EdgeInsets contentPadding;
  final EdgeInsets margin;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool enabled;

  const AppTextField({
    Key? key,
    this.fieldKey,
    this.label,
    this.hint,
    this.controller,
    this.initialValue,
    this.autofocus = false,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType,
    this.onChanged,
    this.onSubmitted,
    this.onSaved,
    this.validator,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 12,
    ),
    this.margin = const EdgeInsets.symmetric(vertical: 8),
    this.prefixIcon,
    this.suffixIcon,
    this.textInputAction,
    this.obscureText = false,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      borderSide: BorderSide(color: Colors.black26),
    );

    return Padding(
      padding: margin,
      child: TextFormField(
        key: fieldKey,
        initialValue: initialValue,
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          contentPadding: contentPadding,
          suffixIcon: suffixIcon != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [suffixIcon!],
                )
              : null,
          prefixIcon: prefixIcon,
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
          filled: true,
          alignLabelWithHint: true,
        ),
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        onSaved: onSaved,
        validator: validator,
        autofocus: autofocus,
        minLines: minLines,
        maxLines: maxLines,
        maxLength: maxLength,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        obscureText: obscureText,
      ),
    );
  }
}
