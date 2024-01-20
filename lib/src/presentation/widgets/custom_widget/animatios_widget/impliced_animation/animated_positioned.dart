import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedPositionedWidget extends StatefulWidget {
  const AnimatedPositionedWidget({super.key});

  @override
  State<AnimatedPositionedWidget> createState() =>
      _AnimatedPositionedWidgetState();
}

class _AnimatedPositionedWidgetState extends State<AnimatedPositionedWidget> {
  bool visible = false;
  Color color = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Column(
      //بيفتح الكونتينر على شكل ستاره
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            height: 200,
            width: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Text("AnimatedPositioned"),
                AnimatedPositioned(
                  duration: const Duration(seconds: 3),
                  curve: Curves.linear,
                  bottom: visible ? 200 : 0,
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 100,
        ),
        Center(
          child: SizedBox(
            height: 200,
            width: 200,
            child: Stack(
              // alignment: Alignment.center,
              children: [
                Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: SizedBox(
                    height: 100,
                    child: Center(
                      child: Visibility(
                        visible: visible,
                        child: const Text(
                          "AnimatedPositioned",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(seconds: 1),
                  curve: Curves.linear,
                  bottom: visible ? 100 : 0,
                  child: Container(
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        //each second
        const SizedBox(
          height: 20,
        ),
        TextButton(
          onPressed: () {
            setState(() {
              Random random = Random();
              color = Color.fromARGB(
                random.nextInt(255),
                random.nextInt(255),
                random.nextInt(255),
                1,
              );
              visible = !visible;
            });
          },
          child: const Text('Click Me'),
        )
      ],
    );
  }
}
