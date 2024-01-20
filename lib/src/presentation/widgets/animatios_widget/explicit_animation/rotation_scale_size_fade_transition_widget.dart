import 'package:flutter/material.dart';

class RotationSizeScaleFadeTransitionWidget extends StatefulWidget {
  const RotationSizeScaleFadeTransitionWidget({super.key});

  @override
  State<RotationSizeScaleFadeTransitionWidget> createState() =>
      _RotationSizeScaleFadeTransitionWidgetState();
}

class _RotationSizeScaleFadeTransitionWidgetState
    extends State<RotationSizeScaleFadeTransitionWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true, min: 0, max: 1);
    animation = CurvedAnimation(
      parent: controller!,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FadeTransition(
          opacity: animation!,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        Text("FadeTransition",
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(
          height: 20,
        ),
        SizeTransition(
          sizeFactor: animation!,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        Text("SizeTransition",
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(
          height: 20,
        ),
        ScaleTransition(
          scale: animation!,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        Text("ScaleTransition",
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(
          height: 20,
        ),
        RotationTransition(
          turns: animation!,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        Text("RotationTransition",
            style: Theme.of(context).textTheme.headlineSmall),
      ],
    );
  }
}
