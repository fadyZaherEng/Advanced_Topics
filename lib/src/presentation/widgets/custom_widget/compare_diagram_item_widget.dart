import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/domain/entities/home/city_eye/choice.dart';
import 'package:flutter/material.dart';

class CompareDiagramItemWidget extends StatelessWidget {
  final HomeChoice choice;

  const CompareDiagramItemWidget({
    super.key,
    required this.choice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              choice.value,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: ColorSchemes.black),
            ),
            Text(
              "${choice.countAnswer}%",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: ColorSchemes.black),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Container(
              height: 8,
              decoration: const BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(4),
                  bottomStart: Radius.circular(4),
                ),
                color: ColorSchemes.primary,
              ),
              width: getWidthBasedOnPercentage(choice.countAnswer, context),
            ),
            Expanded(
              child: Container(
                height: 8,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(4),
                    bottomEnd: Radius.circular(4),
                  ),
                  color: Color(0xFFF1F1F1),
                ),
                width: getWidthBasedOnPercentage(
                    100 - choice.countAnswer, context),
              ),
            ),
          ],
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  double getWidthBasedOnPercentage(int countAnswer, BuildContext context) =>
      MediaQuery.of(context).size.width * (countAnswer / 100) -
      (countAnswer == 0 ? 0 : 30);
}
