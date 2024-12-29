// ignore_for_file: strict_raw_type

part of '../forms.dart';

class AppTypeAheadForm<T> extends AppForm<T> {
  const AppTypeAheadForm({
    required super.name,
    required this.suggestionsCallback,
    required this.itemBuilder,
    super.key,
    super.fieldKey,
    super.label,
    this.selectionToTextTransformer,
    this.onSuggestionSelected,
    super.validator,
    this.noItemsFoundBuilder,
    super.enabled = true,
    this.controller,
    this.hintText,
    super.initialValue,
    this.scrollController,
    this.focusNode,
    super.decoration,
    this.valueTransformer,
    this.onClear,
    this.labelText,
    this.onChanged,
  });
  final String Function(T suggestion)? selectionToTextTransformer;
  final FutureOr<List<T>> Function(String search) suggestionsCallback;
  final void Function(T suggestion)? onSuggestionSelected;
  final Widget Function(BuildContext context, T suggestion) itemBuilder;
  final Widget Function(BuildContext context)? noItemsFoundBuilder;
  final TextEditingController? controller;
  final ScrollController? scrollController;
  final String? hintText;
  final FocusNode? focusNode;
  final dynamic Function(T?)? valueTransformer;
  final VoidCallback? onClear;
  final String? labelText;
  final void Function(T?)? onChanged;
  @override
  State<AppTypeAheadForm<T>> createState() => _AppTypeAheadFormState();
}

class _AppTypeAheadFormState<T> extends State<AppTypeAheadForm<T>> {
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
      Stack(
        alignment: Alignment.centerRight,
        children: [
          FormBuilderTypeAhead<T>(
            key: key,
            decoration: widget.decoration ??
                AppTheme.largeScreenInputDecoration.copyWith(
                  labelText: widget.labelText,
                ),
            controller: widget.controller,
            validator: widget.validator,
            enabled: widget.enabled && key.currentState?.value == null,
            name: widget.name,
            initialValue: widget.initialValue,
            valueTransformer: widget.valueTransformer,
            focusNode: widget.focusNode,
            selectionToTextTransformer: widget.selectionToTextTransformer,
            suggestionsCallback: widget.suggestionsCallback,
            itemBuilder: widget.itemBuilder,
            onChanged: widget.onChanged,
            onSuggestionSelected: (suggestion) {
              widget.onSuggestionSelected?.call(suggestion);
              setState(() {
                key.currentState?.didChange(suggestion);
              });
            },
            noItemsFoundBuilder: widget.noItemsFoundBuilder,
            scrollController: widget.scrollController,
          ),
          if (key.currentState?.value != null && widget.enabled)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                widget.onClear?.call();
                setState(() {
                  key.currentState?.didChange(null);
                });
              },
            ),
        ],
      ),
    );
  }
}
