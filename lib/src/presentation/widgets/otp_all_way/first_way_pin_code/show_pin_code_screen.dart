import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/utils/show_bottom_sheet.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/otp_all_way/first_way_pin_code/content_pin_code_widget.dart';

class PinCodeFirstWayScreen extends StatefulWidget {
  const PinCodeFirstWayScreen({super.key});

  @override
  State<PinCodeFirstWayScreen> createState() => _PinCodeFirstWayScreenState();
}

class _PinCodeFirstWayScreenState extends State<PinCodeFirstWayScreen> {
  List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () => onPinCodeSubmit(context, controllers),
          child: const Text("PinCodeFirstWayScreen"),
        ),
      ),
    );
  }

  ValueNotifier<String> pinCodeErrorMessage = ValueNotifier('');
  void onPinCodeSubmit(context, controllersPinCode) => showBottomSheetWidget(
        height: 380.0,
        context: context,
        onClosed: () {
          Navigator.pop(context);
          pinCodeErrorMessage.value = "";
          controllers = List.generate(6, (index) => TextEditingController());
          setState(() {});
          print("closed");
        },
        content: ValueListenableBuilder(
          valueListenable: pinCodeErrorMessage,
          builder: (context, value, _) => ContentPinCodeWidget(
            controllers: controllers.toList(),
            onOtpChange: (pinCode) {
              // TODO: implement
              // validation on pin code then set pinCodeErrorMessage to result
              // if (pinCode.length == 6) {
              //_bloc.add(ValidationPinCodeEvent(pinCode: pinCode));
              if (pinCode.length == 6) {
                pinCodeErrorMessage.value = "";
              } else {
                pinCodeErrorMessage.value = "Enter 6 digit pin code";
              }
              print(pinCode);
              setState(() {});
              //}
            },
            errorMessage: value,
            onTapSubmit: (pinCode) {
              // TODO: implement
              // validation on pin code then set pinCodeErrorMessage to result
              //_onPinCodeSubmit(pinCode);
              print(pinCode);
              setState(() {});
            },
            error: value.isEmpty ? false : true,
          ),
        ),
        titleLabel: '',
      ).then(
        (_) {
          // TODO: implement to set pinCodeErrorMessage to empty because bottom sheet closed finally
          pinCodeErrorMessage.value = "";
          setState(() {});
          //_bloc.add(RemoveValuesFromPinCodeTextFieldEvent());
        },
      );
}
