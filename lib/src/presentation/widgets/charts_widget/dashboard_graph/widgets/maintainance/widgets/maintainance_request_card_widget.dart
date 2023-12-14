import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/charts_widget/dashboard_graph/widgets/maintainance/widgets/maintainance_request_graph_widget.dart';

class MaintainanceRequestCardWidget extends StatefulWidget {
  final int requestsCount;

  const MaintainanceRequestCardWidget({
    super.key,
    required this.requestsCount,
  });

  @override
  State<MaintainanceRequestCardWidget> createState() =>
      _MaintainanceRequestCardWidgetState();
}

class _MaintainanceRequestCardWidgetState
    extends State<MaintainanceRequestCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Container(
        height: (MediaQuery.sizeOf(context).height -
                MediaQuery.of(context).padding.top) *
            0.7,
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 0, vertical: 10),
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
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 15.0),
              child: Text(
                "Maintainance Request",
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
                "${widget.requestsCount} Requests",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorSchemes.primary,
                    ),
              ),
            ),
            const MaintainanceRequestGraphWidget(),
          ],
        ),
      ),
    );
  }
}
