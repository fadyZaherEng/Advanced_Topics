import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:skeletons/skeletons.dart';

class GalleryImageWidget extends StatefulWidget {
  final String image;

  const GalleryImageWidget({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  State<GalleryImageWidget> createState() => _GalleryImageWidgetState();
}

class _GalleryImageWidgetState extends State<GalleryImageWidget> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.image,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) {
        return Image.asset(
          ImagePaths.imagePlaceHolder,
          fit: BoxFit.cover,
        );
      },
      placeholder: (context, url) {
        return Center(
          child: SkeletonLine(
              style: SkeletonLineStyle(
                width: double.infinity,
                height: double.infinity,
                borderRadius: BorderRadius.circular(
                  4,
                ),
              )),
        );
      },
    );
  }
}
