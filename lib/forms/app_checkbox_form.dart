part of '../forms.dart';

class AppCheckBoxForm extends AppForm<bool> {
  const AppCheckBoxForm({
    required super.name,
    required this.hint,
    super.key,
    super.validator,
    super.label,
    super.fieldKey,
    this.onChanged,
    bool? super.initialValue,
    this.hintStyle,
    this.controlAffinity = ListTileControlAffinity.leading,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    super.enabled,
  });
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool? val)? onChanged;
  final String hint;
  final TextStyle? hintStyle;
  final ListTileControlAffinity controlAffinity;
  final CrossAxisAlignment crossAxisAlignment;
  @override
  State<AppCheckBoxForm> createState() => _AppCheckBoxFormState();
}

class _AppCheckBoxFormState extends State<AppCheckBoxForm> {
  @override
  Widget build(BuildContext context) {
    return widget.buildContainer(
      context,
      FormBuilderField(
        name: widget.name,
        validator: widget.validator,
        onChanged: widget.onChanged,
        initialValue: widget.initialValue as bool? ?? false,
        builder: (FormFieldState<bool> field) {
          Widget? leading;
          Widget? trailing;
          final control = Checkbox(
            value: field.value ?? false,
            onChanged: (value) {
              if (!widget.enabled) return;
              field.didChange(value);
            },
          );
          final secondary = Text(
            widget.hint,
            overflow: TextOverflow.ellipsis,
            style: widget.hintStyle ??
                AppText.largeN.copyWith(color: AppColors.stormyBlue),
          );
          switch (widget.controlAffinity) {
            case ListTileControlAffinity.leading:
              leading = control;
              trailing = secondary;
            case ListTileControlAffinity.trailing:
            case ListTileControlAffinity.platform:
              leading = secondary;
              trailing = control;
          }
          return GestureDetector(
            onTap: () {
              if (!widget.enabled) return;
              field.didChange(!field.value!);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: widget.crossAxisAlignment,
              children: [leading, trailing],
            ),
          );
        },
      ),
    );
  }
}
