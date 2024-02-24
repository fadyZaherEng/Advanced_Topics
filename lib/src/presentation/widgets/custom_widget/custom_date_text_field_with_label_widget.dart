import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/android_date_picker.dart';
import 'package:flutter_advanced_topics/src/core/utils/constants.dart';
import 'package:flutter_advanced_topics/src/core/utils/ios_date_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDateTextFieldWithLabelWidget extends StatefulWidget {
  final void Function(String value) pickDate;
  final Function() deleteDate;
  final String title;
  final GlobalKey globalKey;
  final String? errorMassage;
  final String label;
  final String imagePath;
  const CustomDateTextFieldWithLabelWidget({
    Key? key,
    required this.pickDate,
    required this.deleteDate,
    required this.title,
    required this.globalKey,
    this.errorMassage,
    this.imagePath = ImagePaths.icOldDate,
    this.label = '',
  }) : super(key: key);

  @override
  State<CustomDateTextFieldWithLabelWidget> createState() =>
      _CustomDateTextFieldWithLabelWidgetState();
}

class _CustomDateTextFieldWithLabelWidgetState
    extends State<CustomDateTextFieldWithLabelWidget> {
  DateTime? selectedDate;
  DateTime? dateSelected;

  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: widget.globalKey,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: ColorSchemes.black),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              child: CustomTextFieldWithSuffixIconWidget(
                controller: controller,
                labelTitle: widget.label,
                onTap: () {
                  selectDate();
                },
                suffixIcon: controller.text == ""
                    ? SvgPicture.asset(
                        widget.imagePath,
                        fit: BoxFit.scaleDown,
                        matchTextDirection: true,
                      )
                    : InkWell(
                        onTap: () {
                          widget.deleteDate();
                          selectedDate = DateTime.now();
                          controller.text = "";
                          setState(() {});
                        },
                        child: SvgPicture.asset(
                          ImagePaths.close,
                          fit: BoxFit.scaleDown,
                          matchTextDirection: true,
                        ),
                      ),
                isReadOnly: true,
                errorMessage: widget.errorMassage,
                onChanged: (String value) {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  void selectDate() {
    if (Platform.isAndroid) {
      androidDatePicker(
        context: context,
        onSelectDate: (date) {
          if (date == null) return;
          controller.text = date.toString().split(" ")[0];
          widget.pickDate(controller.text);
          selectedDate = date;
          setState(() {});
        },
        selectedDate: selectedDate,
      );
    } else {
      iosDatePicker(
        context: context,
        textEditingController: controller,
        selectedDate: selectedDate,
        onChange: (date) {
          dateSelected = date;
        },
        onCancel: () {
          Navigator.of(context).pop();
        },
        onDone: () {
          if (selectedDate != null) {
            selectedDate = dateSelected;
          } else {
            selectedDate = DateTime.now();
            dateSelected = selectedDate;
          }
          Navigator.of(context).pop();
          controller.text = selectedDate.toString().split(" ")[0];
          widget.pickDate(controller.text);
        },
      );
    }
  }
}

class CustomTextFieldWithSuffixIconWidget extends StatefulWidget {
  final TextEditingController controller;
  final String labelTitle;
  final String? errorMessage;
  final TextInputType textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final Function() onTap;
  final void Function(String value) onChanged;
  final Widget suffixIcon;
  final bool isReadOnly;

  const CustomTextFieldWithSuffixIconWidget({
    Key? key,
    required this.controller,
    required this.labelTitle,
    this.errorMessage,
    this.textInputType = TextInputType.text,
    this.inputFormatters,
    required this.onTap,
    required this.suffixIcon,
    this.isReadOnly = false,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CustomTextFieldWithSuffixIconWidget> createState() =>
      _CustomTextFieldWithSuffixIconWidgetState();
}

class _CustomTextFieldWithSuffixIconWidgetState
    extends State<CustomTextFieldWithSuffixIconWidget> {
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
    return TextField(
      focusNode: _focus,
      onTap: widget.onTap,
      readOnly: widget.isReadOnly,
      keyboardType: widget.textInputType,
      controller: widget.controller,
      inputFormatters: widget.inputFormatters,
      onChanged: (value) => widget.onChanged(value),
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
          fontWeight: Constants.fontWeightRegular,
          color: ColorSchemes.black,
          letterSpacing: -0.13),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorSchemes.border),
            borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorSchemes.border),
            borderRadius: BorderRadius.circular(10)),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorSchemes.redError),
            borderRadius: BorderRadius.circular(10)),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorSchemes.border),
            borderRadius: BorderRadius.circular(10)),
        errorText: widget.errorMessage,
        labelText: widget.labelTitle,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: _labelStyle(context, _textFieldHasFocus),
        errorMaxLines: 2,
        suffixIcon: widget.suffixIcon,
      ),
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
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
  void dispose() {
    _focus.dispose();
    super.dispose();
  }
}
