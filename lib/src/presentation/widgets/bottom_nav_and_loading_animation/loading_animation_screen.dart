import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingAnimationScreen extends StatelessWidget {
  const LoadingAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LoadingAnimationWidget.threeArchedCircle(
                    color: ColorSchemes.primary,
                    size: 50,
                  ),
                  LoadingAnimationWidget.inkDrop(
                      color: ColorSchemes.primary, size: 50),
                  LoadingAnimationWidget.waveDots(
                      color: ColorSchemes.primary, size: 50),
                  LoadingAnimationWidget.threeArchedCircle(
                      color: ColorSchemes.primary, size: 50),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LoadingAnimationWidget.twistingDots(
                      leftDotColor: ColorSchemes.primary,
                      rightDotColor: ColorSchemes.primary,
                      size: 50),
                  LoadingAnimationWidget.staggeredDotsWave(
                      color: ColorSchemes.primary, size: 50),
                  LoadingAnimationWidget.fourRotatingDots(
                      color: ColorSchemes.primary, size: 50),
                  LoadingAnimationWidget.beat(
                      color: ColorSchemes.primary, size: 50),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LoadingAnimationWidget.dotsTriangle(
                      color: ColorSchemes.primary, size: 50),
                  LoadingAnimationWidget.threeRotatingDots(
                      color: ColorSchemes.primary, size: 50),
                  LoadingAnimationWidget.bouncingBall(
                      color: ColorSchemes.primary, size: 50),
                  LoadingAnimationWidget.discreteCircle(
                      color: ColorSchemes.primary, size: 50),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LoadingAnimationWidget.fallingDot(
                      color: ColorSchemes.primary, size: 50),
                  LoadingAnimationWidget.flickr(
                      leftDotColor: ColorSchemes.primary,
                      rightDotColor: ColorSchemes.primary,
                      size: 50),
                  LoadingAnimationWidget.halfTriangleDot(
                      color: ColorSchemes.primary, size: 50),
                  LoadingAnimationWidget.horizontalRotatingDots(
                      color: ColorSchemes.primary, size: 50),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LoadingAnimationWidget.hexagonDots(
                      color: ColorSchemes.primary, size: 50),
                  LoadingAnimationWidget.discreteCircle(
                      color: ColorSchemes.primary, size: 50),
                  LoadingAnimationWidget.newtonCradle(
                      color: ColorSchemes.primary, size: 50),
                  LoadingAnimationWidget.prograssiveDots(
                      color: ColorSchemes.primary, size: 50),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LoadingAnimationWidget.stretchedDots(
                      color: ColorSchemes.primary, size: 50),
                  const SizedBox(
                    width: 10,
                  ),
                  LoadingAnimationWidget.staggeredDotsWave(
                      color: ColorSchemes.primary, size: 50),
                  const SizedBox(
                    width: 10,
                  ),
                  LoadingAnimationWidget.flickr(
                      leftDotColor: ColorSchemes.primary,
                      rightDotColor: ColorSchemes.primary,
                      size: 50),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
