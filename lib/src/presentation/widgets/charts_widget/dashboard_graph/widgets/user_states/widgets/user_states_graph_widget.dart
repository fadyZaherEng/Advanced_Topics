import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/charts_widget/dashboard_graph/widgets/user_states/user_states_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class UserStatesQRScanWidget extends StatefulWidget {
  final List<ChartData> chartData;
  void Function() onTap;

  UserStatesQRScanWidget({
    super.key,
    required this.chartData,
    required this.onTap,
  });

  @override
  State<UserStatesQRScanWidget> createState() => _UserStatesQRScanWidgetState();
}

class _UserStatesQRScanWidgetState extends State<UserStatesQRScanWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Container(
        padding: const EdgeInsetsDirectional.all(12),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "QRs Scan",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorSchemes.black,
                      ),
                ),
                ElevatedButton.icon(
                  onPressed: widget.onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorSchemes.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: const BorderSide(
                        color: ColorSchemes.primary,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                    minimumSize: const Size(100, 30),
                  ),
                  label: Text(
                    "Filter",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: ColorSchemes.white,
                        ),
                  ),
                  icon: SvgPicture.asset(
                    ImagePaths.imagesBlus,
                    color: ColorSchemes.white,
                    width: 16,
                    height: 16,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      "States",
                      softWrap: true,
                      strutStyle: StrutStyle(
                        forceStrutHeight: true,
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 16,
                        textBaseline: TextBaseline.ideographic,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 170,
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(
                        isVisible: true,
                      ),
                      primaryYAxis: CategoryAxis(
                        isVisible: true,
                        title: AxisTitle(
                          text: "All (20)",
                          textStyle:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: ColorSchemes.primary,
                                  ),
                          alignment: ChartAlignment.far,
                        ),
                      ),
                      series: <ChartSeries<ChartData, String>>[
                        BarSeries<ChartData, String>(
                          dataSource: widget.chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          enableTooltip: true,
                          isVisible: true,
                          pointColorMapper: (ChartData data, _) => data.color,
                          dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              "Number Of Scans",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
