import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletons/skeletons.dart';

class BadgeIdentitySkeleton extends StatelessWidget {
  const BadgeIdentitySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Container(
                  height: 180,
                  width: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: ColorSchemes.gray, // color of the border
                      width: 2, // width of the border
                    ),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 8,
                        spreadRadius: 3,
                        color: Color.fromRGBO(0, 0, 0, 0.12),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        width: 145,
                        height: 145,
                        borderRadius: BorderRadius.circular(90),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: 120,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: ColorSchemes.gray,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 20,
                      width: 100,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 60,
                      width: 60,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 240,
                  height: 240,
                  child: Center(
                    child: SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 240,
                        width: 240,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: DottedLine(
                    dashColor: ColorSchemes.primary,
                    dashGapLength: 4,
                    dashLength: 4,
                    lineThickness: 2,
                    direction: Axis.horizontal,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        ImagePaths.unitBadge,
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          "S.of(context).unit",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: ColorSchemes.gray,
                                    letterSpacing: -0.24,
                                  ),
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 20,
                          width: 60,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        ImagePaths.userBadge,
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: SkeletonLine(
                          style: SkeletonLineStyle(
                            height: 20,
                            width: 60,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 20,
                          width: 60,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: SvgPicture.asset(
                    ImagePaths.logo,
                    height: 100,
                    width: 100,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
