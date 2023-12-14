import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/charts_widget/dashboard_graph/widgets/user_states/widgets/user_states_card_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/charts_widget/dashboard_graph/widgets/user_states/widgets/user_states_graph_widget.dart';

class UserStatesWidget extends StatefulWidget {
  const UserStatesWidget({super.key});

  @override
  State<UserStatesWidget> createState() => _UserStatesWidgetState();
}
class ChartData {
  ChartData(this.x, this.y, this.color);

  Color color;
  final String x;
  final double y;
}
class _UserStatesWidgetState extends State<UserStatesWidget> {
  final List<String> _userStatesCardItems = [
    ImagePaths.apple,
    ImagePaths.face,
    ImagePaths.google,
  ];
  final List<String> _numbers = [
    "10 Active User",
    "12 Pending User",
    "4 Disabled User",
  ];
  final List<Color> _colors = [
    ColorSchemes.activeUserColor,
    ColorSchemes.pendingUserColor,
    ColorSchemes.disabledUserColor
  ];
  final List<ChartData> _chartData = [
    ChartData('Pending', 5, Colors.grey.withOpacity(0.3)),
    ChartData('Scaned', 10, Colors.amber),
    ChartData('Completed', 2, Colors.green),
    ChartData('Hold', 3, Colors.red),
  ].reversed.toList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          UserStatesCardWidget(
            userStatesCardItems: _userStatesCardItems,
            userStatesCardColors: _colors,
            userStatesCardNumbers: _numbers,
          ),
          const SizedBox(
            height: 20,
          ),
          UserStatesQRScanWidget(
            chartData: _chartData,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
