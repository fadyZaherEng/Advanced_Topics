import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';

class AnimatedSwitcherExample extends StatefulWidget {
  const AnimatedSwitcherExample({super.key});

  @override
  State<AnimatedSwitcherExample> createState() =>
      _AnimatedSwitcherExampleState();
}

class _AnimatedSwitcherExampleState extends State<AnimatedSwitcherExample> {
  bool _isFirstWidgetVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Animated Switcher Example"),
        ),
        body: Center(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isFirstWidgetVisible = !_isFirstWidgetVisible;
              });
            },
            child: AnimatedSwitcher(
               switchInCurve: Curves.linear,
              switchOutCurve: Curves.linear,
              duration: const Duration(milliseconds: 1000),
              child: _isFirstWidgetVisible ? Container(
                height: 200,
                width: 200,
                color: Colors.blueGrey,
                child: Center(
                  child: Image.asset(ImagePaths.dog),
                ),
              ): Container(
                height: 200,
                width: 200,
                color: Colors.blueGrey,
                child: Center(
                  child: Image.asset(ImagePaths.jerry),
                ),
              ),
            ),
          ),
        ));
  }
}