import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';

class OnBoardingButtonWidget extends StatefulWidget {
  const OnBoardingButtonWidget({super.key});

  @override
  State<OnBoardingButtonWidget> createState() => _OnBoardingButtonWidgetState();
}

class _OnBoardingButtonWidgetState extends State<OnBoardingButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            color: ColorSchemes.buttonOnBoarding,
            borderRadius: BorderRadiusDirectional.all(Radius.circular(12))),
        child: MaterialButton(
          onPressed: () {},
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          height: 50,
          child: Text(
            "Get Started",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: ColorSchemes.whit),
          ),
        ),
      ),
    );
  }
}
