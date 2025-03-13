part of '../forms.dart';

class AppToggleForm extends AppForm<bool> {
  const AppToggleForm({
    required super.name,
    required this.hint,
    bool? super.initialValue,
    super.key,
    super.validator,
    super.label,
    super.fieldKey,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.hintStyle,
    this.onChanged,
    this.activeColor,
  });
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool? val)? onChanged;
  final String hint;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final TextStyle? hintStyle;
  final Color? activeColor;
  @override
  State<AppToggleForm> createState() => _AppToggleFormState();
}

class _AppToggleFormState extends State<AppToggleForm> {
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
          return GestureDetector(
            onTap: () {
              field.didChange(!field.value!);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: widget.mainAxisAlignment,
              crossAxisAlignment: widget.crossAxisAlignment,
              children: [
                Text(widget.hint, style: widget.hintStyle ?? AppText.largeM),
                SizedBox(
                  height: 30,
                  width: 42,
                  child: Transform.scale(
                    transformHitTests: false,
                    scale: .6,
                    child: CupertinoSwitch(
                      thumbColor: AppColors.white,
                      activeTrackColor:
                          widget.activeColor ?? AppColors.primaryColor,
                      inactiveTrackColor: AppColors.stormyBlue,
                      value: field.value ?? false,
                      onChanged: (value) {
                        field.didChange(value);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
