import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/charts_widget/bar_chart/widgets/bar_color_item_widget.dart';

class BarColorWidget extends StatelessWidget {
  final List<BarColorModel> barColors;

  const BarColorWidget({
    Key? key,
    required this.barColors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Wrap(
          runSpacing: 8,
          spacing: 16,
          children: barColors.map((barColor) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                BarColorItemWidget(barColor: barColor),
              ],
            );
          }).toList()),
    );
  }
}

class BarColorModel {
  final String title;
  final Color color;

  BarColorModel({
    required this.title,
    required this.color,
  });
}
