import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/extra_fields/custom_date_text_field_with_label_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDropdownTextFieldWithLabelWidget extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final String? errorMessage;
  final GlobalKey globalKey;
  final Function() onTap;

  const CustomDropdownTextFieldWithLabelWidget({
    Key? key,
    required this.errorMessage,
    required this.globalKey,
    required this.title,
    required this.controller,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CustomDropdownTextFieldWithLabelWidget> createState() =>
      _CustomDropdownTextFieldWithLabelWidgetState();
}

class _CustomDropdownTextFieldWithLabelWidgetState
    extends State<CustomDropdownTextFieldWithLabelWidget> {
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
                controller: widget.controller,
                labelTitle: "S.of(context).select",
                errorMessage: widget.errorMessage,
                isReadOnly: true,
                onTap: widget.onTap,
                suffixIcon: SvgPicture.asset(
                  "ImagePaths.arrowDown",
                  fit: BoxFit.scaleDown,
                ),
                onChanged: (String value) {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
