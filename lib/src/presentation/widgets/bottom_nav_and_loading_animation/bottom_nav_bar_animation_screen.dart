import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class BottomNavBarAnimationScreen extends StatefulWidget {
  const BottomNavBarAnimationScreen({super.key});

  @override
  State<BottomNavBarAnimationScreen> createState() =>
      _BottomNavBarAnimationScreenState();
}

class _BottomNavBarAnimationScreenState
    extends State<BottomNavBarAnimationScreen> {
  late PageController _pageController;

  int selectedIndex = 0;

  bool _colorful = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BottomNavBarAnimationScreen"),
      ),
      body: Column(
        children: <Widget>[
          SafeArea(
              child: SwitchListTile(
            title: const Text('Colorful Nav bar'),
            value: _colorful,
            onChanged: (bool value) {
              setState(() {
                _colorful = !_colorful;
              });
            },
          )),
          Expanded(
            child: PageView.builder(
                itemCount: _listOfWidget.length,
                itemBuilder: (context, index) {
                  return _listOfWidget[index];
                },
                physics: const BouncingScrollPhysics(),
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                reverse: true,
                onPageChanged: (int index) {
                  setState(() {
                    selectedIndex = index;
                  });
                  _pageController.animateToPage(selectedIndex,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOutQuad);
                }),
          ),
        ],
      ),
      bottomNavigationBar: _colorful
          ? SlidingClippedNavBar.colorful(
              backgroundColor: ColorSchemes.white,
              onButtonPressed: (index) {
                setState(() {
                  selectedIndex = index;
                });
                _pageController.animateToPage(selectedIndex,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutQuad);
              },
              iconSize: 30,
              selectedIndex: selectedIndex,
              barItems: <BarItem>[
                BarItem(
                  icon: Icons.event,
                  title: 'Events',
                  activeColor: Colors.blue,
                  inactiveColor: Colors.orange,
                ),
                BarItem(
                  icon: Icons.search_rounded,
                  title: 'Search',
                  activeColor: Colors.yellow,
                  inactiveColor: Colors.green,
                ),
                BarItem(
                  icon: Icons.bolt_rounded,
                  title: 'Energy',
                  activeColor: Colors.blue,
                  inactiveColor: Colors.red,
                ),
                BarItem(
                  icon: Icons.tune_rounded,
                  title: 'Settings',
                  activeColor: Colors.cyan,
                  inactiveColor: Colors.purple,
                ),
              ],
            )
          : SlidingClippedNavBar(
              backgroundColor: ColorSchemes.white,
              onButtonPressed: (index) {
                setState(() {
                  selectedIndex = index;
                });
                _pageController.animateToPage(selectedIndex,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutQuad);
              },
              iconSize: 30,
              activeColor: const Color(0xFF01579B),
              selectedIndex: selectedIndex,
              barItems: <BarItem>[
                BarItem(
                  icon: Icons.event,
                  title: 'Events',
                ),
                BarItem(
                  icon: Icons.search_rounded,
                  title: 'Search',
                ),
                BarItem(
                  icon: Icons.bolt_rounded,
                  title: 'Energy',
                ),
                BarItem(
                  icon: Icons.tune_rounded,
                  title: 'Settings',
                ),
              ],
            ),
    );
  }

  final List<Widget> _listOfWidget = <Widget>[
    Container(
      alignment: Alignment.center,
      child: const Icon(
        Icons.event,
        size: 56,
        color: Colors.brown,
      ),
    ),
    Container(
      alignment: Alignment.center,
      child: const Icon(
        Icons.search,
        size: 56,
        color: Colors.brown,
      ),
    ),
    Container(
      alignment: Alignment.center,
      child: const Icon(
        Icons.bolt,
        size: 56,
        color: Colors.brown,
      ),
    ),
    Container(
      alignment: Alignment.center,
      child: const Icon(
        Icons.tune_rounded,
        size: 56,
        color: Colors.brown,
      ),
    ),
  ];
}
