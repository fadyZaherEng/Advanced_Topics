import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/build_app_bar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late PageController _pageController;
  int _currentIndex = 0;
  final List<Widget> _screens = [
    // const UserStatesWidget(),
    // const MaintainanceRequestWidget(),
    // const ServicesWidget(),
    // const CashFlowWidget(),
  ];
  //DashboardBloc get _bloc => BlocProvider.of<DashboardBloc>(context);
  @override
  void initState() {
    _pageController = PageController(
      initialPage: _currentIndex,
    );
    //_bloc.add(DashboardGetLookupRowsEvent());
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
                } else {
                  _currentIndex = index;
                }
                _pageController.jumpToPage(
                  _currentIndex,
                );
              });
            },
            itemBuilder: (BuildContext context, int index) {
              // if (index == 4) {
              //   index = 0;
              // }
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
                      _currentIndex,
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
