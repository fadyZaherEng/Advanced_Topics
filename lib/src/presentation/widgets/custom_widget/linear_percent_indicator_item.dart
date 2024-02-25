import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:percent_indicator/percent_indicator.dart';

class LinearPercentIndicatorItem extends StatelessWidget {
  final String text;
  final double percent;
  final String number;

  const LinearPercentIndicatorItem({
    Key? key,
    required this.text,
    required this.percent,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(letterSpacing: -0.26),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: LinearPercentIndicator(
            lineHeight: 8,
            percent: percent,
            animation: true,
            backgroundColor: ColorSchemes.linearBarInActive,
            progressColor: ColorSchemes.linearBarActive,
            barRadius: const Radius.circular(8),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          number,
          style: Theme.of(context).textTheme.headline1,
        ),
      ],
    );
  }
}
