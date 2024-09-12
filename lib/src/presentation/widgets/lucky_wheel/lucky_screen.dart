// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class LuckyWheelScreen extends StatefulWidget {
  const LuckyWheelScreen({super.key});

  @override
  _LuckyWheelScreenState createState() => _LuckyWheelScreenState();
}

class _LuckyWheelScreenState extends State<LuckyWheelScreen> {
  StreamController<int> selected = StreamController<int>();
  bool isRolling = true;
  int cycleCount = 2;
  int currentCycle = 0;
  String currentText = 'Start';

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items =
    [
      'Grogu',
      'Mace Windu',
      'Obi-Wan Kenobi',
      'Han Solo',
      'Luke Skywalker',
      'Darth Vader',
      'Yoda',
      'Ahsoka Tano',
      'Chewbacca',
      'C-3PO',
      'R2-D2',
      'C-3PO',
      'R2-D2',
      'C-3PO',
      'R2-D2',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fortune Wheel'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () {
                isRolling = true;
                setState(() {
                  var random = Fortune.randomInt(0, items.length);
                  selected.add(random);
                 // print('Random: $random -> ${items[random]}');
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: FortuneWheel(
                  selected: selected.stream,
                  onFling: () {
                    print('Fling');
                  },
                  onAnimationStart: () {
                    print('Start');
                  },
                  onAnimationEnd: () {
                    print('End');
                    if (isRolling) {
                      var random = Fortune.randomInt(0, items.length);
                      selected.add(random);
                      print('Random: $random -> ${items[random]}');
                      currentCycle++;
                      if (currentCycle == cycleCount) {
                        setState(() {});
                        currentText = items[random];
                        currentCycle = 0;
                        isRolling = false;
                        print('Stop');
                      }
                    }
                  },
                  onFocusItemChanged: (int index) {
                    print('Focus: $index');
                  },
                  items: [
                    for (var it in items) FortuneItem(child: Text(it)),
                  ],
                  animateFirst: false,
                  // duration: const Duration(seconds: 2),
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
          Text(currentText),
          Expanded(flex: 1, child: SizedBox.shrink())
        ],
      ),
    );
  }
}
