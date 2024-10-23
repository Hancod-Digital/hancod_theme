// ignore_for_file: strict_raw_type
part of '../forms.dart';

class AppDropDownForm<T> extends AppForm<T> {
  const AppDropDownForm({
    required super.name,
    required super.label,
    required this.items,
    super.key,
    super.validator,
    super.initialValue,
    super.fieldKey,
    this.onChanged,
    this.valueTransformer,
    super.enabled,
    this.prefixIcon,
    this.dontShowCloseButton = false,
    this.onClear,
    this.decoration = const InputDecoration(),
  });
  final void Function(T?)? onChanged;
  final List<DropDownItems<T>>? items;
  final dynamic Function(T?)? valueTransformer;
  final Widget? prefixIcon;
  final bool dontShowCloseButton;
  final void Function()? onClear;
  final InputDecoration decoration;

  @override
  State<AppDropDownForm<T>> createState() => _AppDropDownFormState();
}

class _AppDropDownFormState<T> extends State<AppDropDownForm<T>> {
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
      FormBuilderField<T>(
        enabled: widget.enabled,
        name: widget.name,
        key: key,
        validator: widget.validator,
        onChanged: widget.onChanged,
        initialValue: widget.items
                    ?.any((element) => element.value == widget.initialValue) ??
                false
            ? widget.initialValue
            : null,
        valueTransformer: widget.valueTransformer,
        builder: (FormFieldState<dynamic> field) {
          return DropdownButtonHideUnderline(
            child: Material(
              child: InkWell(
                child: DropdownButtonFormField<T>(
                  icon: const SizedBox(),
                  value: field.value as T?,
                  decoration: widget.decoration,
                  validator: widget.validator,
                  menuMaxHeight: 500,
                  elevation: 2,
                  isExpanded: true,
                  items: widget.items,
                  onChanged: widget.enabled
                      ? (val) {
                          field.didChange(val);
                        }
                      : null,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
