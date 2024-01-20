import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedPaddingAlignWidget extends StatefulWidget {
  const AnimatedPaddingAlignWidget({super.key});

  @override
  State<AnimatedPaddingAlignWidget> createState() =>
      _AnimatedPaddingAlignWidgetState();
}

class _AnimatedPaddingAlignWidgetState
    extends State<AnimatedPaddingAlignWidget> {
  //move object based on x and y values and change color based on random number
  //inside container using timer and animated align
  double padding = 0;
  double alignX = 0;
  double alignY = 0;
  Color color = Colors.black;
  Color color2 = Colors.white;
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        alignX = alignX == 0 ? Random().nextDouble() + 0.1 : 0;
        alignY = alignY == 0 ? Random().nextDouble() + 0.1 : 0;
        Random random = Random();
        color = Color.fromARGB(
          random.nextInt(255),
          random.nextInt(255),
          random.nextInt(255),
          1,
        );
        color2 = Color.fromARGB(
          random.nextInt(255),
          random.nextInt(255),
          random.nextInt(255),
          1,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //animated padding
          SizedBox(
            height: 300,
            width: 200,
            child: Column(
              children: [
                AnimatedPadding(
                  duration: const Duration(seconds: 2),
                  curve: Curves.linear,
                  padding: EdgeInsets.symmetric(
                      horizontal: padding, vertical: padding),
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      padding = padding == 0 ? 10 : 0;
                    });
                  },
                  child: const Text('AnimatedPadding'),
                ),
              ],
            ),
          ),
          //animated align move object based on x and y inside container
          // i can make click happen each second automatically using Timer
          const SizedBox(
            height: 100,
          ),
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: color2,
              borderRadius: BorderRadius.circular(10),
            ),
            child: AnimatedAlign(
              duration: const Duration(seconds: 1),
              curve: Curves.linear,
              alignment: Alignment(alignX, alignY),
              child: Icon(
                Icons.favorite,
                color: color,
                size: 50,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                alignX = alignX == 0 ? Random().nextDouble() : 0;
                alignY = alignY == 0 ? Random().nextDouble() : 0;
                Random random = Random();
                color = Color.fromARGB(
                  random.nextInt(255),
                  random.nextInt(255),
                  random.nextInt(255),
                  1,
                );
              });
            },
            child: const Text('AnimatedAlign'),
          ),
        ],
      ),
    );
  }
}
