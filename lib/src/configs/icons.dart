import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

enum AppIconColor { custom, primary }

class AppIcon extends StatelessWidget {
  final String? path;
  final double? size;
  final EdgeInsetsGeometry padding;
  final AppIconColor color;
  final Color? customColor;
  final IconData? iconData;

  const AppIcon({
    Key? key,
    this.path,
    this.size,
    this.padding = EdgeInsets.zero,
    this.color = AppIconColor.custom,
    this.customColor,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = this.color == AppIconColor.primary
        ? Theme.of(context).primaryColor
        : customColor;

    if (iconData != null) {
      return Padding(
        child: Icon(iconData, size: size, color: color),
        padding: padding,
      );
    }

    return Padding(
      padding: padding,
      child: SizedBox.square(
        dimension: size,
        child: path!.endsWith('.svg')
            ? SvgPicture.asset(path!, color: color)
            : Image.asset(path!, color: color),
      ),
    );
  }

  AppIcon apply({
    AppIconColor? color,
    Color? customColor,
    double? size,
    EdgeInsets? padding,
  }) =>
      AppIcon(
        path: path,
        size: size ?? this.size,
        padding: padding ?? this.padding,
        color: color ?? this.color,
        customColor: customColor ?? this.customColor,
        iconData: iconData,
      );
}

class AppIcons {
  static const logo = AppIcon(path: 'assets/icons/logo.png');
  static const icon = AppIcon(path: 'assets/icons/icon.png', size: 240);
}
