import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/charts_widget/dashboard_graph/widgets/maintainance/widgets/maintainance_request_graph_widget.dart';

class CustomToolTipWidget extends StatefulWidget {
  final ChartData data;
  const CustomToolTipWidget({super.key, required this.data});

  @override
  State<CustomToolTipWidget> createState() => _CustomToolTipWidgetState();
}

class _CustomToolTipWidgetState extends State<CustomToolTipWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 112,
      padding: const EdgeInsets.all(4),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: ColorSchemes.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: ColorSchemes.white,
          width: 0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.data.x.toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: ColorSchemes.gray),
          ),
          const SizedBox(
            width: 5,
          ),
          Container(
            padding: const EdgeInsets.all(4),
            width: 1,
            height: 50,
            color: ColorSchemes.gray.withOpacity(0.3),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            "${widget.data.y.toString()}\n EGP",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: ColorSchemes.black),
          )
        ],
      ),
    );
  }
}
