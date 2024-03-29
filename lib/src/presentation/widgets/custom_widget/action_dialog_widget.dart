import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/button/custom_button_internet_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionDialogWidget extends StatelessWidget {
  final String text;
  final String icon;
  final String primaryText;
  final String secondaryText;
  final Function() primaryAction;
  final Function() secondaryAction;

  const ActionDialogWidget(
      {Key? key,
      required this.text,
      required this.icon,
      required this.primaryText,
      required this.secondaryText,
      required this.primaryAction,
      required this.secondaryAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorSchemes.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon),
          const SizedBox(height: 16.2),
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: ColorSchemes.black, letterSpacing: -0.24),
          ),
          const SizedBox(height: 32.0),
          Row(children: [
            Expanded(
              child: CustomButtonInternetWidget(
                borderColor: ColorSchemes.gray,
                height: 44,
                onTap: secondaryAction,
                textColor: ColorSchemes.gray,
                backgroundColor: ColorSchemes.white,
                text: secondaryText,
              ),
            ),
            const SizedBox(
              width: 23,
            ),
            Expanded(
              child: CustomButtonInternetWidget(
                height: 44,
                onTap: primaryAction,
                text: primaryText,
              ),
            ),
          ]),
        ],
      ),
    ));
  }
}
