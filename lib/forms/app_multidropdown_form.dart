// ignore_for_file: strict_raw_type

part of '../forms.dart';

class AppMultiDropDownForm<T extends Object> extends AppForm<T> {
  const AppMultiDropDownForm({
    required super.name,
    required this.future,
    this.onSearchChange,
    super.key,
    super.fieldKey,
    super.label,
    super.enabled = true,
    super.initialValue,
    super.decoration,
    this.controller,
  });

  final void Function(String)? onSearchChange;
  final MultiSelectController<T>? controller;
  final Future<List<DropdownItem<T>>> Function() future;
  @override
  State<AppMultiDropDownForm<T>> createState() => _AppMultiDropDownFormState();
}

class _AppMultiDropDownFormState<T extends Object>
    extends State<AppMultiDropDownForm<T>> {
  late GlobalKey<FormBuilderFieldState> _key;
  late MultiSelectController<T> _controller;
  @override
  void initState() {
    super.initState();
    _key = widget.fieldKey ?? GlobalKey<FormBuilderFieldState>();
    _controller = widget.controller ?? MultiSelectController<T>();
  }

  @override
  Widget build(BuildContext context) {
    final decoration = widget.decoration ?? AppTheme.largeScreenInputDecoration;
    return widget.buildContainer(
      context,
      FormBuilderField<List<T>>(
        name: widget.name,
        key: _key,
        builder: (field) {
          return MultiDropdown<T>.future(
            controller: _controller,
            fieldDecoration: FieldDecoration(
              border: decoration.border,
              focusedBorder: decoration.focusedBorder,
              errorBorder: decoration.errorBorder,
            ),
            dropdownDecoration: DropdownDecoration(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            future: widget.future,
            onSelectionChange: field.didChange,
            searchEnabled: true,
            onSearchChange: widget.onSearchChange,
          );
        },
      ),
    );
  }
}
