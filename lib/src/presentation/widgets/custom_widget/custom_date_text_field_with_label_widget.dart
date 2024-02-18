import 'dart:io';

import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/android_date_picker.dart';
import 'package:city_eye/src/core/utils/ios_date_picker.dart';
import 'package:city_eye/src/presentation/widgets/custom_text_field_with_suffix_icon_widget.dart';
import 'package:flutter/material.dart';
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
    this.imagePath = ImagePaths.icExpiredDate,
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
