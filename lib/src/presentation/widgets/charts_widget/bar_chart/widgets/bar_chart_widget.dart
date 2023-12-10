// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChartWidget extends StatelessWidget {
  final List<BarChart> data;
  final double height;
  double width;
  final double minimum;
  final double maximum;
  final double interval;
  final int labelRotation;
  final int maximumLabels;

  BarChartWidget({
    Key? key,
    required this.data,
    required this.height,
    this.width = 0.4,
    required this.minimum,
    required this.maximum,
    required this.interval,
    required this.labelRotation,
    required this.maximumLabels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: SfCartesianChart(
        tooltipBehavior: TooltipBehavior(
          enable: true,
          tooltipPosition: TooltipPosition.auto,
          builder: (
            dataa,
            dynamic point,
            dynamic series,
            int pointIndex,
            int seriesIndex,
          ) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(width: 1, color: Colors.white)),
              child: Text(
                '${data[seriesIndex].data[pointIndex].y}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
        ),
        primaryXAxis: CategoryAxis(
          labelRotation: labelRotation,
          maximumLabels: maximumLabels,
          majorGridLines: const MajorGridLines(width: 0),
          axisLine: const AxisLine(width: 0),
          labelStyle: Theme.of(context)
              .textTheme
              .caption
              ?.copyWith(letterSpacing: -0.24),
        ),
        primaryYAxis: NumericAxis(
          minimum: minimum,
          maximum: maximum,
          interval: interval,
          labelStyle: Theme.of(context)
              .textTheme
              .caption
              ?.copyWith(letterSpacing: -0.22, fontSize: 11),
          majorGridLines: const MajorGridLines(width: 0),
          axisLine: const AxisLine(width: 0),
        ),
        series: data
            .map(
              (element) => ColumnSeries<BarData, String>(
                width: width,
                dataSource: element.data,
                xValueMapper: (BarData data, _) => data.x,
                yValueMapper: (BarData data, _) => data.y,
                color: element.color,
              ),
            )
            .toList(),
      ),
    );
  }
}

class BarChart {
  final List<BarData> data;
  final Color color;

  BarChart(this.data, this.color);
}

class BarData {
  final String x;
  final double y;

  BarData(
    this.x,
    this.y,
  );
}
