import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/new_utils/android_time_picker.dart';
import 'package:flutter_advanced_topics/src/core/utils/new_utils/ios_time_picker.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/extra_fields/custom_date_text_field_with_label_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTimeTextFieldWithLabelWidget extends StatefulWidget {
  final void Function(String value) pickTime;
  final Function() deleteTime;
  final String title;
  final GlobalKey globalKey;
  final String? errorMessage;
  final String label;
  final bool valueComingFromApi;
  final String value;

  const CustomTimeTextFieldWithLabelWidget({
    Key? key,
    required this.pickTime,
    required this.deleteTime,
    required this.title,
    required this.globalKey,
    this.errorMessage,
    this.label = '',
    this.valueComingFromApi = false,
    this.value = '',
  }) : super(key: key);

  @override
  State<CustomTimeTextFieldWithLabelWidget> createState() =>
      _CustomTimeTextFieldWithLabelWidgetState();
}

class _CustomTimeTextFieldWithLabelWidgetState
    extends State<CustomTimeTextFieldWithLabelWidget> {
  TimeOfDay? selectedTime;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    widget.value.isNotEmpty ? controller.text = widget.value : null;
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
            const SizedBox(height: 16.0),
            SizedBox(
              child: CustomTextFieldWithSuffixIconWidget(
                controller: controller,
                labelTitle: widget.label,
                onTap: () {
                  widget.valueComingFromApi ? () {} : selectTime();
                },
                suffixIcon: selectedTime == null || controller.text == ""
                    ? SvgPicture.asset(
                        "ImagePaths.time",
                        fit: BoxFit.scaleDown,
                        matchTextDirection: true,
                      )
                    : InkWell(
                        onTap: () {
                          widget.deleteTime();
                          selectedTime = null;
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
                errorMessage: widget.errorMessage,
                onChanged: (String value) {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  void selectTime() {
    if (Platform.isAndroid) {
      androidTimePicker(
        context: context,
        selectedTime: selectedTime,
        onSelectTime: (time) {
          if (time == null) return;
          controller.text = time.format(context);
          widget.pickTime(controller.text);
          selectedTime = time;
          setState(() {});
        },
      );
    } else {
      iosTimePicker(
        context: context,
        selectedTime: selectedTime,
        onChange: (time) {
          selectedTime = time;
        },
        onCancel: () {},
        onDone: () {
          Navigator.of(context).pop();
          controller.text = selectedTime?.format(context) ?? '';
          widget.pickTime(controller.text);
        },
      );
    }
  }
}
