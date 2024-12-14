// ignore_for_file: strict_raw_type

part of '../forms.dart';

class AppTextForm<T> extends AppForm<T> {
  const AppTextForm({
    required super.name,
    super.label,
    super.key,
    this.hintText,
    super.initialValue,
    super.fieldKey,
    this.onChanged,
    this.inputFormatters,
    this.minLines = 1,
    this.controller,
    this.enableObscureText = false,
    this.keyboardType,
    super.validator,
    super.autovalidateMode,
    this.onSubmitted,
    this.focusNode,
    super.enabled,
    this.prefixIcon,
    this.suffixIcon,
    this.isReadOnly = false,
    this.decoration = const InputDecoration(),
    this.style,
    this.onFocusLose,
  });

  final void Function(T? value)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final int minLines;
  final String? hintText;
  final TextEditingController? controller;
  final bool enableObscureText;
  final TextInputType? keyboardType;
  final void Function(T value)? onSubmitted;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isReadOnly;
  final InputDecoration decoration;
  final TextStyle? style;
  final void Function(T? value)? onFocusLose;
  @override
  State<AppTextForm<T>> createState() => _AppTextFormState();
}

class _AppTextFormState<T> extends State<AppTextForm<T>> {
  bool isObscure = true;
  late GlobalKey<FormBuilderFieldState> _key;
  late FocusNode _focusNode;
  @override
  void initState() {
    super.initState();
    _key = widget.fieldKey ?? GlobalKey<FormBuilderFieldState>();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        final val = _key.currentState?.value as String?;
        widget.onFocusLose?.call(
          switch (T) {
            String => val as T?,
            int => val == null ? null : int.tryParse(val) as T?,
            double => val == null ? null : double.tryParse(val) as T?,
            _ => val as T?
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.buildContainer(
      context,
      FormBuilderTextField(
        autovalidateMode: widget.autovalidateMode,
        name: widget.name,
        enabled: widget.enabled,
        key: _key,
        controller: widget.controller,
        decoration: widget.decoration.copyWith(
          hintText: widget.hintText,
          suffixIcon: widget.enableObscureText
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: isObscure
                      ? const Icon(Icons.visibility_outlined)
                      : const Icon(Icons.visibility_off_outlined),
                )
              : widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
        ),
        onChanged: (val) {
          widget.onChanged?.call(
            switch (T) {
              String => val as T?,
              int => val == null ? null : int.tryParse(val) as T?,
              double => val == null ? null : double.tryParse(val) as T?,
              _ => val as T?
            },
          );
        },
        validator: (val) {
          return switch (T) {
            String => widget.validator?.call(val as T?),
            int => widget.validator
                ?.call(val == null ? null : int.tryParse(val) as T?),
            double => widget.validator
                ?.call(val == null ? null : double.tryParse(val) as T?),
            Type() => widget.validator?.call(val as T?),
          };
        },
        initialValue: switch (T) {
          String => widget.initialValue as String?,
          int => widget.initialValue?.toString(),
          double => widget.initialValue?.toString(),
          _ => widget.initialValue?.toString()
        },
        valueTransformer: (value) {
          return switch (T) {
            String => value as T?,
            int => value == null ? null : int.tryParse(value) as T?,
            double => value == null ? null : double.tryParse(value) as T?,
            _ => value as T?
          };
        },
        readOnly: widget.isReadOnly,
        minLines: widget.minLines,
        focusNode: _focusNode,
        obscureText: widget.enableObscureText && isObscure,
        style: widget.style,
        maxLines: widget.minLines,
        inputFormatters: [
          if (T == double)
            TextInputFormatter.withFunction(
              (TextEditingValue oldValue, TextEditingValue newValue) {
                // return TextEditingValue(text: newValue.text);
                // Handle empty string case
                if (newValue.text.isEmpty) {
                  return newValue;
                }

                // Allow only one decimal point
                if (newValue.text.split('.').length > 2) {
                  return oldValue;
                }

                String newString;
                if (newValue.text.startsWith('-')) {
                  // Handle negative numbers
                  final digitsAfterMinus = newValue.text.substring(1);
                  if (digitsAfterMinus.isEmpty) {
                    return newValue; // Allow just the minus sign
                  }
                  // Replace anything that's not a digit or decimal point
                  newString =
                      '-${digitsAfterMinus.replaceAll(RegExp(r'[^\d.]'), '')}';
                } else {
                  // Replace anything that's not a digit or decimal point
                  newString = newValue.text.replaceAll(RegExp(r'[^\d.]'), '');
                }

                // Prevent multiple zeros at start
                if (newString.startsWith('00')) {
                  return oldValue;
                }

                // Handle decimal point cases
                if (newString.contains('.')) {
                  // Split into integer and decimal parts
                  final parts = newString.split('.');

                  // If decimal part has more than 2 digits, truncate it
                  if (parts[1].length > 2) {
                    parts[1] = parts[1].substring(0, 2);
                    newString = parts.join('.');
                  }

                  // If it's just a decimal point, add zero before it
                  if (parts[0].isEmpty) {
                    newString = '0$newString';
                  }
                }

                // Handle the case where string ends with a decimal point
                if (newString.endsWith('.')) {
                  // Allow the decimal point to be typed
                  return newValue.copyWith(
                    text: newString,
                    selection:
                        TextSelection.collapsed(offset: newString.length),
                  );
                }

                // Validate the final string is a valid double
                try {
                  if (newString.isNotEmpty && newString != '-') {
                    double.parse(newString);
                  }
                } catch (e) {
                  return oldValue;
                }

                return TextEditingValue(
                  text: newString,
                  selection: TextSelection.collapsed(
                    offset: math.min(newString.length, newValue.selection.end),
                  ),
                );
              },
            ),
          if (T == int)
            TextInputFormatter.withFunction(
              (TextEditingValue oldValue, TextEditingValue newValue) {
                String newString;
                if (newValue.text.startsWith('-')) {
                  newString = '-${newValue.text.replaceAll(RegExp(r'\D'), '')}';
                } else {
                  newString = newValue.text.replaceAll(RegExp(r'\D'), '');
                }
                return newValue.copyWith(
                  text: newString,
                  selection: newValue.selection.copyWith(
                    baseOffset: newValue.selection.baseOffset
                        .clamp(0, newString.length),
                    extentOffset: newValue.selection.extentOffset
                        .clamp(0, newString.length),
                  ),
                );
              },
            ),
          ...widget.inputFormatters ?? [],
        ],
        keyboardType: widget.keyboardType,
        onSubmitted: (value) {
          if (value == null) return;
          widget.onSubmitted?.call(
            switch (T) {
              String => value as T,
              int => int.tryParse(value) as T,
              double => double.tryParse(value) as T,
              _ => value as T
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }
}
