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
    this.maxLength = 50,
    this.controller,
    this.enableObscureText = false,
    this.keyboardType,
    super.validator,
    this.onSubmitted,
    this.focusNode,
    super.enabled,
    this.prefixIcon,
    this.suffixIcon,
    this.isReadOnly = false,
    this.decoration,
  });

  final void Function(T? value)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final int minLines;
  final int maxLength;
  final String? hintText;
  final TextEditingController? controller;
  final bool enableObscureText;
  final TextInputType? keyboardType;
  final void Function(T value)? onSubmitted;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isReadOnly;
  final InputDecoration? decoration;
  @override
  State<AppTextForm<T>> createState() => _AppTextFormState();
}

class _AppTextFormState<T> extends State<AppTextForm<T>> {
  bool isObscure = true;
  late GlobalKey<FormBuilderFieldState> key;
  @override
  void initState() {
    super.initState();
    key = widget.fieldKey ?? GlobalKey<FormBuilderFieldState>();
  }

  @override
  Widget build(BuildContext context) {
    return widget.buildContainer(
      context,
      FormBuilderTextField(
        maxLength: widget.maxLength,
        name: widget.name,
        enabled: widget.enabled,
        key: key,
        controller: widget.controller,
        decoration: widget.decoration ??
            _mobileInputDecoration.copyWith(
              counterText:'',
              hintText: widget.hintText,
              labelText: '',
              prefixIcon: widget.prefixIcon,
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
            ),
        onChanged: (value) {
          widget.onChanged?.call(
            switch (T) {
              String => value as T?,
              int => value == null ? null : int.tryParse(value) as T?,
              double => value == null ? null : double.tryParse(value) as T?,
              _ => value as T?
            },
          );
        },
        validator: (val) {
          return switch (T) {
            String => widget.validator?.call(val as T?),
            int => widget.validator?.call(int.tryParse(val ?? '0') as T?),
            double => widget.validator?.call(double.tryParse(val ?? '0') as T?),
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
        focusNode: widget.focusNode,
        obscureText: widget.enableObscureText && isObscure,
        maxLines: widget.minLines,
        inputFormatters: [
          if (T == double)
            FilteringTextInputFormatter.allow(
              RegExp(r'^\d*\.?\d*$'),
            ),
          if (T == int)
            FilteringTextInputFormatter.allow(
              RegExp(r'^[0-9]*$'),
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
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}

const _mobileInputDecoration = InputDecoration(
  alignLabelWithHint: true,
  floatingLabelAlignment: FloatingLabelAlignment.start,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    // ignore: avoid_redundant_argument_values
    borderSide: BorderSide(color: AppColors.grey),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    // ignore: avoid_redundant_argument_values
    borderSide: BorderSide(color: AppColors.textfieldOutline),
  ),
  filled: true,
  fillColor: Colors.white,
);
