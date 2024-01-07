import 'package:flutter/cupertino.dart';
import 'package:flutter_advanced_topics/src/core/utils/show_bottom_sheet.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/pin_code/content_pin_code_widget.dart';

ValueNotifier<String> pinCodeErrorMessage = ValueNotifier('');

void onPinCodeSubmit(context, _controllers) => showBottomSheetWidget(
      height: 380.0,
      context: context,
      content: ValueListenableBuilder(
        builder: (context, value, _) => ContentPinCodeWidget(
          controllers: _controllers.toList(),
          onOtpChange: (pinCode) {
            if (pinCode.length == 4) {
//_bloc.add(ValidationPinCodeEvent(pinCode: pinCode));
            }
          },
          errorMessage: value,
          onTapSubmit: (pinCode) {
//_onPinCodeSubmit(pinCode);
          },
          error: value.isEmpty ? false : true,
        ),
        valueListenable: pinCodeErrorMessage,
      ),
      titleLabel: '',
    ).then(
      (_) {
        pinCodeErrorMessage.value = "";
//_bloc.add(RemoveValuesFromPinCodeTextFieldEvent());
      },
    );
