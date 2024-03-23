import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/new/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class CustomDatePickerTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String labelTitle;
  final String? errorMessage;
  final void Function() onTap;

  const CustomDatePickerTextFieldWidget({
    Key? key,
    required this.controller,
    required this.labelTitle,
    required this.onTap,
    this.errorMessage,
  }) : super(key: key);

  @override
  State<CustomDatePickerTextFieldWidget> createState() =>
      _CustomDatePickerTextFieldWidgetState();
}

class _CustomDatePickerTextFieldWidgetState
    extends State<CustomDatePickerTextFieldWidget> {
  final FocusNode _focus = FocusNode();
  bool _textFieldHasFocus = false;

  @override
  void initState() {
    _focus.addListener(() {
      setState(() {
        _textFieldHasFocus = _focus.hasFocus;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.errorMessage == null ? 50 : 70,
      child: TextField(
        onTap: widget.onTap,
        readOnly: true,
        focusNode: _focus,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        controller: widget.controller,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontWeight: Constants.fontWeightRegular,
            color: ColorSchemes.black,
            letterSpacing: -0.13),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorSchemes.border),
              borderRadius: BorderRadius.circular(8)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorSchemes.border),
              borderRadius: BorderRadius.circular(8)),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorSchemes.redError),
              borderRadius: BorderRadius.circular(8)),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorSchemes.border),
              borderRadius: BorderRadius.circular(8)),
          labelText: widget.labelTitle,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelStyle: _labelStyle(context, _textFieldHasFocus),
          errorMaxLines: 2,
          errorText: widget.errorMessage,
          suffixIcon: SvgPicture.asset(
            ImagePaths.timeWork1,
            fit: BoxFit.scaleDown,
            matchTextDirection: true,
          ),
        ),
      ),
    );
  }

  TextStyle _labelStyle(BuildContext context, bool hasFocus) {
    if (hasFocus || widget.controller.text.isNotEmpty) {
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
  void deactivate() {
    _focus.dispose();
    super.deactivate();
  }
}
