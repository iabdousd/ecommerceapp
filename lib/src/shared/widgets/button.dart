import 'package:ecommerceapp/src/configs/theme.dart';
import 'package:flutter/material.dart';

class _AppCustomButton extends StatelessWidget {
  final String label;
  final Widget? prefix;
  final Widget? suffix;
  final VoidCallback? action;
  final Color? color;
  final Color? textColor;
  final Gradient? gradient;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final Border? border;

  const _AppCustomButton({
    Key? key,
    required this.label,
    this.prefix,
    this.suffix,
    this.action,
    this.color,
    this.textColor,
    this.gradient,
    this.margin,
    this.width,
    this.height,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefix = this.prefix;
    final suffix = this.suffix;
    final _textColor = textColor ?? Theme.of(context).colorScheme.onPrimary;

    return IconTheme(
      data: IconThemeData(color: _textColor, size: 20),
      child: GestureDetector(
        onTap: action,
        child: Container(
          decoration: BoxDecoration(
            gradient: gradient,
            color: color,
            borderRadius: BorderRadius.circular(12),
            border: border,
          ),
          width: width,
          height: height ?? 60,
          margin: margin,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (prefix != null) prefix,
              Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: _textColor),
              ),
              if (suffix != null)
                Padding(padding: const EdgeInsets.only(left: 10), child: suffix)
            ],
          ),
        ),
      ),
    );
  }
}

enum AppButtonStyle { primary, text, outline, outlineSecondary, disabled }

extension on AppButtonStyle {
  Color? background(BuildContext context) {
    switch (this) {
      case AppButtonStyle.primary:
        return null;
      case AppButtonStyle.text:
      case AppButtonStyle.outline:
      case AppButtonStyle.outlineSecondary:
        return Colors.transparent;
      case AppButtonStyle.disabled:
        return Theme.of(context).colorScheme.surface;
    }
  }

  Color textColor(BuildContext context) {
    switch (this) {
      case AppButtonStyle.primary:
        return Theme.of(context).colorScheme.onPrimary;
      case AppButtonStyle.text:
        return Theme.of(context).colorScheme.onBackground;
      case AppButtonStyle.outline:
        return Theme.of(context).colorScheme.onBackground;
      case AppButtonStyle.outlineSecondary:
        return Theme.of(context).colorScheme.onSecondary;
      case AppButtonStyle.disabled:
        return Theme.of(context).colorScheme.onSecondary;
    }
  }
}

class AppButton extends StatelessWidget {
  final String label;
  final Widget? prefix;
  final Widget? suffix;
  final VoidCallback? onPressed;
  final EdgeInsets? margin;
  final double? width, height;
  final bool disabled;
  final AppButtonStyle style;
  final Color? background;

  const AppButton({
    Key? key,
    required this.label,
    this.prefix,
    this.suffix,
    this.onPressed,
    this.margin = const EdgeInsets.all(18),
    this.width,
    this.height,
    this.disabled = false,
    this.style = AppButtonStyle.primary,
    this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = disabled ? AppButtonStyle.disabled : this.style;

    return _AppCustomButton(
      label: label,
      prefix: prefix,
      suffix: suffix,
      action: disabled ? null : onPressed,
      gradient: style == AppButtonStyle.primary && background == null
          ? ThemeConfig.primaryGradient
          : null,
      color: background ?? style.background(context),
      margin: margin,
      textColor: style.textColor(context),
      border: style == AppButtonStyle.outline ||
              style == AppButtonStyle.outlineSecondary
          ? Border.all(
              color: Theme.of(context).colorScheme.onPrimary,
              width: 0.7,
            )
          : null,
      width: width,
      height: height,
    );
  }
}
