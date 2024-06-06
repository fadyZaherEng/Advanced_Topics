// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

class TweenStatusWidget extends StatefulWidget {
  const TweenStatusWidget({super.key});

  @override
  State<TweenStatusWidget> createState() => _TweenStatusWidgetState();
}

class _TweenStatusWidgetState extends State<TweenStatusWidget>
    with TickerProviderStateMixin {
  AnimationController? _animatedContainer;
  AnimationController? animationController;
  Animation<double>? _animation;
  Animation? _animation2;

  @override
  void initState() {
    super.initState();
    _animatedContainer = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..repeat(reverse: true)
      ..addListener(
        () {
          setState(() {
            print('Animation Controller: ${_animatedContainer!.value}');
            print('Animation value: ${_animation!.value} ${_animation!.status}');
          });
        },
      );
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 300),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _animatedContainer!,
      curve: Curves.bounceInOut,
    ));

    _animation2 = ColorTween(
      begin: Colors.red,
      end: Colors.blue,
    ).animate(CurvedAnimation(
      parent: animationController!,
      curve: Curves.easeIn,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TweenStatus'),
      ),
      body: Center(
          child: Column(
        children: [
          Column(
            children: [
              // InkWell(
              //   onTap: () {
              //     _animatedContainer!.forward();
              //   },
              //   child: Text(
              //     'Animation value: ${_animation!.value} ${_animation!.status}',
              //     style: const TextStyle(fontSize: 20),
              //   ),
              // ),
              const SizedBox(height: 100),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 0),
                      color: Colors.deepPurple,
                      blurRadius: 6*_animation!.value,
                      spreadRadius: 0,
                    ),
                  ],
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 100),
          AnimatedBuilder(
            animation: _animation2!,
            builder: (context, child) {
              return Text('Animation Controller: ${_animation2!.value}');
            },
          )
        ],
      )),
    );
  }
}
