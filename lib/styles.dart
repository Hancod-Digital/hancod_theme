import 'package:flutter/material.dart';
import 'package:hancod_theme/colors.dart';

class AppStyles {
  static final boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        offset: const Offset(0, 20),
        blurRadius: 27,
        color: Colors.black.withOpacity(.05),
      ),
    ],
  );
  static const animationDuration = Duration(milliseconds: 300);

  static InputDecoration searchDecoration = InputDecoration(
    contentPadding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
    filled: true,
    fillColor: Colors.white,
    prefixIcon: const Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Icon(Icons.search, size: 25, color: AppColors.primary),
    ),
    prefixIconConstraints: const BoxConstraints(
      minWidth: 20,
      minHeight: 20,
    ),
    hintStyle: const TextStyle(color: Colors.grey),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.inputBorder),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.inputBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.inputBorder),
    ),
  );

  static InputDecoration filtrationDecoration =
      searchDecoration.copyWith(prefixIcon: null);

  static ButtonStyle buttonStyle = ButtonStyle(
    padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
  );
}
