import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonEventsCardWidget extends StatelessWidget {
  const SkeletonEventsCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: ColorSchemes.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: const [
              BoxShadow(
                color: ColorSchemes.lightGray,
                blurRadius: 32,
                offset: (Offset(0, 4)),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 10,
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),
                ),
              ),
              _defaultSize(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                          height: 24,
                          width: 24,
                          borderRadius: BorderRadius.circular(8),
                          shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 5),
                    const SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 5,
                        width: 50,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 5,
                        width: 100,
                      ),
                    ),
                  ],
                ),
              ),
              _defaultSize(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Divider(
                  color: ColorSchemes.lightGray,
                  height: 1,
                ),
              ),
              _defaultSize(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                          height: 30,
                          width: 80,
                          borderRadius: BorderRadius.circular(8),
                          shape: BoxShape.rectangle),
                    ),
                    const SizedBox(width: 32),
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                          height: 30,
                          width: 80,
                          borderRadius: BorderRadius.circular(8),
                          shape: BoxShape.rectangle),
                    ),
                    const SizedBox(width: 32),
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                          height: 30,
                          width: 80,
                          borderRadius: BorderRadius.circular(8),
                          shape: BoxShape.rectangle),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              )
            ],
          ),
        ),
        const Align(
          alignment: AlignmentDirectional.topEnd,
          child: SkeletonAvatar(
            style: SkeletonAvatarStyle(
                width: 45,
                height: 20,
                borderRadius:
                    BorderRadiusDirectional.only(topEnd: Radius.circular(28)),
                shape: BoxShape.rectangle),
          ),
        )
      ],
    );
  }

  SizedBox _defaultSize() {
    return const SizedBox(height: 13);
  }
}
