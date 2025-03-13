import 'package:flutter/material.dart';

class AppStyles {
  static final boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        offset: const Offset(0, 20),
        blurRadius: 27,
        color: Colors.black.withValues(alpha: .05),
      ),
    ],
  );
  static const animationDuration = Duration(milliseconds: 300);
}
