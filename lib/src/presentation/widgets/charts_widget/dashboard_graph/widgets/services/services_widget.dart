import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/charts_widget/dashboard_graph/widgets/services/widgets/service_subscription_card_widget.dart';

class ServicesWidget extends StatefulWidget {
  const ServicesWidget({super.key});

  @override
  State<ServicesWidget> createState() => _ServicesWidgetState();
}

class _ServicesWidgetState extends State<ServicesWidget> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding:
          EdgeInsetsDirectional.symmetric(horizontal: 10.0, vertical: 15.0),
      child: ServiceSubscriptionWidget(),
    );
  }
}
