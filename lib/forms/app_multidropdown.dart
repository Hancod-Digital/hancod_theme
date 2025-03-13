// ignore_for_file: strict_raw_type

part of '../forms.dart';

class AppMultiSelectDropdownForm<T extends Object> extends AppForm<T> {
  const AppMultiSelectDropdownForm({
    required super.name,
    required this.future,
    this.onSearchChange,
    super.key,
    super.fieldKey,
    super.label,
    super.enabled = true,
    super.initialValue,
    this.decoration = const InputDecoration(),
    this.controller,
  });

  final void Function(String)? onSearchChange;
  final MultiSelectController<T>? controller;
  final Future<List<DropdownItem<T>>> Function() future;
  final InputDecoration decoration;

  @override
  State<AppMultiSelectDropdownForm<T>> createState() =>
      _AppMultiSelectDropdownFormState();
}

class _AppMultiSelectDropdownFormState<T extends Object>
    extends State<AppMultiSelectDropdownForm<T>> {
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
    return widget.buildContainer(
      context,
      FormBuilderField<List<T>>(
        name: widget.name,
        key: _key,
        builder: (field) {
          return MultiDropdown<T>.future(
            controller: _controller,
            searchDecoration: SearchFieldDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: AppColors.stormyBlue),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: Colors.blueGrey[300]!),
              ),
            ),
            fieldDecoration: FieldDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: AppColors.stormyBlue),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: Colors.blueGrey[300]!),
              ),
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
