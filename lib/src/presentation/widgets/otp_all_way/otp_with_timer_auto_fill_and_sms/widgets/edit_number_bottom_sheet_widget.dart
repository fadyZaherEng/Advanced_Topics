import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/button/custom_button_internet_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/extra_fields/custom_mobile_number_widget.dart';
import 'package:libphonenumber_plugin/libphonenumber_plugin.dart';

class EditNumberBottomSheetWidget extends StatefulWidget {
  final String phoneNumber;
  final int userId;
  final Function(int, String) onEditPhoneNumber;

  const EditNumberBottomSheetWidget({
    Key? key,
    required this.phoneNumber,
    required this.userId,
    required this.onEditPhoneNumber,
  }) : super(key: key);

  @override
  State<EditNumberBottomSheetWidget> createState() =>
      _EditNumberBottomSheetWidgetState();
}

class _EditNumberBottomSheetWidgetState
    extends State<EditNumberBottomSheetWidget> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String? phoneNumberErrorMessage;
  bool? isValidMobileNumber = false;
  var phoneType = PhoneNumberType.UNKNOWN;
  String _regionCode = "US";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          textAlign: TextAlign.center,
          widget.phoneNumber,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: ColorSchemes.black,
                letterSpacing: -0.24,
              ),
        ),
        const SizedBox(height: 16),
        CustomMobileNumberWidget(
          controller: _phoneNumberController,
          labelTitle: "New phone number",
          onChange: (phoneNumber, code) {
            _phoneNumberController.text = phoneNumber;
            _checkPhoneNumberValidation(phoneNumber, code);
            setState(() {});
          },
          countryCode: "en",
          // GetCurrentCountryCodeUseCase(injector())(),
          errorMessage: phoneNumberErrorMessage,
          languageCode: "us", //" GetLanguageUseCase(injector())(),
        ),
        SizedBox(height: phoneNumberErrorMessage == null ? 32 : 16),
        CustomButtonInternetWidget(
          width: double.infinity,
          text: "save",
          onTap: () {
            if (isValidMobileNumber != null &&
                isValidMobileNumber! &&
                phoneType == PhoneNumberType.MOBILE) {
              widget.onEditPhoneNumber(
                  widget.userId, _phoneNumberController.text.trim().toString());
            } else {
              phoneNumberErrorMessage = getMobileValidationErrorMessage(
                mobileNumber: _phoneNumberController.text.trim().toString(),
                regionCode: _regionCode,
              );
              setState(() {});
            }
          },
          backgroundColor: ColorSchemes.primary,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _checkPhoneNumberValidation(String phoneNumber, String code) async {
    try {
      phoneType = await PhoneNumberUtil.getNumberType(phoneNumber, code);
    } catch (e) {
      phoneType = PhoneNumberType.UNKNOWN;
    }
    isValidMobileNumber =
        await PhoneNumberUtil.isValidPhoneNumber(phoneNumber, code);
    if (isValidMobileNumber != null &&
        isValidMobileNumber == true &&
        phoneType == PhoneNumberType.MOBILE) {
      phoneNumberErrorMessage = null;
    } else {
      phoneNumberErrorMessage = getMobileValidationErrorMessage(
        mobileNumber: phoneNumber,
        regionCode: code,
      );
    }
    setState(() {});
  }

//check for egypt and iq elaraq
  String getMobileValidationErrorMessage({
    required String mobileNumber,
    required String regionCode,
  }) {
    if ((regionCode == "EG" && mobileNumber.length == 3) ||
        (regionCode == "IQ" && mobileNumber.length == 4)) {
      return "Mobile number must not be empty";
    } else if (regionCode == "EG" &&
        (!mobileNumber.startsWith("+2010") &&
            !mobileNumber.startsWith("+2011") &&
            !mobileNumber.startsWith("+2012") &&
            !mobileNumber.startsWith("+2015"))) {
      return "Mobile should start with 2010, 2011, 2012, 2015";
    } else if (regionCode == "EG" && mobileNumber.length >= 4) {
      return "Mobile number must be 10 digits";
    } else if (regionCode == "IQ" && !mobileNumber.startsWith("+9647")) {
      return "Mobile should start with 9647";
    } else if (regionCode == "IQ" && mobileNumber.length >= 5) {
      return "Mobile number must be 11 digits";
    } else {
      return "Invalid mobile number";
    }
  }
}
