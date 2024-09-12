// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

class PageFadeTransition extends PageRouteBuilder {
  final dynamic page;

  PageFadeTransition(this.page)
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var _animation = Tween<double>(begin: 0, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.bounceInOut));

            var _animation2 = Tween<double>(begin: 0, end: 2.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.decelerate));

            return ScaleTransition(
              scale: _animation,
              child: RotationTransition(turns: _animation2, child: child),
            );
            // return Align(
            //   alignment: Alignment.center,
            //   child:SizeTransition(
            //     sizeFactor: animation,
            //     child: FadeTransition(
            //       opacity: animation,
            //       child: child,
            //     )
            //   )
            // child: SlideTransition(
            //   position: Tween<Offset>(
            //     begin: const Offset(0.0, 1.0),
            //     end: Offset.zero,
            //   ).animate(animation),
            //   child: child,
            // ),
            // child: RotationTransition(
            //   turns: animation,
            //   child: child,
            // ),
            //child: FadeTransition(opacity: animation, child: child),
            // );
          },
        );
}
