import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/tow_way_gallerys/gallery_screen/skeleton/gallery_skeleton_images_item_widget.dart';
import 'package:skeletons/skeletons.dart';

class GallerySkeletonItemWidget extends StatefulWidget {
  const GallerySkeletonItemWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<GallerySkeletonItemWidget> createState() =>
      _GallerySkeletonItemWidgetState();
}

class _GallerySkeletonItemWidgetState extends State<GallerySkeletonItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(
            16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        borderRadius: BorderRadius.circular(
                          25,
                        ),
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 11,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonLine(
                          style: SkeletonLineStyle(
                            width: 80,
                            height: 6,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SkeletonLine(
                          style: SkeletonLineStyle(
                            width: 90,
                            height: 6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                    ),
                    child: SkeletonLine(
                      style: SkeletonLineStyle(
                        width: 130,
                        height: 6,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const SkeletonLine(
                style: SkeletonLineStyle(
                  width: 100,
                  height: 6,
                ),
              ),
              const GallerySkeletonImagesWidget()
            ],
          ),
        ),
      ],
    );
  }
}
