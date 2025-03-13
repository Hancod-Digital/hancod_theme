part of '../forms.dart';

class AppDateTimeForm extends AppForm<DateTime> {
  const AppDateTimeForm({
    required super.name,
    required super.label,
    super.key,
    this.hintText,
    DateTime? super.initialValue,
    super.fieldKey,
    this.onChanged,
    this.inputFormatters,
    super.validator,
    this.inputType = InputType.both,
    this.controller,
    super.enabled,
    this.showCloseButton = false,
    this.valueTransformer,
    this.onClear,
    this.decoration = const InputDecoration(),
  });
  final void Function(DateTime?)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;
  final TextEditingController? controller;
  final InputType inputType;
  final dynamic Function(DateTime?)? valueTransformer;
  final void Function()? onClear;
  final bool showCloseButton;
  final InputDecoration decoration;
  @override
  State<AppDateTimeForm> createState() => _AppDateTimeFormState();
}

class _AppDateTimeFormState extends State<AppDateTimeForm> {
  // ignore: strict_raw_type
  final _dateFieldKey = GlobalKey<FormBuilderFieldState>();
  @override
  Widget build(BuildContext context) {
    return widget.buildContainer(
      context,
      FormBuilderDateTimePicker(
        key: _dateFieldKey,
        enabled: widget.enabled,
        validator: widget.validator,
        useRootNavigator: false,
        valueTransformer: widget.valueTransformer,
        decoration: widget.decoration.copyWith(
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.calendar_month_outlined),
              if (_dateFieldKey.currentState?.value != null &&
                  widget.showCloseButton)
                IconButton(
                  iconSize: 20,
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _dateFieldKey.currentState?.didChange(null);
                    widget.onClear?.call();
                  },
                ),
            ],
          ),
        ),
        name: widget.name,
        initialValue: widget.initialValue as DateTime?,
        inputType: widget.inputType,
        onChanged: widget.onChanged,
        fieldHintText: widget.hintText,
      ),
    );
  }
}
