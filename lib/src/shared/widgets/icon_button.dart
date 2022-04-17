import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final Widget? icon;
  final VoidCallback? onPressed;
  const AppIconButton({Key? key, this.icon, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.all(4),
        child: icon,
      ),
    );
  }
}
