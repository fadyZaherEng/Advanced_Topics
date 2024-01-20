import 'dart:math';

import 'package:flutter/material.dart';

class DefualtTextStyleTransitionWidget extends StatefulWidget {
  const DefualtTextStyleTransitionWidget({super.key});

  @override
  State<DefualtTextStyleTransitionWidget> createState() =>
      _DefualtTextStyleTransitionWidgetState();
}

class _DefualtTextStyleTransitionWidgetState
    extends State<DefualtTextStyleTransitionWidget>
    with SingleTickerProviderStateMixin {
  Animation<TextStyle>? animation;
  AnimationController? controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true, min: 0, max: 1);
    //DefaultTextStyleTransition
    Random random = Random();
    animation = TextStyleTween(
      begin: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color.fromRGBO(
          random.nextInt(255),
          random.nextInt(255),
          random.nextInt(255),
          1,
        ),
      ),
      end: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Color.fromRGBO(
          random.nextInt(255),
          random.nextInt(255),
          random.nextInt(255),
          1,
        ),
      ),
    ).animate(controller!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DefaultTextStyleTransition(
          style: animation!,
          textAlign: TextAlign.center,
          child: const Text("DefaultTextStyleTransition"),
        ),
      ],
    );
  }
}
