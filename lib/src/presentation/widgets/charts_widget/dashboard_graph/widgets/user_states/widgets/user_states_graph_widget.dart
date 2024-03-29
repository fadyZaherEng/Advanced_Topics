import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/generated/l10n.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/button/button_animation/custom_filter_button_with_animation_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/charts_widget/dashboard_graph/widgets/user_states/user_states_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class UserStatesQRScanWidget extends StatefulWidget {
  final List<ChartData> chartData;
  void Function() onTapFilter;
  final int allQrNumber;
  final bool isClickedFilterButton;
  final bool isOpacityFilterButton;

  UserStatesQRScanWidget({
    super.key,
    required this.chartData,
    required this.onTapFilter,
    required this.allQrNumber,
    required this.isClickedFilterButton,
    required this.isOpacityFilterButton,
  });

  @override
  State<UserStatesQRScanWidget> createState() => _UserStatesQRScanWidgetState();
}

class _UserStatesQRScanWidgetState extends State<UserStatesQRScanWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
      decoration: const BoxDecoration(
        color: ColorSchemes.dashboardCardColor,
        borderRadius: BorderRadiusDirectional.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: ColorSchemes.white,
            blurRadius: 10,
            spreadRadius: 15,
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(top: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: FittedBox(
                        child: SizedBox(
                          height: 22,
                          child: Text(
                            "${"S.current.qRsScan"}   ",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: ColorSchemes.black,
                                ),
                          ),
                        ),
                      ),
                    ),
                    CustomFilterButtonWidget(
                      onTapFilter: widget.onTapFilter,
                      isClicked: widget.isClickedFilterButton,
                      isOpacity: widget.isOpacityFilterButton,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  RotatedBox(
                    quarterTurns: 3,
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        " S.current.states",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: _checkIfQrScansEmpty()
                                  ? ColorSchemes.black
                                  : ColorSchemes.gray,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 165,
                    width: 271,
                    child: Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: SizedBox(
                            height: 159,
                            child: SfCartesianChart(
                              plotAreaBorderWidth: 0,
                              margin: const EdgeInsets.only(
                                left: 20,
                              ),
                              primaryXAxis: CategoryAxis(
                                isVisible: true,
                                minorTickLines: const MinorTickLines(
                                  width: 0,
                                  size: 15,
                                  color: ColorSchemes.gray,
                                ),
                                majorTickLines: const MajorTickLines(
                                  width: 0,
                                  size: 15,
                                  color: ColorSchemes.gray,
                                ),
                                majorGridLines: const MajorGridLines(
                                  width: 0,
                                ),
                                labelPlacement: LabelPlacement.betweenTicks,
                                minorGridLines: const MinorGridLines(
                                  width: 0,
                                ),
                                placeLabelsNearAxisLine: true,
                                crossesAt: 0.5,
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      color: ColorSchemes.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                autoScrollingMode: AutoScrollingMode.start,
                                labelAlignment: LabelAlignment.end,
                                labelPosition: ChartDataLabelPosition.outside,
                              ),
                              primaryYAxis: CategoryAxis(
                                isVisible: true,
                                rangePadding: widget.allQrNumber == 0
                                    ? ChartRangePadding.none
                                    : ChartRangePadding.normal,
                                labelPlacement: widget.allQrNumber == 0
                                    ? LabelPlacement.onTicks
                                    : LabelPlacement.betweenTicks,
                                tickPosition: TickPosition.outside,
                                title: AxisTitle(
                                  text:
                                      "${"S.current.all"} ( ${widget.allQrNumber} )",
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: _checkIfQrScansEmpty()
                                            ? ColorSchemes.black
                                            : null,
                                      ),
                                  alignment: ChartAlignment.far,
                                ),
                              ),
                              series: <ChartSeries<ChartData, String>>[
                                BarSeries<ChartData, String>(
                                  dataSource: widget.chartData,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) =>
                                      _checkIfQrScansEmpty() ? null : data.y,
                                  isTrackVisible: false,
                                  enableTooltip: false,
                                  isVisible: true,
                                  width: 1.4,
                                  spacing: 0.4,
                                  pointColorMapper: (ChartData data, _) =>
                                      data.color,
                                  dataLabelSettings: DataLabelSettings(
                                    isVisible: true,
                                    showZeroValue: true,
                                    margin: const EdgeInsets.all(0),
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: ColorSchemes.black,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: widget.allQrNumber == 0 ? 105 : 92,
                              bottom: 15,
                            ),
                            child: Text(
                              "0",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color: _checkIfQrScansEmpty()
                                        ? ColorSchemes.black
                                        : ColorSchemes.gray,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "S.current.numberOfScans",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: _checkIfQrScansEmpty()
                          ? ColorSchemes.black
                          : ColorSchemes.gray,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _checkIfQrScansEmpty() => widget.allQrNumber == 0 ? true : false;
}
