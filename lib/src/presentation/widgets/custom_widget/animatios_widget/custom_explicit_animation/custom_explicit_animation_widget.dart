import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomExplicitAnimation extends StatefulWidget {
  const CustomExplicitAnimation({super.key});

  @override
  State<CustomExplicitAnimation> createState() =>
      _CustomExplicitAnimationState();
}

class _CustomExplicitAnimationState extends State<CustomExplicitAnimation>
    with SingleTickerProviderStateMixin {
  //to generate animation custom to any filed need and not font in animation transition
  Animation<Size>? _animation;
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    )..repeat();
    _animation = Tween<Size>(
      begin: const Size(50, 50),
      end: const Size(100, 100),
    ).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _animation!,
          builder: (context, child) => Column(
            children: [
              Container(
                  width: _animation!.value.width,
                  height: _animation!.value.height,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15),
                  )),
              const Text(
                'Custom Explicit Animation',
              ),
            ],
          ),
        ),
        ListTile(
          leading: TextButton(
            onPressed: () => _animationController!.reverse(),
            child: const Text(
              'Increase Font Size',
            ),
          ),
          trailing: const Icon(
            CupertinoIcons.plus,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ListTile(
          leading: TextButton(
            onPressed: () => _animationController!.forward(),
            child: const Text(
              'Decrease Font Size',
            ),
          ),
          trailing: const Icon(
            CupertinoIcons.minus,
          ),
        ),
        const SizedBox(
          height: 100,
        )
      ],
    );
  }
}
