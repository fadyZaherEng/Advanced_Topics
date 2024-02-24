// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/charts_widget/dashboard_graph/widgets/cash_flow/cash_flow_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/charts_widget/dashboard_graph/widgets/maintainance/widgets/custom_tool_tip_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CashFlowGraphWidget extends StatefulWidget {
  final List<ChartData> chartData;

  const CashFlowGraphWidget({
    super.key,
    required this.chartData,
  });

  @override
  State<CashFlowGraphWidget> createState() => _CashFlowGraphWidgetState();
}

class _CashFlowGraphWidgetState extends State<CashFlowGraphWidget> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SizedBox(
        height: 370,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: SizedBox(
                height: 370,
                child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  primaryXAxis: CategoryAxis(
                    isVisible: true,
                    placeLabelsNearAxisLine: true,
                    majorGridLines: const MajorGridLines(width: 0),
                    minorGridLines: const MinorGridLines(width: 0),
                    majorTickLines: const MajorTickLines(width: 0),
                    minorTickLines: const MinorTickLines(width: 0),
                    borderWidth: 0,
                    interactiveTooltip: InteractiveTooltip(
                      enable: _checkIfCashFlowEmpty() ? false : true,
                      color: ColorSchemes.dashboardCardColor,
                      borderColor: ColorSchemes.dashboardCardColor,
                      canShowMarker: _checkIfCashFlowEmpty() ? false : true,
                      textStyle: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: Colors.green),
                    ),
                    labelStyle: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: ColorSchemes.black),
                  ),
                  primaryYAxis: NumericAxis(
                    placeLabelsNearAxisLine: true,
                    labelStyle: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: ColorSchemes.black),
                    minorGridLines: const MinorGridLines(width: 0),
                    majorTickLines: const MajorTickLines(width: 0),
                    minorTickLines: const MinorTickLines(width: 0),
                    interval: 100,
                    isVisible: true,
                    interactiveTooltip: const InteractiveTooltip(
                      enable: false,
                      canShowMarker: false,
                    ),
                  ),
                  // Chart title
                  title: ChartTitle(
                    text: '${"S.current.amount"} (EGP) \n',
                    textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: ColorSchemes.black,
                          fontWeight: FontWeight.w500,
                        ),
                    alignment: ChartAlignment.near,
                  ),
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                    canShowMarker: true,
                    activationMode: ActivationMode.singleTap,
                    shared: true,
                    color: ColorSchemes.dashboardCardColor,
                    tooltipPosition: TooltipPosition.auto,
                    shouldAlwaysShow: true,
                    builder: (dynamic data, dynamic point, dynamic series,
                        int index, int c) {
                      return CustomToolTipWidget(data: data);
                    },
                  ),
                  enableAxisAnimation: true,
                  enableSideBySideSeriesPlacement: false,
                  crosshairBehavior: CrosshairBehavior(
                    enable: _checkIfCashFlowEmpty() ? false : true,
                    shouldAlwaysShow: true,
                    lineType: CrosshairLineType.none,
                    activationMode: ActivationMode.singleTap,
                    lineColor: Colors.green,
                  ),
                  enableMultiSelection: true,
                  trackballBehavior: TrackballBehavior(
                    activationMode: ActivationMode.singleTap,
                    enable: _checkIfCashFlowEmpty() ? false : true,
                    shouldAlwaysShow: true,
                    lineType: TrackballLineType.none,
                    tooltipDisplayMode: TrackballDisplayMode.none,
                    markerSettings: const TrackballMarkerSettings(
                      color: Colors.green,
                      markerVisibility: TrackballVisibilityMode.visible,
                    ),
                  ),
                  series: <CartesianSeries>[
                    LineSeries<ChartData, String>(
                      dataSource: widget.chartData,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      pointColorMapper: (ChartData data, idx) =>
                          _checkIfCashFlowEmpty()
                              ? ColorSchemes.dashboardCardColor
                              : ColorSchemes.black,
                      isVisible: true,
                      enableTooltip: _checkIfCashFlowEmpty() ? false : true,
                      markerSettings: MarkerSettings(
                        isVisible: _checkIfCashFlowEmpty() ? false : true,
                        color: ColorSchemes.primary,
                        shape: DataMarkerType.circle,
                        borderWidth: 0,
                      ),
                      dataLabelSettings: const DataLabelSettings(
                        showZeroValue: false,
                        isVisible: false,
                        showCumulativeValues: false,
                      ),
                      emptyPointSettings: EmptyPointSettings(
                        mode: EmptyPointMode.zero,
                        borderColor: ColorSchemes.dashboardCardColor,
                        color: ColorSchemes.dashboardCardColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Text(
                "${"S.current.days"} \n(Nov)\n 2023",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: ColorSchemes.black,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool _checkIfCashFlowEmpty() {
    bool isEmpty = true;
    for (var element in widget.chartData) {
      if (element.y != 0) {
        isEmpty = false;
      }
    }
    return isEmpty;
  }
}
