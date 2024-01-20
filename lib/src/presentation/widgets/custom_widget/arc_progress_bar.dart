import 'package:arc_progress_bar_new/arc_progress_bar_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/utils/constants.dart';

class VacationBalancePieChartWidget extends StatelessWidget {
  final bool isEnglish;

  const VacationBalancePieChartWidget({
    super.key,
    required this.isEnglish,
  });

  @override
  Widget build(BuildContext context) {
    return ArcProgressBar(
      //or do it like this from syncfusion_flutter_charts package
      // https://pub.dev/packages/syncfusion_flutter_charts
      animationDuration: const Duration(seconds: 2),
      percentage: 20, //remainingBalance.percentage,
      arcThickness: 10,
      handleColor: ColorSchemes.redError,
      backgroundColor: ColorSchemes.border,
      animateFromLastPercent: true,
      foregroundColor: ColorSchemes.redError,
      innerPadding: 10,
      handleSize: "remainingBalance.days" != '0' ? 8 : 0,
      strokeCap: StrokeCap.round,
      centerWidget: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Text(
              "remainingBalance.title",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: ColorSchemes.redError,
                  fontWeight: Constants.fontWeightSemiBold),
            ),
            SizedBox(height: isEnglish ? 3 : 15),
            Text(
              "${"remainingBalance.days"} ${"Days"}",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: ColorSchemes.black,
                  fontWeight: Constants.fontWeightBold),
            ),
          ],
        ),
      ),
    );
  }
}
