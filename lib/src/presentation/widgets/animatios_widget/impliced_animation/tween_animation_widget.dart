import 'dart:math';

import 'package:flutter/material.dart';

class TweenAnimationWidget extends StatefulWidget {
  const TweenAnimationWidget({super.key});

  @override
  State<TweenAnimationWidget> createState() => _TweenAnimationWidgetState();
}

class _TweenAnimationWidgetState extends State<TweenAnimationWidget> {
  double _angle = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //transform object from begin to end in fixed duration
        TweenAnimationBuilder<double>(
          duration: const Duration(seconds: 1),
          tween: Tween<double>(begin: 0, end: _angle),
          builder: (context, double angle, child) {
            return Transform.rotate(
              angle: angle,
              child: child,
            );
          },
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Angle: ${(_angle * 180 / pi).round()} using TweenAnimationBuilder',
        ),
        const SizedBox(
          height: 20,
        ),
        Slider(
          value: _angle,
          onChanged: (value) {
            setState(() {
              _angle = value;
            });
          },
          min: 0,
          max: pi * 2,
          divisions: 4,
        ),
      ],
    );
  }
}
