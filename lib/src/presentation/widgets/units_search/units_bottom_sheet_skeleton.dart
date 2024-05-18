import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:skeletons/skeletons.dart';

class UnitsBottomSheetSkeleton extends StatelessWidget {
  const UnitsBottomSheetSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        SkeletonLine(
          style: SkeletonLineStyle(
            height: 55,
            width: MediaQuery.of(context).size.width,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.only(top: 16),
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: SkeletonLine(
                          style: SkeletonLineStyle(
                            height: 16,
                            width: 60,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        )),
                        const SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: 24,
                            height: 24,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: Container(
                        width: double.infinity,
                        height: 1,
                        color: ColorSchemes.lightGray,
                      ),
                    )
                  ],
                );
              }),
        ),
        Row(
          children: [
            Expanded(
                child: SkeletonLine(
              style: SkeletonLineStyle(
                height: 48,
                borderRadius: BorderRadius.circular(12),
              ),
            )),
            const SizedBox(width: 16),
            Expanded(
              child: SkeletonLine(
                style: SkeletonLineStyle(
                  height: 48,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
