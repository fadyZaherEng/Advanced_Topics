import 'package:flutter/material.dart';

class AlignSlideDecorationTransitionWidget extends StatefulWidget {
  const AlignSlideDecorationTransitionWidget({super.key});

  @override
  State<AlignSlideDecorationTransitionWidget> createState() =>
      _AlignSlideDecorationTransitionWidgetState();
}

class _AlignSlideDecorationTransitionWidgetState
    extends State<AlignSlideDecorationTransitionWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<AlignmentGeometry>? alignAnimation;
  Animation<Offset>? slideAnimation;
  Animation<Decoration>? decorationAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true, min: 0, max: 1);
    //align animation
    alignAnimation = Tween<AlignmentGeometry>(
            begin: Alignment.topLeft, end: Alignment.bottomRight)
        .animate(controller!);
    //slide animation
    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(1, 1),
    ).animate(controller!);
    //decoration animation
    decorationAnimation = DecorationTween(
      begin: BoxDecoration(
        color: Colors.deepPurple,
        border: Border.all(
          color: Colors.black,
          width: 4,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      end: BoxDecoration(
        color: Colors.teal,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        border: Border.all(
          color: Colors.white,
          width: 4,
        ),
      ),
    ).animate(controller!);
  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DecoratedBoxTransition(
          decoration: decorationAnimation!,
          child: const Padding(
            padding: EdgeInsets.all(50.0),
            child: Icon(
              Icons.airplane_ticket,
            ),
          ),
        ),
        Text("DecoratedBoxTransition",
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(
          height: 100,
        ),
        SlideTransition(
          position: slideAnimation!,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        Text("SlideTransition",
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(
          height: 100,
        ),
        AlignTransition(
          alignment: alignAnimation!,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        Text("AlignTransition",
            style: Theme.of(context).textTheme.headlineSmall),
      ],
    );
  }
}
