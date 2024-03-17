import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/new/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Steps {
  final int id; //equal to index
  final String name;
  final bool isSelected;

  Steps({required this.id, required this.name, this.isSelected = false});
}

//Calling StepsWidget
// StepsWidget(
// currentIndex: 0,
// onTapStep: (int index) {},
// pageController: PageController(),
// steps: [
// Steps(
// name: "home",
// id: 0,
// isSelected: true,
// ),
// Steps(
// name: "profile",
// id: 1,
// isSelected: false,
// ),
// Steps(
// name: "payment",
// id: 2,
// isSelected: false,
// ),
// Steps(
// name: " badge",
// id: 3,
// isSelected: false,
// ),
// Steps(
// name: " settings",
// id: 4,
// isSelected: false,
// ),
// ],
// pages: const [
// Home(),
// Center(child: Text("Profile")),
// Center(child: Text("Payment")),
// Center(child: Text("Badge")),
// Center(child: Text("Settings")),
// ],
// )
class StepsWidget extends StatelessWidget {
  final List<Steps> steps;
  final List<Widget> pages;
  final Function(int currentIndex) onTapStep;
  final int currentIndex;
  final PageController pageController;
  final bool isProfile;

  const StepsWidget({
    Key? key,
    required this.steps,
    required this.pages,
    required this.onTapStep,
    required this.currentIndex,
    required this.pageController,
    this.isProfile = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: steps.length == 3
                              ? 30
                              : steps.length == 2 || steps.length == 1
                                  ? 50
                                  : 15),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (var stepIndex = 0;
                                        stepIndex < steps.length;
                                        stepIndex++)
                                      if (stepIndex != steps.length - 1)
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              steps.length,
                                          child: Divider(
                                            color: isProfile
                                                ? ColorSchemes.lightGray
                                                : currentIndex >=
                                                        steps[stepIndex].id + 1
                                                    ? ColorSchemes.primary
                                                    : ColorSchemes.lightGray,
                                            thickness: 2,
                                          ),
                                        ),
                                  ],
                                ),
                              ),
                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment: steps.length == 1
                                    ? MainAxisAlignment.center
                                    : MainAxisAlignment.spaceBetween,
                                children: [
                                  for (var step in steps)
                                    Padding(
                                      padding: EdgeInsets.zero,
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: () => onTapStep(step.id),
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                color: !isProfile
                                                    ? currentIndex >= step.id
                                                        ? ColorSchemes.primary
                                                        : ColorSchemes.lightGray
                                                    : currentIndex == step.id
                                                        ? ColorSchemes.primary
                                                        : ColorSchemes
                                                            .lightGray,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              child: Center(
                                                child: !isProfile
                                                    ? SvgPicture.asset(
                                                        _getIcon(step.id),
                                                        fit: BoxFit.scaleDown,
                                                        width: 16,
                                                        height: 16,
                                                        color: Colors.white,
                                                      )
                                                    : Text(
                                                        isProfile
                                                            ? ""
                                                            : step.id
                                                                .toString(),
                                                        style:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                  letterSpacing:
                                                                      -0.13,
                                                                  color: !isProfile
                                                                      ? currentIndex >= step.id
                                                                          ? ColorSchemes.white
                                                                          : ColorSchemes.gray
                                                                      : currentIndex == step.id
                                                                          ? ColorSchemes.white
                                                                          : ColorSchemes.gray,
                                                                  fontWeight:
                                                                      Constants
                                                                          .fontWeightSemiBold,
                                                                ),
                                                      ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            step.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: !isProfile
                                                        ? currentIndex >=
                                                                step.id
                                                            ? ColorSchemes.black
                                                            : ColorSchemes.gray
                                                        : currentIndex ==
                                                                step.id
                                                            ? ColorSchemes.black
                                                            : ColorSchemes.gray,
                                                    letterSpacing: -0.13),
                                            textAlign: TextAlign.end,
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 4,
                color: ColorSchemes.lightGray,
              ),
              Expanded(
                child: PageView.builder(
                  pageSnapping: true,
                  allowImplicitScrolling: true,
                  scrollBehavior: const ScrollBehavior(),
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  itemCount: steps.length,
                  itemBuilder: (context, index) {
                    return pages[index];
                  },
                  onPageChanged: (index) {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getIcon(int currentIndex) {
    if (currentIndex == 1) {
      return ImagePaths.stepInfo;
    } else if (currentIndex == 2) {
      return ImagePaths.stepUnit;
    } else if (currentIndex == 3) {
      return ImagePaths.stepFiles;
    } else if (currentIndex == 4) {
      return ImagePaths.stepFamily;
    } else {
      return ImagePaths.stepCar;
    }
  }
}
