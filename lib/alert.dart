import 'package:flutter/material.dart';
import 'package:hancod_theme/hancod_theme.dart';

enum SnackBarType { success, error, warning, info, statsUpdated }

extension on SnackBarType {
  // Change this according to type
  Color get bgColor => switch (this) { _ => AppColors.primary };

  // Add text color getter
  Color get textColor => switch (this) {
        SnackBarType.statsUpdated => Colors.white,
        _ => Colors.black, // default text color for other types
      };
}

extension SnackBarX on BuildContext {
  void showSnackBar(String message,
      {SnackBarType type = SnackBarType.info, Color? color}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 2500),
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: TextStyle(color: type.textColor),
        ),
        backgroundColor: color ?? type.bgColor,
      ),
    );
  }
}
