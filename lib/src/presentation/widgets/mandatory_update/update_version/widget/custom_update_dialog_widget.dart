import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/generated/l10n.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/constants.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/button/custom_button_internet_widget.dart';
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
    return PopScope(
      canPop: false,
      child: IntrinsicHeight(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ColorSchemes.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              SvgPicture.asset(
                ImagePaths.icUpdate,
                width: 72,
                height: 72,
                matchTextDirection: true,
                color: const Color.fromRGBO(220, 48, 39, 1),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                "oops",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: const Color.fromRGBO(220, 48, 39, 1),
                      fontWeight: Constants.fontWeightMedium,
                    ),
              ),
              const SizedBox(
                height: 12,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "${S.of(context).YourApplicationNeedToBeUpdated} ",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorSchemes.black,
                            fontSize: 14,
                            fontWeight: Constants.fontWeightRegular,
                          ),
                    ),
                    TextSpan(
                      text: S.of(context).updateNow,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorSchemes.black,
                            fontWeight: Constants.fontWeightMedium,
                          ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              isMandatory
                  ? CustomButtonInternetWidget(
                      onTap: onTapUpdate,
                      text: S.of(context).update,
                      width: double.infinity,
                      height: 44,
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
                          child: _buildSkipButton(
                            context: context,
                            onTap: onTapSkip,
                            height: 44,
                            width: 136,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          child: CustomButtonInternetWidget(
                            onTap: onTapUpdate,
                            text: S.of(context).update,
                            backgroundColor: ColorSchemes.primary,
                            width: 136,
                            height: 44,
                          ),
                        )
                      ],
                    ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkipButton({
    required BuildContext context,
    required Function() onTap,
    required double height,
    required double width,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsetsDirectional.all(12),
        decoration: BoxDecoration(
          color: ColorSchemes.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: ColorSchemes.primary,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            S.of(context).skip,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: ColorSchemes.primary,
                  fontWeight: Constants.fontWeightMedium,
                ),
          ),
        ),
      ),
    );
  }
}
