// ignore_for_file: strict_raw_type
part of '../forms.dart';

/// A typeahead form field that provides autocomplete functionality.
///
/// This widget extends [AppForm] and provides a searchable dropdown with
/// customizable styling and behavior.
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
    super.secondaryLabel,
    T? super.initialValue,
    this.scrollController,
    this.focusNode,
    this.decoration = const InputDecoration(),
    this.valueTransformer,
    this.onClear,
    this.updateValue = true,
  });

  // Callback functions
  final String Function(T suggestion)? selectionToTextTransformer;
  final FutureOr<List<T>> Function(String search) suggestionsCallback;
  final void Function(T suggestion)? onSuggestionSelected;
  final Widget Function(BuildContext context, T suggestion) itemBuilder;
  final Widget Function(BuildContext context)? noItemsFoundBuilder;
  final VoidCallback? onClear;

  // Controllers and nodes
  final TextEditingController? controller;
  final ScrollController? scrollController;
  final FocusNode? focusNode;

  // UI properties
  final String? hintText;
  final InputDecoration decoration;
  final bool updateValue;

  // Value transformation
  final dynamic Function(T?)? valueTransformer;

  @override
  State<AppTypeAheadForm<T>> createState() => _AppTypeAheadFormState<T>();
}

class _AppTypeAheadFormState<T> extends State<AppTypeAheadForm<T>> {
  late final GlobalKey<FormBuilderFieldState> _fieldKey;
  late final TextEditingController _textController;

  // Extract border styling to avoid duplication

  @override
  void initState() {
    super.initState();
    _fieldKey = widget.fieldKey ?? GlobalKey<FormBuilderFieldState>();
    _textController = widget.controller ?? TextEditingController();
    _initializeControllerText();
  }

  void _initializeControllerText() {
    final initialText = _getInitialTextValue();
    if (initialText != null && initialText.isNotEmpty) {
      _textController.text = initialText;
    }
  }

  String? _getInitialTextValue() {
    if (widget.initialValue == null) return null;

    if (widget.initialValue is String) {
      return widget.initialValue as String;
    }

    return widget.selectionToTextTransformer?.call(widget.initialValue as T);
  }

  @override
  Widget build(BuildContext context) {
    return widget.buildContainer(
      context,
      Stack(
        alignment: Alignment.centerRight,
        children: [
          _buildTypeAheadField(),
          _buildClearButton(),
        ],
      ),
    );
  }

  Widget _buildTypeAheadField() {
    return FormBuilderTypeAhead<T>(
      key: _fieldKey,
      decoration: _buildInputDecoration(),
      controller: widget.controller,
      validator: widget.validator,
      enabled: _isFieldEnabled(),
      name: widget.name,
      initialValue: widget.initialValue as T?,
      valueTransformer: widget.valueTransformer,
      focusNode: widget.focusNode,
      selectionToTextTransformer: widget.selectionToTextTransformer,
      suggestionsCallback: widget.suggestionsCallback,
      itemBuilder: widget.itemBuilder,
      hideOnEmpty: true,
      onSelected: _handleSuggestionSelected,
      emptyBuilder: widget.noItemsFoundBuilder,
      scrollController: widget.scrollController,
    );
  }

  InputDecoration _buildInputDecoration() {
    return widget.decoration.copyWith(
      labelText: widget.secondaryLabel,
      labelStyle: const TextStyle(
        color: AppColors.typeAheadLabelColor,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
    );
  }

  bool _isFieldEnabled() {
    return widget.enabled && _fieldKey.currentState?.value == null;
  }

  void _handleSuggestionSelected(T suggestion) {
    widget.onSuggestionSelected?.call(suggestion);

    setState(() {
      if (widget.updateValue) {
        _fieldKey.currentState?.didChange(suggestion);
      } else {
        _fieldKey.currentState?.didChange(null);
      }
    });
  }

  Widget _buildClearButton() {
    final hasValue = _fieldKey.currentState?.value != null;
    final isEnabled = widget.enabled;

    if (!hasValue || !isEnabled) return const SizedBox.shrink();

    return IconButton(
      icon: const Icon(Icons.close),
      onPressed: _handleClear,
    );
  }

  void _handleClear() {
    widget.onClear?.call();
    setState(() {
      _fieldKey.currentState?.didChange(null);
    });
  }
}
