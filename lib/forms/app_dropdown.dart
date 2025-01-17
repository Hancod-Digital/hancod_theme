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
    super.decoration,
    this.onChanged,
    this.valueTransformer,
    super.enabled,
    this.prefixIcon,
    this.dontShowCloseButton = false,
    this.onClear,
  });
  final void Function(T?)? onChanged;
  final List<DropDownItems<T>>? items;
  final dynamic Function(T?)? valueTransformer;
  final Widget? prefixIcon;
  final bool dontShowCloseButton;
  final void Function()? onClear;

  @override
  State<AppDropDownForm<T>> createState() => _AppDropDownFormState();
}

class _AppDropDownFormState<T> extends State<AppDropDownForm<T>> {
  @override
  Widget build(BuildContext context) {
    return widget.buildContainer(
      context,
      FormBuilderField<T>(
        enabled: widget.enabled,
        name: widget.name,
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
                  decoration:
                      (widget.decoration ?? AppTheme.largeScreenInputDecoration)
                          .copyWith(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    filled: true,
                    fillColor: AppColors.white,
                    prefixIcon: widget.prefixIcon,
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.keyboard_arrow_down_rounded),
                        if (field.value != null && !widget.dontShowCloseButton)
                          IconButton(
                            icon: const Icon(Icons.close, size: 20),
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
