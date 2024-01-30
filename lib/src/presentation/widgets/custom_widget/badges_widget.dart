import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BadgesWidget extends StatelessWidget {
  const BadgesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Badges'),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            // Navigator.pushNamed(context, AppRoutes.onBoardingScreen);
          },
          child: badge.Badge(
            badgeContent: SizedBox(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    "+999",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: ColorSchemes.white,
                        fontSize: 12,
                        fontWeight: Constants.fontWeightSemiBold),
                  ),
                ),
              ),
            ),
            badgeAnimation: const badge.BadgeAnimation.scale(
              animationDuration: Duration(seconds: 3),
            ),
            badgeStyle: const badge.BadgeStyle(
              badgeColor: ColorSchemes.primary,
              padding: EdgeInsets.all(2),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            position: badge.BadgePosition.topStart(top: -2, start: 12),
            child: SvgPicture.asset(
              ImagePaths.notification,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }
}
