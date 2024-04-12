import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';

class DontReceiveCodeWidget extends StatelessWidget {
  final Function()? requestAgainAction;
  final String requestAgainText;
  const DontReceiveCodeWidget({
    Key? key,
    required this.requestAgainText,
    required this.requestAgainAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: requestAgainAction,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textAlign: TextAlign.center,
            "Don't receive code?",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: ColorSchemes.black,
                  letterSpacing: -0.24,
                ),
          ),
          Column(
            children: [
              Text(
                textAlign: TextAlign.center,
                requestAgainText,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: ColorSchemes.black,
                      letterSpacing: -0.24,
                    ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 2,
                ),
                height: 1,
                width: 88,
                color: ColorSchemes.primary,
              )
            ],
          )
        ],
      ),
    );
  }
}
