part of '../forms.dart';

class AppForm<T> extends StatefulWidget {
  const AppForm({
    required this.name,
    super.key,
    this.label,
    this.secondaryLabel,
    this.fieldKey,
    this.initialValue,
    this.validator,
    this.enabled = true,
    this.autovalidateMode,
  });
  final String name;
  final String? secondaryLabel;
  final String? label;
  final dynamic initialValue;
  final bool enabled;
  final String? Function(T?)? validator;
  final AutovalidateMode? autovalidateMode;
  // ignore: strict_raw_type
  final GlobalKey<FormBuilderFieldState>? fieldKey;

  Widget buildContainer(BuildContext context, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label != null) ...[
          Text(label!),
          const SizedBox(height: 12),
        ],
        child,
      ],
    );
  }

  @override
  State<AppForm<T>> createState() => _AppFormState();
}

class _AppFormState<T> extends State<AppForm<T>> {
  @override
  Widget build(BuildContext context) {
    return widget.buildContainer(context, const SizedBox());
  }
}
