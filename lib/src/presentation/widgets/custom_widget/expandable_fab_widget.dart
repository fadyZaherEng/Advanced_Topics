
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'dart:math' as math;

import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/circular_icon.dart';

class ExpandableFabWidget extends StatefulWidget {
  final List<Widget> children;

  const ExpandableFabWidget({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  ExpandableFabWidgetState createState() => ExpandableFabWidgetState();
}

class ExpandableFabWidgetState extends State<ExpandableFabWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        value: _open ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 250),
        vsync: this);

    _expandAnimation = CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
        reverseCurve: Curves.easeOutQuad);
  }

  @override
  void didUpdateWidget(ExpandableFabWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_open) {
      _tapToClose();
      setState(() {
        _open = false;
        _controller.reverse();
      });
    }
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          _tapToClose(),
          ..._buildExpandableFabButton(),
          _tapToOpen(),
        ],
      ),
    );
  }

  Widget _tapToClose() {
    return InkWell(
      onTap: _toggle,
      child: CircularIcon(
        iconSize: 24,
        backgroundColor: ColorSchemes.iconBackGround,
        boxShadows:  [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 40,
            color: ColorSchemes.lightGray,
            spreadRadius: 0,
          ),
        ],
        imagePath: ImagePaths.fabClose,
        // borderWidth: 1,
        // borderColor: ColorSchemes.primary,
        // iconColor: null,
      ),
    );
  }

  Widget _tapToOpen() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      transformAlignment: Alignment.center,
      transform: Matrix4.diagonal3Values(_open ? 0.7 : 1.0, _open ? 0.7 : 1.0, 1.0),
      curve: Curves.easeOut,
      child: AnimatedOpacity(
        opacity: _open ? 0.0 : 1.0,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 250),
        child: InkWell(
          onTap: _toggle,
          child: CircularIcon(
            iconSize: 24,
            backgroundColor: ColorSchemes.iconBackGround,
            boxShadows: const [
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 32,
                color: Color.fromRGBO(34, 34, 34, 0.32),
                spreadRadius: 0,
              ),
            ],
            imagePath: ImagePaths.socialMedia,
            // borderWidth: 1,
            // borderColor: ColorSchemes.primary,
            // iconColor: null,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandableFabButton() {
    final List<Widget> children = <Widget>[];
    final count = widget.children.length;

    for (var i = 0, angleInDegrees = 60.0;
        i < count;
        i++, angleInDegrees += 60) {
      children.add(_ExpandableFab(
        directionDegrees: 0,
        maxDistance: angleInDegrees,
        progress: _expandAnimation,
        child: widget.children[i],
      ));
    }

    return children;
  }
}

class _ExpandableFab extends StatelessWidget {
  const _ExpandableFab({
    Key? key,
    required this.directionDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  }) : super(key: key);

  final double directionDegrees;
  final double maxDistance;
  final Animation<double>? progress;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress!,
      builder: (context, child) {
        final offset = Offset.fromDirection(
            directionDegrees * (math.pi / 180), progress!.value * maxDistance);
        return Positioned.directional(
          end: offset.dx,
          // bottom:  offset.dy,
          textDirection: Directionality.of(context),
          child: Transform.rotate(
            angle: (1.0 - progress!.value) * math.pi / 2,
            child: child,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress!,
        child: child,
      ),
    );
  }
}
