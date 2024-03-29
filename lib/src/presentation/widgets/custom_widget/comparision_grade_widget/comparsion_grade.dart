import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ComparisionGradeWidget extends StatelessWidget {
  const ComparisionGradeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comparision"),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 4),
            for (int i = 0; i < 3; i++)
              LinearPercentIndicator(
                padding: const EdgeInsets.all(0),
                percent: (ElementCount.countAnswer / 100) > 1.0
                    ? 1.0
                    : (ElementCount.countAnswer / 100),
                backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
                progressColor: ColorSchemes.primary,
                animation: true,
                lineHeight: 8,
                barRadius: const Radius.circular(12),
                isRTL: Directionality.of(context) == TextDirection.rtl
                    ? true
                    : false,
              ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class ElementCount {
  static const int countAnswer = 30;
}
