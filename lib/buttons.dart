import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hancod_theme/hancod_theme.dart';

enum ButtonStyles { primary, secondary, cancel, delete }

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
    this.foregroundColor,
    this.backgroundColor,
  });

  factory AppButton.icon({
    required Widget icon,
    required VoidCallback? onPress,
    required Widget label,
    Key? key,
    bool isLoading,
    double width,
    ButtonStyles style,
    EdgeInsetsGeometry padding,
  }) = _AppButtonWithIcon;

  final VoidCallback? onPress;
  final Widget label;
  final bool isLoading;
  final double width;
  final double? height;
  final ButtonStyles style;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final WidgetStateProperty<Color?>? foregroundColor;
  final WidgetStateProperty<Color?>? backgroundColor;

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
        padding: WidgetStateProperty.resolveWith((states) => widget.padding),
        shape: WidgetStateProperty.resolveWith(
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
            ButtonStyles.delete => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
          },
        ),
        foregroundColor: widget.foregroundColor ??
            WidgetStateProperty.resolveWith(
              (states) => switch (widget.style) {
                ButtonStyles.primary => AppColors.white,
                ButtonStyles.secondary => widget.color ?? AppColors.primary,
                ButtonStyles.cancel => widget.color ?? AppColors.primary,
                ButtonStyles.delete => AppColors.redStatus500,
              },
            ),
        backgroundColor: widget.backgroundColor ??
            WidgetStateProperty.resolveWith(
              (states) => switch (widget.style) {
                ButtonStyles.primary => widget.color ?? AppColors.primary,
                ButtonStyles.secondary =>
                  Theme.of(context).scaffoldBackgroundColor,
                ButtonStyles.cancel =>
                  Theme.of(context).scaffoldBackgroundColor,
                ButtonStyles.delete => AppColors.redStatus500,
              },
            ),
        overlayColor: WidgetStateProperty.resolveWith(
          (states) => switch (widget.style) {
            ButtonStyles.primary =>
              Theme.of(context).scaffoldBackgroundColor.withOpacity(.1),
            ButtonStyles.secondary =>
              (widget.color ?? AppColors.primary).withOpacity(.05),
            ButtonStyles.cancel =>
              (widget.color ?? AppColors.primary).withOpacity(.05),
            ButtonStyles.delete => AppColors.redStatus100,
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
    super.style,
    super.isLoading,
    super.width,
    super.padding,
  }) : super(label: _AppButtonWithIconChild(icon: icon, label: label));
}

class _AppButtonWithIconChild extends StatelessWidget {
  const _AppButtonWithIconChild({
    required this.label,
    required this.icon,
  });

  final Widget label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.textScalerOf(context).scale(14);
    final gap = scale <= 1 ? 8 : lerpDouble(8, 4, math.min(scale - 1, 1))!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        icon,
        SizedBox(width: gap.toDouble()),
        Flexible(child: label),
      ],
    );
  }
}

class GradientAppButton extends StatelessWidget {
  const GradientAppButton({
    required this.onPressed,
    required this.child,
    super.key,
    this.width = double.infinity,
    this.height = 48,
    this.isEnabled = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
  });
  final VoidCallback? onPressed;
  final Widget child;
  final double width;
  final double height;
  final bool isEnabled;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: isEnabled
                ? const LinearGradient(
                    colors: [
                      AppColors.gradientCOLOR1,
                      AppColors.gradientCOLOR2,
                      AppColors.gradientCOLOR3,
                    ],
                  )
                : null,
            color: isEnabled ? null : const Color(0xFFCCCCCC),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: width,
            height: height,
            padding: padding,
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }
}
