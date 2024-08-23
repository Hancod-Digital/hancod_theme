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
    this.decoration,
    this.onFieldSubmitted,
  });

  final void Function(String?)? onChanged;
  final bool required;
  final String? Function(PhoneNumber?)? mobileValidator;
  final void Function(String value)? onFieldSubmitted;
  final InputDecoration? decoration;

  @override
  State<AppPhoneNumberForm> createState() => _AppPhoneNumberFormState();
}

class _AppPhoneNumberFormState extends State<AppPhoneNumberForm> {
  @override
  Widget build(BuildContext context) {
    return widget.buildContainer(
      context,
      FormBuilderField<String>(
        // ignore: avoid_redundant_argument_values
        enabled: true,
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
            decoration: widget.decoration ??
                _mobileInputDecoration.copyWith(labelText: widget.label),
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
              showIsoCode: true,
              flagSize: 16,
            ),
          );
        },
      ),
    );
  }
}

// const _mobileInputDecoration = InputDecoration(
//   alignLabelWithHint: true,
//   floatingLabelAlignment: FloatingLabelAlignment.start,
//   border: OutlineInputBorder(
//     borderRadius: BorderRadius.all(Radius.circular(8)),
//     borderSide: BorderSide(color: AppColors.textfieldOutline),
//   ),
//   enabledBorder: OutlineInputBorder(
//     borderRadius: BorderRadius.all(Radius.circular(8)),
//     borderSide: BorderSide(color: AppColors.textfieldOutline),
//   ),
//   focusedBorder: OutlineInputBorder(
//     borderRadius: BorderRadius.all(Radius.circular(8)),
//     borderSide: BorderSide(color: AppColors.primaryColor, width: 2.0),
//   ),
//   labelStyle: TextStyle(
//     color: AppColors.lightGrey,
//     // fontSize: 15.0,
//   ),
//   hintText: 'Enter your phone number',
//   hintStyle: TextStyle(
//     color: AppColors.lightGrey,
//     fontSize: 14.0,
//   ),
//   // floatingLabelBehavior: FloatingLabelBehavior.always,
// );
const _mobileInputDecoration = InputDecoration(
  alignLabelWithHint: true,
  floatingLabelAlignment: FloatingLabelAlignment.start,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    // ignore: avoid_redundant_argument_values
    borderSide: BorderSide(color: AppColors.textfieldOutline),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    // ignore: avoid_redundant_argument_values
    borderSide: BorderSide(color: AppColors.textfieldOutline),
  ),
  filled: true,
  fillColor: Colors.white,
);
