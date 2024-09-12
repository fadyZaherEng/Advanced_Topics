// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';

class IsolatesMethodsWidget extends StatefulWidget {
  const IsolatesMethodsWidget({super.key});

  @override
  State<IsolatesMethodsWidget> createState() => _IsolatesMethodsWidgetState();
}

class _IsolatesMethodsWidgetState extends State<IsolatesMethodsWidget> {
  String _results = 'Results will be displayed here';

  Future<int> runInIsolate(Function function, int value) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_isolateEntry, [receivePort.sendPort, function, value]);
    return await receivePort.first;
  }

  static void _isolateEntry(List<dynamic> args) async {
    final sendPort = args[0] as SendPort;
    final function = args[1] as Function;
    final value = args[2] as int;
    final result = await function(value);
    sendPort.send(result);
  }

  Future<void> runTasksInIsolation() async {
    int result1 = await runInIsolate(computeIntensiveTask1, 10);
    int result2 = await runInIsolate(computeIntensiveTask2, 20);
    int result3 = await runInIsolate(computeIntensiveTask3, 30);

    print('Result 1: $result1');
    print('Result 2: $result2');
    print('Result 3: $result3');
  }

  Future<int> computeIntensiveTask1(int value) async {
    // Simulate a computationally const  intensive task
    await Future.delayed(const Duration(seconds: 2)); // Simulating delay
    return value * 2;
  }

  Future<int> computeIntensiveTask2(int value) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulating delay
    return value + 10;
  }

  Future<int> computeIntensiveTask3(int value) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulating delay
    return value - 5;
  }

  Future<void> runTasks() async {
    await runTasksInIsolation();
    setState(() {
      _results = 'Tasks completed, check console for results';
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final stopWatch = Stopwatch()..start();
    await runTasks();
    print('Elapsed time: ${stopWatch.elapsed.inSeconds} ms');
    stopWatch.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: TextButton(
        onPressed: () async {
          print('main #1 of 2');
          scheduleMicrotask(() => print('microtask #1 of 2'));
          Future.delayed(const Duration(seconds: 1), () => print('future #1 (delayed)'));
          Future(() => print('future #2 of 3'));
          Future(() => print('future #3 of 3'));
          scheduleMicrotask(() => print('microtask #2 of 2'));
          print('main #2 of 2');
          final stopWatch = Stopwatch()..start();
          await doTileMatchingWork();
          print('Elapsed time: ${stopWatch.elapsed.inSeconds} ms');
          stopWatch.stop();
          stopWatch.start();
          Future.delayed(
              const Duration(seconds: 10), () => print('future #50 (delayed)'));
          Future.delayed(
              const Duration(seconds: 10), () => print('future #50 (delayed)'));
          Future.delayed(
              const Duration(seconds: 10), () => print('future #50 (delayed)'));
          print("stop: ${stopWatch.elapsedMilliseconds} ms')");
          stopWatch.stop();
        },
        child: const Text('Go back!'),
      ),
    ));
  }

  Future<void> doTileMatchingWork() async {
    await Isolate.spawn((message) async {
      Future.delayed(const Duration(seconds: 10), () {
        print('future #10 (delayed)');
      });
      Future.delayed(const Duration(seconds: 10), () {
        print('future #10 (delayed)');
      });
      Future.delayed(const Duration(seconds: 10), () {
        print('future #10 (delayed)');
      });
    }, 1);
  }
}
