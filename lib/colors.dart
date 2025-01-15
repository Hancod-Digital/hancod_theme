import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF952424);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color black = Color(0xFF181A1B);
  static const Color subBlack = Color(0xFF6B7283);
  static const Color inputOutline = Color(0xFF969BA7);
  static const Color buttonOutline = Color(0xFFE6E6E6);
  static const Color dividerGrey = Color(0xFFE6E7EA);
  static const Color textfieldOutline = Color(0xFFDFEAF2);

  static const Color divider = Color(0xFFE4E4E4);
  static const Color brandColorsPrimary = Color(0xFF272727);
  static const Color brandColorsSecondary = Color(0xFFAE8160);

  static const Color LightPick = Color(0xFFFFE4E4);
   static const Color green = Color(0xFF007E2B);
  static const Color yellow = Color(0xFFF0B433);
  static const Color blueOutline = Color(0xFFECF6FF);
  static const Color blue = Color(0xFF3395F0);
}

class AppDecorations {
  static const mobileInputDecoration = InputDecoration(
    alignLabelWithHint: true,
    floatingLabelAlignment: FloatingLabelAlignment.start,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: AppColors.grey),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: AppColors.textfieldOutline),
    ),
    filled: true,
    fillColor: Colors.white,
    suffixIcon: Icon(
      Icons.keyboard_arrow_down,
      color: AppColors.primaryColor,
    ),
  );
}
