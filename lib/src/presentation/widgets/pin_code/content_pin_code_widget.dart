import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_button_internet_widget.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../generated/l10n.dart';
import 'pin_code_text_field_widget.dart';

class ContentPinCodeWidget extends StatelessWidget {
  final List<TextEditingController> controllers;
  final void Function(String) onOtpChange;
  final void Function(String) onTapSubmit;
  final bool error;
  final String errorMessage;

  const ContentPinCodeWidget({
    super.key,
    required this.controllers,
    required this.onOtpChange,
    required this.error,
    required this.onTapSubmit,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SvgPicture.asset(ImagePaths.lock),
          const SizedBox(height: 16.0),
          Text(
            "enterPinCode",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: ColorSchemes.black,
                ),
          ),
          const SizedBox(height: 25.0),
          Directionality(
            textDirection: TextDirection.ltr,
            child: CustomOtpFieldWidget(
              controllers: controllers,
              onOtpChange: onOtpChange,
              error: error,
              errorMessage: errorMessage,
            ),
          ),
          const SizedBox(height: 32.0),
          CustomButtonInternetWidget(
            controllers: controllers,
            onTap: () {
              onTapSubmit(controllers.map((e) => e.text).toList().join(''));
            },
            text: "submit",
          )
        ],
      ),
    );
  }
}
