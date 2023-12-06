import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/utils/constants.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_button_internet_widget.dart';

class CustomTextFieldWithButtonWidget extends StatefulWidget {
  final TextEditingController controller;
  final String labelTitle;
  final String? errorMessage;
  final Function(String) onChange;
  final TextInputType textInputType;
  final double buttonBorderRadius;
  final Function() buttonOnTap;
  final double buttonWidth;
  final double buttonHeight;
  final FontWeight fontWeight;

  const CustomTextFieldWithButtonWidget({
    Key? key,
    required this.controller,
    required this.labelTitle,
    required this.onChange,
    required this.buttonOnTap,
    this.errorMessage,
    this.buttonHeight = 20,
    this.buttonWidth = 70,
    this.textInputType = TextInputType.text,
    this.buttonBorderRadius = 12.0,
    this.fontWeight = Constants.fontWeightSemiBold,
  }) : super(key: key);

  @override
  State<CustomTextFieldWithButtonWidget> createState() =>
      _CustomTextFieldWithButtonWidgetState();
}

class _CustomTextFieldWithButtonWidgetState
    extends State<CustomTextFieldWithButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      keyboardType: widget.textInputType,
      controller: widget.controller,
      onChanged: widget.onChange,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: ColorSchemes.black,
            letterSpacing: -0.13,
          ),
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
          errorText: widget.errorMessage,
          labelText: widget.labelTitle,
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: CustomButtonInternetWidget(
              text: "Send",
              width: widget.buttonWidth,
              height: widget.buttonHeight,
              buttonBorderRadius: widget.buttonBorderRadius,
              onTap: () {
                widget.buttonOnTap();
              },
              fontWeight: widget.fontWeight,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          labelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: widget.errorMessage == null
                    ? ColorSchemes.gray
                    : ColorSchemes.redError,
                letterSpacing: -0.24,
              ),
          errorMaxLines: 2),
    );
  }
}
