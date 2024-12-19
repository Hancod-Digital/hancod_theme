import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hancod_theme/hancod_theme.dart';

enum ButtonStyles {
  primary,
  secondary,
  cancel,
  delete,
  success,
}

class AppButton extends StatefulWidget {
  const AppButton({
    required this.onPress,
    required this.label,
    super.key,
    this.isLoading = false,
    this.width = double.infinity,
    this.height,
    this.style = ButtonStyles.primary,
    this.padding = const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
    this.color,
  });

  factory AppButton.icon({
    required Widget icon,
    required VoidCallback? onPress,
    required Widget label,
    Key? key,
    bool? isLoading,
    double? width,
    ButtonStyles? style,
    EdgeInsetsGeometry? padding,
    bool? isIconRight,
  }) = _AppButtonWithIcon;

  final VoidCallback? onPress;
  final Widget label;
  final bool isLoading;
  final double width;
  final double? height;
  final ButtonStyles style;
  final EdgeInsetsGeometry padding;
  final Color? color;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isClickable = true;
  Timer? _timer;
  final borderRadius = 10.0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.resolveWith((states) => widget.padding),
        shape: MaterialStateProperty.resolveWith(
          (states) => switch (widget.style) {
            ButtonStyles.primary => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ButtonStyles.secondary => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                side: BorderSide(
                  color: widget.color ?? AppColors.primary,
                ),
              ),
            ButtonStyles.cancel => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                side: const BorderSide(color: AppColors.buttonOutline),
              ),
            ButtonStyles.delete ||
            ButtonStyles.success =>
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => switch (widget.style) {
            ButtonStyles.primary => AppColors.white,
            ButtonStyles.secondary => widget.color ?? AppColors.primary,
            ButtonStyles.cancel => widget.color ?? AppColors.primary,
            ButtonStyles.delete => AppColors.redStatus500,
            ButtonStyles.success => AppColors.success500,
          },
        ),
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => switch (widget.style) {
            ButtonStyles.primary => widget.color ?? AppColors.primary,
            ButtonStyles.secondary => Theme.of(context).scaffoldBackgroundColor,
            ButtonStyles.cancel => Theme.of(context).scaffoldBackgroundColor,
            ButtonStyles.delete => AppColors.redStatus500,
            ButtonStyles.success => AppColors.success200,
          },
        ),
        overlayColor: MaterialStateProperty.resolveWith(
          (states) => switch (widget.style) {
            ButtonStyles.primary =>
              Theme.of(context).scaffoldBackgroundColor.withOpacity(.1),
            ButtonStyles.secondary =>
              (widget.color ?? AppColors.primary).withOpacity(.05),
            ButtonStyles.cancel =>
              (widget.color ?? AppColors.primary).withOpacity(.05),
            ButtonStyles.delete => AppColors.redStatus100,
            ButtonStyles.success => Colors.green.shade600,
          },
        ),
        elevation: MaterialStateProperty.all(6),
        shadowColor: MaterialStateProperty.resolveWith(
          (states) => switch (widget.style) {
            ButtonStyles.primary ||
            ButtonStyles.secondary ||
            ButtonStyles.cancel =>
              AppColors.primary.withOpacity(.05),
            ButtonStyles.delete => AppColors.redStatus500,
            ButtonStyles.success => Colors.green.withOpacity(.05),
          },
        ),
        fixedSize: MaterialStatePropertyAll(Size.fromWidth(widget.width)),
      ),
      onPressed: (widget.isLoading || !_isClickable)
          ? null
          : () async {
              if (!_isClickable) return;
              setState(() {
                _isClickable = false;
              });
              try {
                widget.onPress?.call();
              } finally {
                // Set a timer to re-enable the button after a delay
                _timer = Timer(const Duration(milliseconds: 100), () {
                  if (mounted) {
                    setState(() {
                      _isClickable = true;
                    });
                  }
                });
              }
            },
      child: widget.isLoading
          ? const SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(color: AppColors.white),
            )
          : widget.label,
    );
  }
}

class _AppButtonWithIcon extends AppButton {
  _AppButtonWithIcon({
    required super.onPress,
    required Widget icon,
    required Widget label,
    super.key,
    ButtonStyles? style,
    bool? isLoading,
    double? width,
    EdgeInsetsGeometry? padding,
    bool? isIconRight,
  }) : super(
          label: _AppButtonWithIconChild(
            icon: icon,
            label: label,
            isIconRight: isIconRight ?? false,
          ),
          style: style ?? ButtonStyles.primary,
          isLoading: isLoading ?? false,
          width: width ?? double.infinity,
          padding: padding ??
              const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        );
}

class _AppButtonWithIconChild extends StatelessWidget {
  const _AppButtonWithIconChild({
    required this.label,
    required this.icon,
    this.isIconRight = false,
  });

  final Widget label;
  final Widget icon;
  final bool isIconRight;

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.textScalerOf(context).scale(14);
    final gap = scale <= 1 ? 8 : lerpDouble(8, 4, math.min(scale - 1, 1))!;

    final children = [
      if (!isIconRight) icon,
      SizedBox(width: gap.toDouble()),
      Flexible(child: label),
      if (isIconRight) ...[
        SizedBox(width: gap.toDouble()),
        icon,
      ],
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}
