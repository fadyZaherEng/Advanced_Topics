import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/base/widget/base_stateful_widget.dart';

class CustomTabBarWidget extends BaseStatefulWidget {
  final String titleOfTapOne;
  final String titleOfTapTwo;
  final Widget contentOfTapOne;
  final Widget contentOfTapTwo;
  final Function(int)? currentIndex;
  final TabController tabController;

  const CustomTabBarWidget({
    Key? key,
    required this.titleOfTapOne,
    required this.titleOfTapTwo,
    required this.contentOfTapOne,
    required this.contentOfTapTwo,
    required this.tabController,
    this.currentIndex,
  }) : super(key: key);

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _CustomTabBarWidgetState();
}

class _CustomTabBarWidgetState extends BaseState<CustomTabBarWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(() {
      if (widget.currentIndex != null) {
        widget.currentIndex!(widget.tabController.index);
      }
    });
  }

  @override
  Widget baseBuild(BuildContext context) {
    return DefaultTabController(
      animationDuration: const Duration(milliseconds: 700),
      length: 2,
      child: Column(
        children: [
          SizedBox(
            height: 48,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Container(
                      height: 6,
                      decoration: const BoxDecoration(
                        color: ColorSchemes.lightGray,
                      ),
                    ),
                  ),
                ),
                TabBar(
                  onTap: (int index) {
                    FocusScope.of(context).unfocus();
                  },
                  unselectedLabelColor: ColorSchemes.black,
                  unselectedLabelStyle:
                      Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorSchemes.black,
                            letterSpacing: -0.24,
                          ),
                  labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: ColorSchemes.black,
                        letterSpacing: -0.24,
                      ),
                  labelColor: ColorSchemes.black,
                  controller: widget.tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 6.0,
                        color: ColorSchemes.primary,
                      ),
                      insets: const EdgeInsetsDirectional.symmetric(
                          horizontal: 16.0)),
                  tabs: [
                    Tab(text: widget.titleOfTapOne),
                    Tab(text: widget.titleOfTapTwo),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: widget.tabController,
              children: [
                widget.contentOfTapOne,
                widget.contentOfTapTwo,
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.tabController.dispose();
    super.dispose();
  }
}
