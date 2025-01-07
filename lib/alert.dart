import 'package:flutter/material.dart';
import 'package:hancod_theme/hancod_theme.dart';

enum SnackBarType { success, error, warning, info }

extension on SnackBarType {
  // Change this according to type
  Color get bgColor => switch (this) {
        SnackBarType.success => AppColors.green,
        SnackBarType.error => AppColors.primaryColor,
        SnackBarType.warning => AppColors.yellow,
        SnackBarType.info => AppColors.blue,
      };
}

extension SnackBarX on BuildContext {
  void showSnackBar(String message, {SnackBarType type = SnackBarType.info}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 2500),
        behavior: SnackBarBehavior.floating,
        content: Text(message),
        backgroundColor: type.bgColor,
        width: 400,
      ),
    );
  }
}
