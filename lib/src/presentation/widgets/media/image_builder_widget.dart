import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletons/skeletons.dart';

class CustomImageBuilderWidget extends StatelessWidget {
  const CustomImageBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          "user.image " ?? "",
          fit: BoxFit.fill,
          matchTextDirection: true,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) =>
              wasSynchronouslyLoaded
                  ? child
                  : Container(
                      clipBehavior: Clip.antiAlias,
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorSchemes.primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        clipBehavior: Clip.antiAlias,
                        child: SvgPicture.asset(
                          ImagePaths.profile,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
          errorBuilder: (context, error, stackTrace) => Container(
            clipBehavior: Clip.antiAlias,
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorSchemes.primary,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              clipBehavior: Clip.antiAlias,
              child: SvgPicture.asset(
                ImagePaths.profile,
                fit: BoxFit.fill,
              ),
            ),
          ),
          loadingBuilder: (context, child, loadingProgress) =>
              loadingProgress == null
                  ? child
                  : Container(
                      clipBehavior: Clip.antiAlias,
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: ColorSchemes.gray,
                        border: Border.all(
                          color: ColorSchemes.primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        clipBehavior: Clip.antiAlias,
                        child: SkeletonLine(
                          style: SkeletonLineStyle(
                            width: 48,
                            height: 48,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
        ),
        CachedNetworkImage(
          imageUrl: "user.image" ?? "",
          matchTextDirection: true,
          fit: BoxFit.fill,
          imageBuilder: (context, imageProvider) {
            return Container(
              clipBehavior: Clip.antiAlias,
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorSchemes.primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                clipBehavior: Clip.antiAlias,
                child: Image(image: imageProvider, fit: BoxFit.fill),
              ),
            );
          },
          placeholder: (context, url) => Container(
            clipBehavior: Clip.antiAlias,
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorSchemes.primary,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              clipBehavior: Clip.antiAlias,
              child: SvgPicture.asset(
                ImagePaths.profile,
                fit: BoxFit.fill,
              ),
            ),
          ),
          errorWidget: (context, _, object) => Container(
            clipBehavior: Clip.antiAlias,
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorSchemes.primary,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              clipBehavior: Clip.antiAlias,
              child: SvgPicture.asset(
                ImagePaths.profile,
                fit: BoxFit.fill,
              ),
            ),
          ),
          progressIndicatorBuilder: (ctx, string, progressLoading) => Container(
            clipBehavior: Clip.antiAlias,
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: ColorSchemes.gray,
              border: Border.all(
                color: ColorSchemes.primary,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              clipBehavior: Clip.antiAlias,
              child: SkeletonLine(
                style: SkeletonLineStyle(
                  width: 48,
                  height: 48,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
