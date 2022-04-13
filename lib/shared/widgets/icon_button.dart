import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final Widget? icon;
  final VoidCallback? onPressed;
  const AppIconButton({Key? key, this.icon, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(padding: const EdgeInsets.all(6), child: icon),
    );
  }
}
