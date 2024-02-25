// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/custom_snack_bar_widget.dart';
import 'package:im_stepper/stepper.dart';

class StepperWidget extends StatefulWidget {
  const StepperWidget({super.key});

  @override
  State<StepperWidget> createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  int _currentStep = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        _currentStep++;
        setState(() {});
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        _currentStep--;
        setState(() {});
      } else {
        _currentStep = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Stepper(
              connectorThickness: 1.5,
              elevation: 0,
              currentStep: _currentStep,
              type: StepperType.vertical,
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              onStepCancel: () {
                if (_currentStep > 0) {
                  _currentStep--;
                  setState(() {});
                } else {
                  _currentStep = 0;
                }
              },
              onStepContinue: () {
                if (_currentStep < 4) {
                  _currentStep++;
                  setState(() {});
                } else {
                  _currentStep = 0;
                }
              },
              onStepTapped: (int index) {
                _currentStep = index;
                setState(() {});
                _scrollController.animateTo(
                  _scrollController.position.minScrollExtent,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                );
              },
              // controlsBuilder: (BuildContext context, ControlsDetails details) {
              //   return Row(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         ElevatedButton(
              //           onPressed: details.onStepContinue,
              //           child: const Text('Next'),
              //         ),
              //         const SizedBox(width: 10),
              //         OutlinedButton(
              //           onPressed: details.onStepCancel,
              //           child: const Text('Back'),
              //         ),
              //       ]);
              // },
              // controlsBuilder: (BuildContext context, ControlsDetails details) {
              //   _currentStep = details.currentStep;
              //   return Container(
              //     margin: const EdgeInsets.only(top: 20),
              //     color: Colors.teal,
              //     height: 100,
              //     child: Center(
              //       child: Text(
              //         '$_currentStep',
              //         style: const TextStyle(
              //           color: Colors.white,
              //           fontWeight: FontWeight.bold,
              //           fontSize: 20,
              //         ),
              //       ),
              //     ),
              //   );
              // },
              // stepIconBuilder: (int index, StepState state) {
              //   return const Icon(Icons.check_outlined, color: Colors.green);
              // },
              steps: [
                Step(
                  title: const Text('Step 1'),
                  content: const Text('Content for Step 1'),
                  subtitle: const Text('Subtitle for Step 1'),
                  state: _currentStep <= 0
                      ? StepState.editing
                      : StepState.complete,
                  isActive: _currentStep >= 0,
                  //  label: Text('Step 1'),
                ),
                Step(
                  title: const Text('Step 2'),
                  content: const Text('Content for Step 2'),
                  //label: const Text('Step 2'),
                  // subtitle: const Text('Subtitle for Step 2'),
                  state: _currentStep <= 1
                      ? StepState.editing
                      : StepState.complete,
                  isActive: _currentStep >= 1,
                ),
                Step(
                  title: const Text('Step 3'),
                  content: const Text('Content for Step 3'),
                  // label: const Text('Step 3'),
                  //subtitle: const Text('Subtitle for Step 3'),
                  state: _currentStep <= 2
                      ? StepState.editing
                      : StepState.complete,
                  isActive: _currentStep >= 2,
                ),
                Step(
                  title: const Text('Step 4'),
                  content: const Text('Content for Step 4'),
                  // label: const Text('Step 3'),
                  //subtitle: const Text('Subtitle for Step 3'),
                  state: _currentStep <= 3
                      ? StepState.editing
                      : StepState.complete,
                  isActive: _currentStep >= 3,
                ),
                Step(
                  title: const Text('Step 5'),
                  content: const Text('Content for Step 5'),
                  // label: const Text('Step 3'),
                  //subtitle: const Text('Subtitle for Step 3'),
                  state: _currentStep <= 4
                      ? StepState.editing
                      : StepState.complete,
                  isActive: _currentStep >= 4,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class IconStepperDemo extends StatefulWidget {
  const IconStepperDemo({super.key});

  @override
  _IconStepperDemo createState() => _IconStepperDemo();
}

class _IconStepperDemo extends State<IconStepperDemo> {
  // THE FOLLOWING TWO VARIABLES ARE REQUIRED TO CONTROL THE STEPPER.
  int activeStep = 0; // Initial step set to 5.

  int upperBound = 6; // upperBound MUST BE total number of icons minus 1.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IconStepper Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            IconStepper(
              icons: const [
                Icon(Icons.supervised_user_circle),
                Icon(Icons.flag),
                Icon(Icons.access_alarm),
                Icon(Icons.supervised_user_circle),
                Icon(Icons.flag),
                Icon(Icons.access_alarm),
                Icon(Icons.supervised_user_circle),
              ],
              activeStep: activeStep,
              enableStepTapping: true,
              stepRadius: 20,
              lineColor: Colors.tealAccent,
              lineDotRadius: 1,
              lineLength: 100,
              alignment: Alignment.center,
              stepColor: Colors.red,
              stepPadding: 5,
              steppingEnabled: true,
              enableNextPreviousButtons: true,
              nextButtonIcon: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
                size: 20,
              ),
              previousButtonIcon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 20,
              ),
              onStepReached: (index) {
                if (index == upperBound) {
                  CustomSnackBarWidget.show(
                    context: context,
                    message: 'Completed',
                    path: ImagePaths.icSuccessNew,
                    backgroundColor: Colors.green,
                  );
                }
                setState(() {
                  activeStep = index;
                });
              },
              activeStepBorderColor: Colors.teal,
              activeStepColor: Colors.green,
              activeStepBorderPadding: 5,
              activeStepBorderWidth: 2,
              direction: Axis.horizontal,
              // enableNextPreviousButtons: true,
              // enableStepTapping: true,
              //   previousButtonIcon: const Icon(
              //     Icons.arrow_back,
              //     color: Colors.black,
              //   ),
              //   nextButtonIcon: const Icon(
              //     Icons.arrow_forward,
              //     color: Colors.black,
              //   ),
              stepReachedAnimationDuration: const Duration(seconds: 1),
              stepReachedAnimationEffect: Curves.easeInCubic,
            ),
            header(),
            Expanded(
              child: FittedBox(
                child: Center(
                  child: Text('$activeStep'),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                previousButton(),
                nextButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Returns the next button.
  Widget nextButton() {
    return ElevatedButton(
      onPressed: () {
        if (activeStep < upperBound) {
          setState(() {
            activeStep++;
          });
        }
        if (activeStep == upperBound) {
          CustomSnackBarWidget.show(
            context: context,
            message: 'Completed',
            path: ImagePaths.icSuccessNew,
            backgroundColor: Colors.green,
          );
        }
      },
      child: const Text('Next'),
    );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return ElevatedButton(
      onPressed: () {
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
      child: const Text('Prev'),
    );
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              headerText(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Returns the header text based on the activeStep.
  String headerText() {
    switch (activeStep) {
      case 1:
        return 'Preface';

      case 2:
        return 'Table of Contents';

      case 3:
        return 'About the Author';

      case 4:
        return 'Publisher Information';

      case 5:
        return 'Reviews';

      case 6:
        return 'Chapters #1';

      default:
        return 'Introduction';
    }
  }
}
