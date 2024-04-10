import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/utils/get_mobile_validation_error_message.dart';
import 'package:city_eye/src/di/injector.dart';
import 'package:city_eye/src/domain/usecase/get_current_country_code_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_language_use_case.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_mobile_number_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  String _regionCode = "";

  @override
  void initState() {
    _regionCode = GetCurrentCountryCodeUseCase(injector())();
    super.initState();
  }

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
          labelTitle: S.of(context).newMobileNumber,
          onChange: (phoneNumber, code) {
            _phoneNumberController.text = phoneNumber;
            _checkPhoneNumberValidation(phoneNumber, code);
            setState(() {});
          },
          countryCode: GetCurrentCountryCodeUseCase(injector())(),
          errorMessage: phoneNumberErrorMessage,
          languageCode: GetLanguageUseCase(injector())(),
        ),
        SizedBox(height: phoneNumberErrorMessage == null ? 32 : 16),
        CustomButtonWidget(
          width: double.infinity,
          text: S.of(context).save,
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
          backgroundColor: F.isNiceTouch
              ? ColorSchemes.ghadeerDarkBlue
              : ColorSchemes.primary,
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
        isValidMobileNumber! &&
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
}
