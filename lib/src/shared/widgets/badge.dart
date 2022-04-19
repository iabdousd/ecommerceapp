import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

enum BadgeStyle { whiteBubble, primaryBubble, noContent, inactive }

extension on BadgeStyle {
  Color getColor(BuildContext context) {
    switch (this) {
      case BadgeStyle.whiteBubble:
      case BadgeStyle.noContent:
        return Theme.of(context).primaryColor;
      case BadgeStyle.primaryBubble:
        return Theme.of(context).colorScheme.onPrimary;
      case BadgeStyle.inactive:
        return Theme.of(context).disabledColor;
    }
  }

  Color getBadgeColor(BuildContext context) {
    switch (this) {
      case BadgeStyle.whiteBubble:
      case BadgeStyle.noContent:
      case BadgeStyle.inactive:
        return Theme.of(context).backgroundColor;
      case BadgeStyle.primaryBubble:
        return Theme.of(context).primaryColor;
    }
  }
}

class AppBadge extends StatelessWidget {
  final int value;
  final Widget? child;
  final BadgeStyle style;

  const AppBadge({
    Key? key,
    required this.value,
    this.child,
    this.style = BadgeStyle.whiteBubble,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (value == 0 && child == null) return const SizedBox.shrink();

    return Badge(
      showBadge: value > 0,
      badgeContent: Text(
        style == BadgeStyle.noContent
            ? ' '
            : value > 9
                ? '+9'
                : '$value',
        style: Theme.of(context).textTheme.subtitle2!.apply(
              color: style.getColor(context),
            ),
      ),
      padding: EdgeInsets.all(value > 9 ? 4 : 6),
      position: BadgePosition.topEnd(top: -16, end: -8),
      badgeColor: style.getBadgeColor(context),
      child: child,
    );
  }
}
