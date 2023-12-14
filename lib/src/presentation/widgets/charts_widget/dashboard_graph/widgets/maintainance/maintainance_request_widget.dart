import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/charts_widget/dashboard_graph/widgets/maintainance/widgets/maintainance_request_card_widget.dart';

class MaintainanceRequestWidget extends StatefulWidget {
  const MaintainanceRequestWidget({super.key});

  @override
  State<MaintainanceRequestWidget> createState() =>
      _MaintainanceRequestWidgetState();
}

class _MaintainanceRequestWidgetState extends State<MaintainanceRequestWidget> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
      child: MaintainanceRequestCardWidget(
        requestsCount: 20,
      ),
    );
  }
}
