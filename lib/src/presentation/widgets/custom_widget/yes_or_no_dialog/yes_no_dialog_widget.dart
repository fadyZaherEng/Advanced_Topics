import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/button/button_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class YesNoDialogWidget extends StatelessWidget {
  final String dialogMessage;
  final Function() actionButtonOnTap;
  final Function() cancelButtonOnTap;
  final String actionButtonText;
  final String cancelButtonText;

  const YesNoDialogWidget({
    Key? key,
    required this.dialogMessage,
    required this.actionButtonOnTap,
    required this.cancelButtonOnTap,
    required this.cancelButtonText,
    required this.actionButtonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorSchemes.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            SvgPicture.asset(ImagePaths.doneSuccess),
            const SizedBox(height: 14),
            Expanded(
              child: Text(
                dialogMessage,
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(letterSpacing: -0.32),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ButtonWidget(
                    onTap: cancelButtonOnTap,
                    buttonTitle: cancelButtonText,
                    backgroundColor: ColorSchemes.white,
                    borderColor: ColorSchemes.buttonBorderGray,
                    titleColor: ColorSchemes.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ButtonWidget(
                    onTap: actionButtonOnTap,
                    buttonTitle: actionButtonText,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
