import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonItemWidget extends StatelessWidget {
  const SkeletonItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SkeletonItem(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                    shape: BoxShape.circle, width: 15, height: 15),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonLine(
                    style: SkeletonLineStyle(
                        height: 7, width: 100, maxLength: double.infinity,),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                        height: 7, width: 100, maxLength: double.infinity),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
