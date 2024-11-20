// ignore_for_file: strict_raw_type

part of '../forms.dart';

class AppToggleForm extends AppForm<bool> {
  const AppToggleForm({
    required super.name,
    required this.hint,
    super.key,
    super.validator,
    super.label,
    super.fieldKey,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.onChanged,
    super.initialValue,
  });
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool? val)? onChanged;
  final Widget hint;
  final MainAxisAlignment mainAxisAlignment;
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
        initialValue: widget.initialValue,
        builder: (FormFieldState<bool> field) {
          return GestureDetector(
            onTap: () {
              field.didChange(!field.value!);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: widget.mainAxisAlignment,
              children: [
                widget.hint,
                SizedBox(
                  height: 30,
                  width: 42,
                  child: Transform.scale(
                    transformHitTests: false,
                    scale: .8,
                    child: CupertinoSwitch(
                      thumbColor: AppColors.white,
                      activeColor: AppColors.primary,
                      trackColor: AppColors.secondary,
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
