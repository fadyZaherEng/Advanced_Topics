import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ServiceSubscriptionGraphWidget extends StatefulWidget {
  const ServiceSubscriptionGraphWidget({super.key});

  @override
  State<ServiceSubscriptionGraphWidget> createState() =>
      _ServiceSubscriptionGraphWidgetState();
}

class _ServiceSubscriptionGraphWidgetState
    extends State<ServiceSubscriptionGraphWidget> {
  final List<ChartData> chartData = <ChartData>[
    ChartData(x: 'Service Name 1', y: 15, color: ColorSchemes.primary),
    ChartData(x: 'Service Name 2', y: 25, color: Colors.green),
    ChartData(x: 'Service Name 3', y: 15, color: ColorSchemes.yellow),
    ChartData(x: 'Service Name 4', y: 10, color: ColorSchemes.gray),
    ChartData(x: 'Service Name 4', y: 35, color: ColorSchemes.black),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 318,
      child: Center(
        child: SfCircularChart(
          series: <CircularSeries<ChartData, String>>[
            DoughnutSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              dataLabelMapper: (ChartData data, _) => data.x.toString()
                  .split(" ")
                  .asMap()
                  .entries
                  .map((e) => e.key == 0 ? "${e.value}\n" : " ${e.value}")
                  .join(),
              pointColorMapper: (ChartData data, _) => data.color,
              groupMode: CircularChartGroupMode.point,
              radius: '57%',
              enableTooltip: true,
              groupTo: chartData.length.toDouble(),
              //  explodeAll: true,
              explode: true,
              //explodeIndex: 1,
              innerRadius: "67%",
              dataLabelSettings: DataLabelSettings(
                isVisible: true,
                textStyle: ThemeData().textTheme.bodyMedium?.copyWith(
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
          annotations: <CircularChartAnnotation>[
            CircularChartAnnotation(
              widget: Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "S.current.topFiveSubscribedServices",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorSchemes.black,
                    ),
                  ),
                ),
              ),
            )
          ],
          enableMultiSelection: true,
          tooltipBehavior: TooltipBehavior(
            shouldAlwaysShow: true,
            tooltipPosition: TooltipPosition.auto,
            activationMode: ActivationMode.singleTap,
            canShowMarker: true,
            shared: true,
          ),
          selectionGesture: ActivationMode.singleTap,
        ),
      ),
    );
  }

}

class ChartData {
  ChartData({this.x, this.y, this.color});

  Color? color;
  final String? x;
  final num? y;
}
