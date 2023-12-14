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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SfCircularChart(
          series: <CircularSeries<ChartData, String>>[
            DoughnutSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              dataLabelMapper: (ChartData data, _) => data.x,
              pointColorMapper: (ChartData data, _) => data.color,
              groupMode: CircularChartGroupMode.point,
              radius: '50%',
              enableTooltip: true,
              //  explodeAll: true,
              explode: true,
              //explodeIndex: 1,
              innerRadius: "60%",
              //pointRenderMode: ,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                textStyle: TextStyle(
                  color: ColorSchemes.black,
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  decoration: TextDecoration.none,
                  letterSpacing: -1,
                  wordSpacing: 0,
                  leadingDistribution: TextLeadingDistribution.proportional,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationColor: ColorSchemes.black,
                ),
                showZeroValue: true,
                showCumulativeValues: false,
                labelIntersectAction: LabelIntersectAction.shift,
                labelPosition: ChartDataLabelPosition.outside,
                useSeriesColor: false,
                connectorLineSettings: ConnectorLineSettings(
                  type: ConnectorType.line,
                  width: 1,
                  length: '20%',
                  color: ColorSchemes.gray,
                ),
              ),
            ),
          ],
          annotations: <CircularChartAnnotation>[
            CircularChartAnnotation(
              widget: Center(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    'Top five \n subscribed \n services',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: ColorSchemes.black,
                          fontSize: 13,
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
      ],
    );
  }
}

class ChartData {
  ChartData({this.x, this.y, this.color});

  Color? color;
  final String? x;
  final num? y;
}
