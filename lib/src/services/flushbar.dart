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
                right: Directionality.of(context) == TextDirection.ltr ? 2 : 0,
                left: Directionality.of(context) == TextDirection.rtl ? 2 : 0,
              ),
              child: Icon(type.icon, size: 8, color: type.color),
            ),
            Expanded(
              child: Text(
                info,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: type.color),
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        duration: const Duration(seconds: 5),
        margin: const EdgeInsets.all(5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.5),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: .5,
      ),
    );
  }

  static void showInfo(BuildContext context, String info) =>
      _show(context, info, FlushbarType.info);

  static void showSuccess(BuildContext context, String info) =>
      _show(context, info, FlushbarType.success);

  static void showError(BuildContext context, String info) =>
      _show(context, info, FlushbarType.error);
}
