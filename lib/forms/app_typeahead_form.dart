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
    this.decoration = const InputDecoration(),
    this.valueTransformer,
    this.onClear,
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
  @override
  final InputDecoration decoration;

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
          InkWell(
            onTap: () {
              widget.onClear?.call();
              setState(() {
                widget.onClear?.call();
                key.currentState?.didChange(null);
                widget.controller?.clear();
              });
            },
            child: AbsorbPointer(
              absorbing: false,
              child: FormBuilderTypeAhead<T>(
                key: key,
                decoration: widget.decoration,
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
                onSelected: (suggestion) {
                  widget.onSuggestionSelected?.call(suggestion);
                  key.currentState?.didChange(suggestion);
                },
                emptyBuilder: widget.noItemsFoundBuilder,
                scrollController: widget.scrollController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
