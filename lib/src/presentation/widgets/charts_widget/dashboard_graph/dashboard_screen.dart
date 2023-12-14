import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/charts_widget/dashboard_graph/widgets/cash_flow/cash_flow_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/charts_widget/dashboard_graph/widgets/maintainance/maintainance_request_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/charts_widget/dashboard_graph/widgets/services/services_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/charts_widget/dashboard_graph/widgets/user_states/user_states_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late PageController _pageController;
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const UserStatesWidget(),
    const MaintainanceRequestWidget(),
    const ServicesWidget(),
    const CashFlowWidget(),
  ];

  @override
  void initState() {
    _pageController = PageController(
      initialPage: _currentIndex,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWidget(
        context,
        title: "Home Dashboard",
        isHaveBackButton: false,
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            itemCount: 5,
            onPageChanged: (index) {
              setState(() {
                if (index == 4) {
                  _currentIndex = 0;
                  _pageController.jumpToPage(
                    _currentIndex,
                  );
                } else {
                  _currentIndex = index;
                  _pageController.jumpToPage(
                    index,
                  );
                }
              });
            },
            itemBuilder: (BuildContext context, int index) {
              if (index == 4) {
                index = 0;
              }
              return _screens[_currentIndex];
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Positioned(
            height: 5,
            left: MediaQuery.sizeOf(context).width * 0.35,
            right: MediaQuery.sizeOf(context).width * 0.35,
            bottom: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = index;
                    _pageController.jumpToPage(
                      index,
                    );
                  });
                },
                child: Container(
                  width: _currentIndex == index ? 25.0 : 12.5,
                  height: 2,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 3,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    color: _currentIndex == index
                        ? ColorSchemes.primary
                        : ColorSchemes.gray,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
