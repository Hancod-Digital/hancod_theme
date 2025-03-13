part of '../forms.dart';

class AppPhoneNumberForm extends AppForm<String> {
  const AppPhoneNumberForm({
    required super.name,
    super.key,
    super.validator,
    this.mobileValidator,
    super.label,
    PhoneNumber? super.initialValue,
    super.fieldKey,
    this.onChanged,
    this.required = false,
    this.decoration = const InputDecoration(),
    this.onFieldSubmitted,
    super.enabled = true,
  });

  final void Function(String?)? onChanged;
  final bool required;
  final String? Function(PhoneNumber?)? mobileValidator;
  final void Function(PhoneNumber value)? onFieldSubmitted;
  final InputDecoration decoration;
  @override
  State<AppPhoneNumberForm> createState() => _AppPhoneNumberFormState();
}

class _AppPhoneNumberFormState extends State<AppPhoneNumberForm> {
  @override
  Widget build(BuildContext context) {
    return widget.buildContainer(
      context,
      FormBuilderField<String>(
        enabled: widget.enabled,
        name: widget.name,
        validator: widget.validator,
        onChanged: widget.onChanged,
        initialValue: (widget.initialValue as PhoneNumber?)?.international,
        builder: (FormFieldState<String> field) {
          return PhoneFormField(
            enabled: widget.enabled,
            initialValue: widget.initialValue as PhoneNumber?,
            validator: widget.mobileValidator,
            decoration: widget.decoration,
            onChanged: (phoneNumber) {
              field.didChange(phoneNumber.international);
            },
            onSubmitted: widget.onFieldSubmitted,
            countrySelectorNavigator: const CountrySelectorNavigator.dialog(
              height: 600,
              width: 500,
            ),
            countryButtonStyle: const CountryButtonStyle(
              showIsoCode: true,
              flagSize: 16,
            ),
          );
        },
      ),
    );
  }
}
