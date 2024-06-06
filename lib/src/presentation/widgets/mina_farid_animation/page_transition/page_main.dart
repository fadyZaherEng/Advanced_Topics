import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/mina_farid_animation/page_transition/page_fade_transition.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/mina_farid_animation/page_transition/page_tow.dart';

class PageMainNavigator extends StatefulWidget {
  const PageMainNavigator({super.key});

  @override
  State<PageMainNavigator> createState() => _PageMainNavigatorState();
}

class _PageMainNavigatorState extends State<PageMainNavigator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Page Main"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              PageFadeTransition(const PageTwo()));
          },
          child: const Text("Go To Page Two"),
        ),
      ),
    );
  }
}
