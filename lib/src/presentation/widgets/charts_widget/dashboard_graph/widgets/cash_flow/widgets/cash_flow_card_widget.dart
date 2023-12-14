import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/charts_widget/dashboard_graph/widgets/cash_flow/cash_flow_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/charts_widget/dashboard_graph/widgets/cash_flow/widgets/cash_flow_graph_widget.dart';

class CashFlowCardWidget extends StatefulWidget {
  final List<ChartData> chartData;

  const CashFlowCardWidget({
    super.key,
    required this.chartData,
  });

  @override
  State<CashFlowCardWidget> createState() => _CashFlowCardWidgetState();
}

class _CashFlowCardWidgetState extends State<CashFlowCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Container(
        height: (MediaQuery.sizeOf(context).height -
                MediaQuery.of(context).padding.top) *
            0.7,
        padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
              child: Text(
                "Cash Flow",
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorSchemes.black,
                    ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 48,
              width: double.infinity,
              margin: const EdgeInsetsDirectional.symmetric(horizontal: 15),
              padding: const EdgeInsetsDirectional.all(10),
              decoration: BoxDecoration(
                color: ColorSchemes.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                "Payments for the last Five days",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorSchemes.primary,
                    ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CashFlowGraphWidget(
              chartData: widget.chartData,
            ),
          ],
        ),
      ),
    );
  }
}
