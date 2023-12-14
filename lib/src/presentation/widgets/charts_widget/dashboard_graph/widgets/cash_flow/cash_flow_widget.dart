import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/charts_widget/dashboard_graph/widgets/cash_flow/widgets/cash_flow_card_widget.dart';

class CashFlowWidget extends StatefulWidget {
  const CashFlowWidget({super.key});

  @override
  State<CashFlowWidget> createState() => _CashFlowWidgetState();
}

class _CashFlowWidgetState extends State<CashFlowWidget> {
  final List<ChartData> _chartData = [
    ChartData('Wed \n 15', 300),
    ChartData('Thu \n 16', 100),
    ChartData('Fri \n 17', 150),
    ChartData('Sat \n 18', 800),
    ChartData('Sun \n 19', 500)
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
      child: CashFlowCardWidget(
        chartData: _chartData,
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double? y;
}
