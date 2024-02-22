import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talent_link/generated/l10n.dart';
import 'package:talent_link/src/config/theme/color_schemes.dart';
import 'package:talent_link/src/core/resources/image_paths.dart';
import 'package:talent_link/src/presentation/widgets/custom_text_field_with_suffix_icon_widget.dart';

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
                  ?.copyWith(color: ColorSchemes.semiBlack),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              child: CustomTextFieldWithSuffixIconWidget(
                controller: widget.controller,
                labelTitle: S.of(context).select,
                errorMessage: widget.errorMessage,
                isReadOnly: true,
                onTap: widget.onTap,
                suffixIcon: SvgPicture.asset(
                  ImagePaths.arrowDown,
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
