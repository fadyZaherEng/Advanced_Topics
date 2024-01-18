import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/animatios_widget/custom_explicit_animation/custom_explicit_animated_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/animatios_widget/custom_explicit_animation/custom_explicit_animation_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/animatios_widget/explicit_animation/defult_text_style_transition_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/animatios_widget/explicit_animation/rotation_scale_size_fade_transition_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/animatios_widget/explicit_animation/slide_decoration_align_transition_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/animatios_widget/impliced_animation/animated_container_opacity_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/animatios_widget/impliced_animation/animated_default_text_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/animatios_widget/impliced_animation/animated_padding_align_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/animatios_widget/impliced_animation/animated_positioned.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/animatios_widget/impliced_animation/tween_animation_widget.dart';

class AnimationWidgets extends StatefulWidget {
  const AnimationWidgets({super.key});

  @override
  State<AnimationWidgets> createState() => _AnimationWidgetsState();
}

class _AnimationWidgetsState extends State<AnimationWidgets> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(height: 50),
              // FadeInImageWidget(),
              SizedBox(height: 50),
              CustomAnimatedWidget(),
              SizedBox(height: 50),
              CustomExplicitAnimation(),
              SizedBox(height: 100),
              DefualtTextStyleTransitionWidget(),
              SizedBox(height: 100),
              AlignSlideDecorationTransitionWidget(),
              SizedBox(height: 100),
              RotationSizeScaleFadeTransitionWidget(),
              SizedBox(height: 100),
              AnimatedContainerScreen(),
              SizedBox(height: 100),
              AnimatedDefaultTextWidget(),
              SizedBox(height: 100),
              AnimatedPaddingAlignWidget(),
              SizedBox(height: 100),
              AnimatedPositionedWidget(),
              SizedBox(height: 100),
              TweenAnimationWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
