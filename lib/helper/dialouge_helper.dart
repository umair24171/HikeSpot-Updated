import 'package:flutter/material.dart';

class DialogHelper {
  static Future<void> showGeDialog({
    required BuildContext context,
    required Widget dialog,
    Function? onDismiss,
    bool barrierDismissible = true,
  }) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (_, __, ___) => dialog,
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
          child: child,
        );
      },
    ).then((value) {
      if (onDismiss != null) {
        onDismiss();
      }
    });
  }

  static Future<void> showNormalDialog({
    required BuildContext context,
    required Widget dialog,
    bool barrierDismissible = true,
  }) {
    return showDialog(
      context: context,
      // pageBuilder: (_, __, ___) => dialog,
      builder: (context) => dialog,
      barrierDismissible: barrierDismissible,
    );
  }
}
