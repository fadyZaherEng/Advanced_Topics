// ignore_for_file: avoid_print

import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 390,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(
              isVisible: true,
              majorGridLines: const MajorGridLines(width: 0),
              interactiveTooltip: InteractiveTooltip(
                enable: true,
                color: ColorSchemes.dashboardCardColor,
                borderColor: ColorSchemes.dashboardCardColor,
                canShowMarker: true,
                textStyle: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: ColorSchemes.gray),
              ),
              title: AxisTitle(
                text: "${"S.current.days"} \n(Nov)\n 2023",
                textStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: const Color(0xFF222222),
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      fontFamily: "Montserrat",
                    ),
                alignment: ChartAlignment.far,
              ),
            ),
            primaryYAxis: NumericAxis(
              interval: 100,
              isVisible: true,
              interactiveTooltip: const InteractiveTooltip(
                enable: false,
                canShowMarker: false,
              ),
            ),
            // Chart title
            title: ChartTitle(
              text: '${"S.current.amount"} (EGP)',
              textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF222222),
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    fontFamily: "Montserrat",
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
              builder: (dynamic data, dynamic point, dynamic series, int index,
                  int c) {
                return CustomToolTipWidget(data: data);
              },
            ),
            enableAxisAnimation: true,
            enableSideBySideSeriesPlacement: true,
            crosshairBehavior: CrosshairBehavior(
              enable: true,
              shouldAlwaysShow: true,
              lineType: CrosshairLineType.none,
              activationMode: ActivationMode.singleTap,
              lineColor: Colors.green,
            ),
            enableMultiSelection: true,
            trackballBehavior: TrackballBehavior(
              activationMode: ActivationMode.singleTap,
              enable: true,
              shouldAlwaysShow: true,
              lineType: TrackballLineType.none,
              tooltipDisplayMode: TrackballDisplayMode.none,
              markerSettings: const TrackballMarkerSettings(
                color: ColorSchemes.gray,
                markerVisibility: TrackballVisibilityMode.visible,
              ),
            ),
            series: <CartesianSeries>[
              LineSeries<ChartData, String>(
                dataSource: widget.chartData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                xAxisName: "${"S.current.days"} (Nov) 2023",
                yAxisName: "${"S.current.amount"} (EGP)",
                pointColorMapper: (ChartData data, idx) =>
                    ColorSchemes.gray.withOpacity(0.4),
                isVisible: true,
                enableTooltip: true,
                markerSettings: const MarkerSettings(
                  isVisible: true,
                  color: ColorSchemes.primary,
                  shape: DataMarkerType.circle,
                  borderWidth: 0,
                ),
                emptyPointSettings: EmptyPointSettings(
                  mode: EmptyPointMode.average,
                  borderColor: ColorSchemes.primary,
                  color: ColorSchemes.gray,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
