import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
