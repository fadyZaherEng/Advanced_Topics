import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/utils/new_utils/constants.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

// ignore: must_be_immutable
class CustomMobileNumberWidget extends StatefulWidget {
  final TextEditingController controller;
  final String labelTitle;
  final String? errorMessage;
  final double? height;
  final String languageCode;
  final void Function(String phoneNumber, String isoCode) onChange;
  final Function()? onSubmitted;
  final TextInputType textInputType;
  final TextAlignVertical? textAlignVertical;
  final List<TextInputFormatter>? inputFormatters;
  final bool isReadOnly;
  final Color textColor;
  final String initialValue;
  final String countryCode;

  const CustomMobileNumberWidget({
    Key? key,
    required this.controller,
    required this.labelTitle,
    required this.onChange,
    this.languageCode = "en",
    this.errorMessage,
    this.height = 1,
    this.textInputType = TextInputType.text,
    this.textAlignVertical,
    this.inputFormatters,
    this.isReadOnly = false,
    this.textColor = ColorSchemes.black,
    this.onSubmitted,
    this.initialValue = "",
    this.countryCode = "EG",
  }) : super(key: key);

  @override
  State<CustomMobileNumberWidget> createState() =>
      _CustomMobileNumberWidgetState();
}

class _CustomMobileNumberWidgetState extends State<CustomMobileNumberWidget> {
  final FocusNode _focus = FocusNode();
  bool _textFieldHasFocus = false;

  String countryDialKey = "+20";
  String currentCountryCode = "EG";
  bool isValueChanged = false;

  String phoneNumber = "";

  @override
  void initState() {
    phoneNumber = widget.initialValue;
    currentCountryCode = widget.countryCode;
    _focus.addListener(() {
      setState(() {
        _textFieldHasFocus = _focus.hasFocus;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: IntlPhoneField(
        initialValue: widget.initialValue,
        dropdownTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: Constants.fontWeightRegular,
            height: widget.height,
            color: ColorSchemes.primary,
            letterSpacing: -0.13),
        flagsButtonPadding: const EdgeInsets.only(bottom: 2),
        focusNode: _focus,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          FilteringTextInputFormatter.allow(RegExp(r'^(?!0)\d*$')),
        ],
        onChanged: (phone) {
          isValueChanged = true;
          countryDialKey = phone.countryCode;
          phoneNumber = phone.number;
          widget.onChange(phone.completeNumber, phone.countryISOCode);
        },
        onCountryChanged: (value) {
          countryDialKey = "+${value.dialCode}";
          if (!isValueChanged) {
            var myPhoneNumber = currentCountryCode != value.code
                ? "12554$phoneNumber"
                : phoneNumber;
            widget.onChange(myPhoneNumber, value.code);
          } else {
            widget.onChange("$countryDialKey$phoneNumber", value.code);
          }
        },
        languageCode: widget.languageCode,
        keyboardType: TextInputType.phone,
        // ignore: deprecated_member_use
        searchText: "search",
        autovalidateMode: AutovalidateMode.disabled,
        disableLengthCheck: true,
        dropdownIcon: const Icon(
          Icons.arrow_drop_down_rounded,
          color: ColorSchemes.primary,
        ),
        pickerDialogStyle: PickerDialogStyle(
          countryCodeStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: Constants.fontWeightRegular,
              height: widget.height,
              color: widget.textColor,
              letterSpacing: -0.13),
          searchFieldPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          countryNameStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: Constants.fontWeightRegular,
              height: widget.height,
              color: widget.textColor,
              letterSpacing: -0.13),
          listTileDivider: Container(
            height: 1,
            color: ColorSchemes.border,
          ),
        ),
        initialCountryCode: widget.countryCode,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: Constants.fontWeightRegular,
            height: widget.height,
            color: widget.textColor,
            letterSpacing: -0.13),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorSchemes.border),
              borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorSchemes.border),
              borderRadius: BorderRadius.circular(12)),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorSchemes.redError),
              borderRadius: BorderRadius.circular(12)),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorSchemes.border),
              borderRadius: BorderRadius.circular(12)),
          errorText: /*isValueChanged*/
              // ? (widget.controller.text.length > countryDialKey.length)
              /*?*/ widget.errorMessage
          // : S.current.thisFieldIsRequired
          /*: null,*/,
          labelText: widget.labelTitle,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
          labelStyle: _labelStyle(context, _textFieldHasFocus),
          errorMaxLines: 2,
          hintStyle: TextStyle(
            color: ColorSchemes.gray,
            fontWeight: Constants.fontWeightRegular,
            height: widget.height,
            letterSpacing: -0.13,
          ),
        ),
      ),
    );
  }

  TextStyle _labelStyle(BuildContext context, bool hasFocus) {
    if (hasFocus || widget.controller.text.length > countryDialKey.length) {
      return Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: Constants.fontWeightRegular,
            color: widget.errorMessage == null
                ? ColorSchemes.gray
                : ColorSchemes.redError,
            letterSpacing: -0.13,
          );
    } else {
      return Theme.of(context).textTheme.titleSmall!.copyWith(
            fontWeight: Constants.fontWeightRegular,
            color: widget.errorMessage == null
                ? ColorSchemes.gray
                : ColorSchemes.redError,
            letterSpacing: -0.13,
          );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
