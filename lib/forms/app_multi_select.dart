import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

/// Field for selecting value(s) from a searchable list
class FormBuilderMultiSelectionSearchableDropdown<T> extends FormBuilderFieldDecoration<List<T>> {
  /// Creates field for selecting value(s) from a searchable list
  FormBuilderMultiSelectionSearchableDropdown({
    required super.name,
    super.key,
    super.autovalidateMode,
    super.enabled,
    super.focusNode,
    super.onSaved,
    super.validator,
    super.decoration,
    super.initialValue,
    super.onChanged,
    super.valueTransformer,
    super.onReset,
    this.autoValidateMode,
    this.compareFn,
    this.dropdownSearchDecoration,
    this.dropdownSearchTextAlign,
    this.dropdownSearchTextAlignVertical,
    this.filterFn,
    // this.isFilteredOnline = false,
    this.itemAsString,
    this.items,
    this.popupOnItemAdded,
    this.popupOnItemRemoved,
    this.popupSelectionWidget,
    this.selectedItems = const [],
    this.popupPropsMultiSelection = const PopupPropsMultiSelection.menu(
      showSearchBox: true,
      fit: FlexFit.loose,
    ),
    this.clearButtonProps,
    this.dropdownSearchTextStyle,
    this.dropdownButtonProps,
    this.dropdownBuilderMultiSelection,
    this.onBeforeChangeMultiSelection,
  })  : assert(
          T == String || compareFn != null,
          'compareFn is required for non-String types',
        ),
        onSavedMultiSelection = null,
        onChangedMultiSelection = null,
        popupValidationMultiSelectionWidget = null,
        popupCustomMultiSelectionWidget = null,
        super(
          builder: (FormFieldState<List<T>?> field) {
            final state = field as FormBuilderMultiSelectionSearchableDropdownState<T>;
            return DropdownSearch<T>.multiSelection(
              // Hack to rebuild when didChange is called

              suffixProps: DropdownSuffixProps(
                clearButtonProps: clearButtonProps ?? const ClearButtonProps(),
                dropdownButtonProps: dropdownButtonProps ?? const DropdownButtonProps(),
              ),
              compareFn: compareFn,
              enabled: state.enabled,
              dropdownBuilder: dropdownBuilderMultiSelection,
              decoratorProps: DropDownDecoratorProps(
                decoration: state.decoration,
                textAlign: dropdownSearchTextAlign,
                textAlignVertical: dropdownSearchTextAlignVertical,
                baseStyle: dropdownSearchTextStyle,
              ),
              filterFn: filterFn,
              items: (filter, loadProps) {
                return items?.call(filter, loadProps) ?? [];
              },
              itemAsString: itemAsString,
              onBeforeChange: onBeforeChangeMultiSelection,
              onChanged: state.didChange,
              popupProps: popupPropsMultiSelection,
              selectedItems: state.value ?? [],
            );
          },
        );

  ///offline items list
  final FutureOr<List<T>> Function(String, LoadProps?)? items;

  ///selected items
  final List<T> selectedItems;

  ///called when a new items are selected
  final ValueChanged<List<T>>? onChangedMultiSelection;

  ///to customize list of items UI in MultiSelection mode
  final DropdownSearchBuilderMultiSelection<T>? dropdownBuilderMultiSelection;

  ///customize the fields the be shown
  final DropdownSearchItemAsString<T>? itemAsString;

  ///	custom filter function
  final DropdownSearchFilterFn<T>? filterFn;

  ///function that compares two object with the same type
  ///to detected if it's the selected item or not
  final DropdownSearchCompareFn<T>? compareFn;

  ///dropdownSearch input decoration
  final InputDecoration? dropdownSearchDecoration;

  /// style on which to base the label
  // final TextStyle? dropdownSearchBaseStyle;

  /// How the text in the decoration should be aligned horizontally.
  final TextAlign? dropdownSearchTextAlign;

  /// How the text should be aligned vertically.
  final TextAlignVertical? dropdownSearchTextAlignVertical;

  final AutovalidateMode? autoValidateMode;

  /// An optional method to call with the final value when the form is saved via
  final FormFieldSetter<List<T>>? onSavedMultiSelection;

  /// callback executed before applying values changes
  final BeforeChangeMultiSelection<T>? onBeforeChangeMultiSelection;

  ///called when a new item added on Multi selection mode
  final OnItemAdded<T>? popupOnItemAdded;

  ///called when a new item added on Multi selection mode
  final OnItemRemoved<T>? popupOnItemRemoved;

  ///widget used to show checked items in multiSelection mode
  final DropdownSearchPopupItemBuilder<T>? popupSelectionWidget;

  ///widget used to validate items in multiSelection mode
  final ValidationMultiSelectionBuilder<T?>? popupValidationMultiSelectionWidget;

  ///widget to add custom widget like addAll/removeAll on popup multi selection mode
  final ValidationMultiSelectionBuilder<T>? popupCustomMultiSelectionWidget;

  final PopupPropsMultiSelection<T> popupPropsMultiSelection;

  ///custom dropdown clear button icon properties
  final ClearButtonProps? clearButtonProps;

  /// style on which to base the label
  final TextStyle? dropdownSearchTextStyle;

  ///custom dropdown icon button properties
  final DropdownButtonProps? dropdownButtonProps;

  @override
  FormBuilderMultiSelectionSearchableDropdownState<T> createState() =>
      FormBuilderMultiSelectionSearchableDropdownState<T>();
}

class FormBuilderMultiSelectionSearchableDropdownState<T>
    extends FormBuilderFieldDecorationState<FormBuilderMultiSelectionSearchableDropdown<T>, List<T>> {}
