// ignore_for_file: deprecated_member_use

import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/charts_widget/dashboard_graph/widgets/services/widgets/service_subscription_graph_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServiceSubscriptionWidget extends StatefulWidget {
  const ServiceSubscriptionWidget({super.key});

  @override
  State<ServiceSubscriptionWidget> createState() =>
      _ServiceSubscriptionWidgetState();
}

class _ServiceSubscriptionWidgetState extends State<ServiceSubscriptionWidget> {
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
              padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
              child: Text(
                "Service Subscription",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorSchemes.black,
                    ),
              ),
            ),
            const SizedBox(height: 20),
            const ServiceSubscriptionGraphWidget(),
            const SizedBox(height: 20),
            Center(
              child: Container(
                height: 54,
                width: 206,
                padding: const EdgeInsetsDirectional.all(12),
                decoration: BoxDecoration(
                  color: ColorSchemes.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: ColorSchemes.primary,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "See All Services",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorSchemes.primary,
                          ),
                    ),
                    const SizedBox(width: 10),
                    SvgPicture.asset(
                      ImagePaths.backArrow,
                      color: ColorSchemes.primary,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
