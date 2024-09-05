part of '../forms.dart';

class AppPhoneNumberForm extends AppForm<String> {
  const AppPhoneNumberForm({
    required super.name,
    super.key,
    super.validator,
    this.mobileValidator,
    super.label,
    super.initialValue,
    super.fieldKey,
    this.onChanged,
    this.required = false,
    super.decoration,
    this.onFieldSubmitted,
  });

  final void Function(String?)? onChanged;
  final bool required;
  final String? Function(PhoneNumber?)? mobileValidator;
  final void Function(String value)? onFieldSubmitted;

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
        initialValue: widget.initialValue,
        builder: (FormFieldState<String> field) {
          return PhoneFormField(
            initialValue: widget.initialValue == null
                ? null
                : PhoneNumber.parse(widget.initialValue!),
            validator: widget.mobileValidator,
            decoration: widget.decoration??AppTheme.largeScreenInputDecoration,
            onChanged: (phoneNumber) {
              field.didChange(phoneNumber.international);
            },
            onSubmitted: widget.onFieldSubmitted,
            countrySelectorNavigator: const CountrySelectorNavigator.dialog(
              height: 600,
              width: 500,
            ),
            isCountryButtonPersistent: true,
            countryButtonStyle: const CountryButtonStyle(
              flagSize: 16,
              showFlag: false,
            ),
          );
        },
      ),
    );
  }
}
