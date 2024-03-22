import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';

class DontReceiveCodeWidget extends StatelessWidget {
  final Function()? requestAgainAction;

  const DontReceiveCodeWidget({
    Key? key,
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
            "${S.of(context).dontReceiveCode} ",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: ColorSchemes.black,
                  letterSpacing: -0.24,
                ),
          ),
          Column(
            children: [
              Text(
                textAlign: TextAlign.center,
                " ${S.of(context).requestAgain} ",
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
