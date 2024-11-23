part of '../forms.dart';

class AppForm<T> extends StatefulWidget {
  const AppForm({
    required this.name,
    super.key,
    this.label,
    this.fieldKey,
    this.initialValue,
    this.validator,
    this.enabled = true,
    this.decoration,
    this.boxShadow,
    this.padding,
  });
  final String name;
  final String? label;
  final T? initialValue;
  final bool enabled;
  final String? Function(T?)? validator;
  final InputDecoration? decoration;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? padding;
  // ignore: strict_raw_type
  final GlobalKey<FormBuilderFieldState>? fieldKey;

  Widget buildContainer(BuildContext context, Widget child) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        boxShadow: boxShadow,
        // border: Border.all(color: AppColors.secondaryColor200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (label != null) ...[
            Text(
              label!,
              style: AppText.text16W700.copyWith(color: AppColors.black),
            ),
            verticalSpaceTiny,
          ],
          child,
        ],
      ),
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
