import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';

class CustomRefreshIndicatorWidget extends StatefulWidget {
  const CustomRefreshIndicatorWidget({super.key});

  @override
  State<CustomRefreshIndicatorWidget> createState() =>
      _CustomRefreshIndicatorWidgetState();
}

class _CustomRefreshIndicatorWidgetState
    extends State<CustomRefreshIndicatorWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Custom Refresh Indicator',
        ),
      ),
      body: CustomMaterialIndicator(
        backgroundColor: ColorSchemes.white,
        onRefresh: () async {
          setState(() {
            // yor logic here
          });
          await Future.delayed(const Duration(seconds: 3));
        },
        indicatorBuilder:
            (BuildContext context, IndicatorController controller) {
          return const Icon(
            Icons.refresh,
            color: ColorSchemes.primary,
            size: 30,
          );
        },
        child: ListView.builder(
          itemCount: 100,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                index.toString(),
              ),
            );
          },
        ),
      ),
    );
  }
}
