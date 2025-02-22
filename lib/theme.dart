import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hancod_theme/hancod_theme.dart';

class AppTheme {
  const AppTheme._();

  static const double textFieldBorderRadius = 12;

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color.fromRGBO(248, 248, 248, 1),
    useMaterial3: false,
    fontFamily: 'PlusJakartaSans',
    colorSchemeSeed: AppColors.primaryColor,
    dialogBackgroundColor: Colors.white,
  );

  static final darkTheme = ThemeData(useMaterial3: false);

  static Brightness get currentSystemBrightness =>
      PlatformDispatcher.instance.platformBrightness;

  static const _inputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.inputOutline),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );

  static final largeScreenInputDecoration = InputDecoration(
    border: _inputBorder,
    enabledBorder: _inputBorder,
    focusedBorder: _inputBorder.copyWith(
      borderSide: const BorderSide(color: AppColors.subBlack),
    ),
    errorBorder: _inputBorder.copyWith(
      borderSide: const BorderSide(color: AppColors.primaryColor),
    ),
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
