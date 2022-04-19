import 'package:ecommerceapp/src/configs/navigator.dart';
import 'package:flutter/material.dart';

enum FlushbarType { info, error, success }

extension on FlushbarType {
  Color get color {
    switch (this) {
      case FlushbarType.info:
        return Colors.blue;
      case FlushbarType.error:
        return Colors.red;
      case FlushbarType.success:
        return Colors.green;
    }
  }

  IconData get icon {
    switch (this) {
      case FlushbarType.info:
        return Icons.info;
      case FlushbarType.error:
        return Icons.error;
      case FlushbarType.success:
        return Icons.done;
    }
  }
}

class Flushbar {
  static void _show(BuildContext context, String info, FlushbarType type) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: Directionality.of(context) == TextDirection.ltr ? 8 : 0,
                left: Directionality.of(context) == TextDirection.rtl ? 8 : 0,
              ),
              child: Icon(type.icon, size: 20, color: type.color),
            ),
            Expanded(
              child: Text(
                info,
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      color: type.color,
                    ),
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        duration: const Duration(seconds: 4),
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 4,
      ),
    );
  }

  static BuildContext get context => AppNavigator.router.navigator!.context;

  static void showInfo(String info) => _show(context, info, FlushbarType.info);

  static void showSuccess(String info) =>
      _show(context, info, FlushbarType.success);

  static void showError(String info) =>
      _show(context, info, FlushbarType.error);
}
