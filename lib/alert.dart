import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hancod_theme/hancod_theme.dart';

enum SnackBarType { success, error, warning, info }

extension on SnackBarType {
  // Change this according to type
  Color get bgColor => switch (this) {
        SnackBarType.success => AppColors.successBg,
        SnackBarType.error => AppColors.errorBg,
        SnackBarType.warning => AppColors.warningBg,
        SnackBarType.info => AppColors.infoBg,
      };

  Color get textColor => switch (this) {
        SnackBarType.success => AppColors.successText,
        SnackBarType.error => AppColors.errorText,
        SnackBarType.warning => AppColors.warningText,
        SnackBarType.info => AppColors.infoText,
      };

  IconData get icon => switch (this) {
        SnackBarType.success => CupertinoIcons.check_mark_circled,
        SnackBarType.error => CupertinoIcons.xmark_circle,
        SnackBarType.warning => CupertinoIcons.exclamationmark_triangle,
        SnackBarType.info => CupertinoIcons.info,
      };

  Color get borderColor => switch (this) {
        SnackBarType.success => AppColors.successBorder,
        SnackBarType.error => AppColors.errorBorder,
        SnackBarType.warning => AppColors.warningBorder,
        SnackBarType.info => AppColors.infoBorder,
      };
}

extension SnackBarX on BuildContext {
  void showSnackBar(String message, {SnackBarType type = SnackBarType.info}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(
            color: type.borderColor,
          ),
        ),
        duration: const Duration(milliseconds: 2500),
        behavior: SnackBarBehavior.floating,
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              type.icon,
              color: type.textColor,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: AppText.medium2.copyWith(
                  fontFamily: 'Lato',
                  color: const Color(0xff181818),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: type.bgColor,
        width: 400,
        elevation: 0,
      ),
    );
  }
}
