import 'package:ecommerceapp/src/configs/theme.dart';
import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final Widget? icon;
  final VoidCallback? onPressed;
  final EdgeInsets margin;
  const AppIconButton({
    Key? key,
    this.icon,
    this.onPressed,
    this.margin = const EdgeInsets.all(4),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          shape: BoxShape.circle,
          boxShadow: const [DefaultBoxShadow(small: true)],
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(6),
        margin: margin,
        child: icon,
      ),
    );
  }
}
