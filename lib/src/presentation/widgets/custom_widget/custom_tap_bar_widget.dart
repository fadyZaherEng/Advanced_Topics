import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/base/widget/base_stateful_widget.dart';

class CustomTabBarWidget extends BaseStatefulWidget {
  final String titleOfTapOne;
  final String titleOfTapTwo;
  final Widget contentOfTapOne;
  final Widget contentOfTapTwo;

  const CustomTabBarWidget({
    Key? key,
    required this.titleOfTapOne,
    required this.titleOfTapTwo,
    required this.contentOfTapOne,
    required this.contentOfTapTwo,
  }) : super(key: key);

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _CustomTabbarWidgetState();
}

class _CustomTabbarWidgetState extends BaseState<CustomTabBarWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                        height: 6,
                        decoration:
                            const BoxDecoration(color: ColorSchemes.lightGray)),
                  ),
                ),
                TabBar(
                  unselectedLabelColor: ColorSchemes.black,
                  unselectedLabelStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(
                          color: ColorSchemes.black, letterSpacing: -0.24),
                  labelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: ColorSchemes.black, letterSpacing: -0.24),
                  labelColor: ColorSchemes.black,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  controller: _tabController,
                  indicator: const UnderlineTabIndicator(
                    borderSide:
                        BorderSide(width: 6.0, color: ColorSchemes.primary),
                  ),
                  tabs: [
                    Tab(
                      text: widget.titleOfTapOne,
                    ),
                    Tab(
                      text: widget.titleOfTapTwo,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
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
    _tabController.dispose();
    super.dispose();
  }
}
