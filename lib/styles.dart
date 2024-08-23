import 'package:flutter/material.dart';

class AppStyles {
  static final boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        offset: const Offset(0, 4),
        blurRadius: 25,
        spreadRadius: 0,
        color: Colors.black.withOpacity(0.10),
      ),
    ],
  );
  static final boxDecorationItems = BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        offset: const Offset(0, 10),
        blurRadius: 15,
        spreadRadius: -3,
        color: Colors.black.withOpacity(0.10),
      ),
      BoxShadow(
        offset: const Offset(0, 4),
        blurRadius: 6,
        spreadRadius: 0,
        color: Colors.black.withOpacity(0.05),
      ),
    ],
  );

  static const animationDuration = Duration(milliseconds: 300);
}
