import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedDefaultTextWidget extends StatefulWidget {
  const AnimatedDefaultTextWidget({super.key});

  @override
  State<AnimatedDefaultTextWidget> createState() =>
      _AnimatedDefaultTextWidgetState();
}

class _AnimatedDefaultTextWidgetState extends State<AnimatedDefaultTextWidget> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        fontSize = Random().nextInt(60).toDouble();
        fontWeight = fontWeight == FontWeight.normal
            ? FontWeight.bold
            : FontWeight.normal;
        color = Color.fromARGB(
          Random().nextInt(255),
          Random().nextInt(255),
          Random().nextInt(255),
          1,
        );
      });
    });
  }

  double fontSize = 30;
  Color color = Colors.blue;
  FontWeight fontWeight = FontWeight.bold;
  @override
  Widget build(BuildContext context) {
    return Column(
      //change text size and color based on button click and timer
      //use animated default text style
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(seconds: 1),
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: color,
            ),
            child: const Text("AnimatedDefaultTextStyle"),
          ),
        ),
      ],
    );
  }
}
