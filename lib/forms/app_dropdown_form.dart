// ignore_for_file: strict_raw_type
part of '../forms.dart';

class AppDropDownForm<T> extends AppForm<T> {
  const AppDropDownForm({
    required super.name,
    required super.label,
    required this.items,
    super.key,
    super.validator,
    T? super.initialValue,
    super.fieldKey,
    this.onChanged,
    this.valueTransformer,
    super.enabled,
    this.prefixIcon,
    this.showCloseButton = false,
    this.onClear,
    this.decoration = const InputDecoration(),
  });
  final void Function(T?)? onChanged;
  final List<DropDownItems<T>>? items;
  final dynamic Function(T?)? valueTransformer;
  final Widget? prefixIcon;
  final bool showCloseButton;
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
        initialValue: widget.items?.any(
                  (element) => element.value == widget.initialValue as T?,
                ) ??
                false
            ? widget.initialValue as T?
            : null,
        valueTransformer: widget.valueTransformer,
        builder: (FormFieldState<dynamic> field) {
          return DropdownButtonHideUnderline(
            child: Material(
              child: InkWell(
                child: DropdownButtonFormField<T>(
                  icon: const SizedBox(),
                  value: field.value as T?,
                  decoration: widget.decoration.copyWith(
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.keyboard_arrow_down_rounded),
                        if (field.value != null && widget.showCloseButton)
                          IconButton(
                            iconSize: 20,
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              field.didChange(null);
                              widget.onClear?.call();
                            },
                          ),
                      ],
                    ),
                  ),
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
