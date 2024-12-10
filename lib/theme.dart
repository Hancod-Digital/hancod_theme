import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hancod_theme/hancod_theme.dart';

class AppTheme {
  const AppTheme._();

  static const double textFieldBorderRadius = 12;

  static final lightTheme = ThemeData(
    useMaterial3: false,
    fontFamily: 'DMSans',
    colorSchemeSeed: AppColors.black,
  );

  static final darkTheme = ThemeData(useMaterial3: false);

  static Brightness get currentSystemBrightness =>
      PlatformDispatcher.instance.platformBrightness;

  static const _inputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.inputOutline),
    borderRadius: BorderRadius.all(Radius.circular(40)),
  );

  static final largeScreenInputDecoration = InputDecoration(
    focusedBorder: _inputBorder,
    enabledBorder: _inputBorder.copyWith(
      borderSide: const BorderSide(color: AppColors.inputBorder),
    ),
    border: _inputBorder.copyWith(
      borderSide: const BorderSide(color: AppColors.inputBorder),
    ),
    errorBorder: _inputBorder.copyWith(
      borderSide: const BorderSide(color: AppColors.primaryColor),
    ),
    hintStyle:
        AppText.regular12.copyWith(color: AppColors.white.withOpacity(0.5)),
  );

  static void setStatusBarAndNavigationBarColors() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
  }
}
