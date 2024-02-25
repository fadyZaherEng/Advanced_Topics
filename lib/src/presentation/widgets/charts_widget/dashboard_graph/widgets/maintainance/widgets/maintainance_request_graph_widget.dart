import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MaintainanceRequestGraphWidget extends StatefulWidget {
  const MaintainanceRequestGraphWidget({super.key});

  @override
  State<MaintainanceRequestGraphWidget> createState() =>
      _MaintainanceRequestGraphWidgetState();
}

class _MaintainanceRequestGraphWidgetState
    extends State<MaintainanceRequestGraphWidget> {
  List<ChartData> chartData = [
    // Bind data source
    ChartData('10 Pending', 20, '20%',
        color: ColorSchemes.gray.withOpacity(0.3)),
    ChartData('10 InProgress', 20, '20%', color: ColorSchemes.yellow),
    ChartData('2 Completed', 40, '40%', color: Colors.green),
    ChartData('10 Canceled', 4, '4%', color: ColorSchemes.black),
    ChartData('6 Hold', 4, '10%', color: ColorSchemes.red),
    ChartData('2 Need Payment', 2, '2%', color: ColorSchemes.primary),
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 324,
        child: SfCircularChart(
          //  annotations: _getAnnotation(),
          margin: const EdgeInsets.all(0),
          series: <CircularSeries>[
            PieSeries<ChartData, double>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.y,
              yValueMapper: (ChartData data, _) => data.y,
              dataLabelMapper: (ChartData data, _) => data.x
                  .split(" ")
                  .asMap()
                  .entries
                  .map((e) => e.key == 0 ? "${e.value}\n" : " ${e.value}")
                  .join(),
              pointColorMapper: (ChartData data, _) => data.color,
              strokeColor: ColorSchemes.white,
              strokeWidth: 2,
              explodeAll: false,
              explode: false,
              radius: '50%',
              enableTooltip: true,
              dataLabelSettings: DataLabelSettings(
                isVisible: true,
                textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorSchemes.black,
                    ),
                showZeroValue: true,
                showCumulativeValues: false,
                labelIntersectAction: LabelIntersectAction.shift,
                labelPosition: ChartDataLabelPosition.outside,
                useSeriesColor: false,
                connectorLineSettings: const ConnectorLineSettings(
                  type: ConnectorType.line,
                  width: 1,
                  length: '25%',
                  color: ColorSchemes.gray,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // _getAnnotation() {
  //   return <CircularChartAnnotation>[
  //     CircularChartAnnotation(
  //       widget: Text(
  //         chartData[1].text,
  //         textAlign: TextAlign.start,
  //         style: const TextStyle(color: ColorSchemes.white),
  //       ),
  //       radius: '10%',
  //       verticalAlignment: ChartAlignment.near,
  //       horizontalAlignment: ChartAlignment.near,
  //     ),
  //     CircularChartAnnotation(
  //       widget: Container(
  //         padding: const EdgeInsetsDirectional.only(end: 5),
  //         child: Text(
  //           chartData[2].text,
  //           textAlign: TextAlign.end,
  //           style: const TextStyle(color: ColorSchemes.white),
  //         ),
  //       ),
  //       // radius: '40%',
  //       verticalAlignment: ChartAlignment.near,
  //       horizontalAlignment: ChartAlignment.far,
  //     ),
  //     CircularChartAnnotation(
  //       widget: Container(
  //         padding: const EdgeInsets.only(bottom: 10),
  //         child: Text(
  //           chartData[0].text,
  //           textAlign: TextAlign.start,
  //           style: const TextStyle(color: ColorSchemes.white),
  //         ),
  //       ),
  //       radius: '20%',
  //       verticalAlignment: ChartAlignment.far,
  //       horizontalAlignment: ChartAlignment.far,
  //     ),
  //     CircularChartAnnotation(
  //       widget: Container(
  //         padding: const EdgeInsetsDirectional.only(start: 15, bottom: 35),
  //         child: Text(
  //           chartData[5].text,
  //           textAlign: TextAlign.start,
  //           style: const TextStyle(color: ColorSchemes.white),
  //         ),
  //       ),
  //       radius: '10%',
  //       verticalAlignment: ChartAlignment.far,
  //       horizontalAlignment: ChartAlignment.far,
  //     ),
  //     CircularChartAnnotation(
  //       widget: Container(
  //         padding: const EdgeInsetsDirectional.only(start: 0, bottom: 25),
  //         child: Text(
  //           chartData[4].text,
  //           textAlign: TextAlign.start,
  //           style: const TextStyle(color: ColorSchemes.white),
  //         ),
  //       ),
  //       radius: '3%',
  //       verticalAlignment: ChartAlignment.far,
  //       horizontalAlignment: ChartAlignment.far,
  //     ),
  //     CircularChartAnnotation(
  //       widget: Container(
  //         padding: const EdgeInsetsDirectional.only(bottom: 15, end: 15),
  //         child: Text(
  //           chartData[3].text,
  //           textAlign: TextAlign.start,
  //           style: const TextStyle(color: ColorSchemes.white),
  //         ),
  //       ),
  //       radius: '5%',
  //       verticalAlignment: ChartAlignment.far,
  //       horizontalAlignment: ChartAlignment.far,
  //     )
  //   ];
  // }
}

class ChartData {
  ChartData(this.x, this.y, this.text, {this.color});

  final String x;
  final double y;
  final String text;
  Color? color;
}
