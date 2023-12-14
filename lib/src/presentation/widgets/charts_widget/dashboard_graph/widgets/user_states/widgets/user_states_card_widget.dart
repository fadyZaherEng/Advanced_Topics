import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/charts_widget/dashboard_graph/widgets/user_states/widgets/user_states_card_item_widget.dart';

class UserStatesCardWidget extends StatefulWidget {
  final List<String> userStatesCardItems;
  final List<Color> userStatesCardColors;
  final List<String> userStatesCardNumbers;

  const UserStatesCardWidget({
    super.key,
    required this.userStatesCardItems,
    required this.userStatesCardColors,
    required this.userStatesCardNumbers,
  });

  @override
  State<UserStatesCardWidget> createState() => _UserStatesCardWidgetState();
}

class _UserStatesCardWidgetState extends State<UserStatesCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.36,
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 12),
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
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(
              "User States",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ColorSchemes.black,
                  ),
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.28,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: widget.userStatesCardItems.asMap().entries.map((e) {
                int index = e.key;
                return UserStatesCardItemWidget(
                  path: e.value,
                  number: widget.userStatesCardNumbers[index],
                  color: widget.userStatesCardColors[index],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
