// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/new/constants.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/button/custom_button_internet_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/button/skip_button.dart';
import 'package:flutter_svg/svg.dart';

class CustomUpdateDialogWidget extends StatelessWidget {
  final bool isMandatory;
  final void Function() onTapUpdate;
  final void Function() onTapSkip;

  const CustomUpdateDialogWidget({
    super.key,
    required this.isMandatory,
    required this.onTapUpdate,
    required this.onTapSkip,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        child: Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.fromSTEB(40, 24, 40, 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ColorSchemes.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            ImagePaths.imagesIcUpdateProfile,
            width: 72,
            height: 72,
            matchTextDirection: true,
            color: const Color.fromRGBO(220, 48, 39, 1),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "oops!",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color.fromRGBO(220, 48, 39, 1),
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(
            height: 15,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "YourApplicationNeedToBeUpdated",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorSchemes.black,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                TextSpan(
                  text: "updateNow",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorSchemes.black,
                        fontWeight: FontWeight.w500,
                      ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          isMandatory
              ? CustomButtonInternetWidget(
                  onTap: onTapUpdate,
                  text: "update",
                  height: 44,
                  width: 295,
                  customTextStyle:
                      Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: ColorSchemes.white,
                            fontWeight: Constants.fontWeightMedium,
                          ),
                  backgroundColor: ColorSchemes.primary,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: SkipButtonWidget(
                        onTap: onTapSkip,
                        buttonTitle: "skip",
                        width: 136,
                        borderColor: ColorSchemes.primary,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: CustomButtonInternetWidget(
                        onTap: onTapUpdate,
                        text: "update",
                        backgroundColor: ColorSchemes.primary,
                        width: 136,
                        height: 44,
                      ),
                    )
                  ],
                ),
        ],
      ),
    ));
  }
}
