import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedContainerScreen extends StatefulWidget {
  const AnimatedContainerScreen({super.key});

  @override
  State<AnimatedContainerScreen> createState() =>
      _AnimatedContainerScreenState();
}

class _AnimatedContainerScreenState extends State<AnimatedContainerScreen> {
  double width = 100;
  double height = 100;
  Color color = Colors.red;
  bool opacity = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: AnimatedOpacity(
            duration: const Duration(seconds: 3),
            opacity: opacity ? 1 : 0,
            child: AnimatedContainer(
              duration: const Duration(seconds: 3),
              curve: Curves.linear,
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        TextButton(
            onPressed: () {
              setState(
                () {
                  opacity = !opacity;
                  Random random = Random();
                  color = Color.fromARGB(random.nextInt(256),
                      random.nextInt(256), random.nextInt(256), 1);
                  width = random.nextInt(300).toDouble();
                  height = random.nextInt(300).toDouble();
                },
              );
            },
            child: const Text('AnimatedContainer inside AnimatedOpacity')),
      ],
    );
  }
}
