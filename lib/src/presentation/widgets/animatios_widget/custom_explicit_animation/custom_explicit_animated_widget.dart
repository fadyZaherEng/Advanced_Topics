import 'package:flutter/material.dart';

class CustomAnimatedWidget extends StatefulWidget {
  const CustomAnimatedWidget({super.key});

  @override
  State<CustomAnimatedWidget> createState() => _CustomAnimatedWidgetState();
}

AnimationController? animationController;

class ContainerDetails {
  double width;
  double height;
  double borderWidth;

  ContainerDetails(this.width, this.height, this.borderWidth);
}

class _CustomAnimatedWidgetState extends State<CustomAnimatedWidget>
    with SingleTickerProviderStateMixin {
  Animation<ContainerDetails>? _animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        microseconds: 500,
      ),
    );
    _animation = Tween<ContainerDetails>(
      begin: ContainerDetails(0, 0, 0),
      end: ContainerDetails(200, 50, 2),
    ).animate(
      CurvedAnimation(
        parent: animationController!,
        curve: Curves.easeOutBack,
        reverseCurve: Curves.easeOutBack.flipped,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OutlineButtonTransition(
            borderWidth: _animation!,
          ),
        ],
      ),
    );
  }
}

class OutlineButtonTransition extends AnimatedWidget {
  Animation<ContainerDetails> get borderWidth =>
      listenable as Animation<ContainerDetails>;

  const OutlineButtonTransition({super.key, borderWidth})
      : super(listenable: borderWidth);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(
              milliseconds: 500,
            ),
            height: borderWidth.value.height,
            width: borderWidth.value.width,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: borderWidth.value.borderWidth,
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              animationController!.forward();
              Future.delayed(const Duration(
                seconds: 1,
              )).then(
                (value) => animationController!.reverse(),
              );
            },
            child: const Text('Outlined Button'),
          ),
        ],
      ),
    );
  }
}
