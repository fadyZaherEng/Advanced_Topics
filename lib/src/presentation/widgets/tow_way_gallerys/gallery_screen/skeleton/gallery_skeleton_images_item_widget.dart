import 'package:flutter/widgets.dart';
import 'package:skeletons/skeletons.dart';

class GallerySkeletonImagesWidget extends StatefulWidget {
  const GallerySkeletonImagesWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<GallerySkeletonImagesWidget> createState() =>
      _GallerySkeletonImagesWidgetState();
}

class _GallerySkeletonImagesWidgetState
    extends State<GallerySkeletonImagesWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16,
          bottom: 16,
        ),
        child: GridView.builder(
            padding: EdgeInsets.zero,
            itemCount: 6,
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 130,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  right: 16,
                ),
                child: Container(
                    width: 150,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                      child: const SkeletonLine(
                          style: SkeletonLineStyle(
                        height: 156,
                        width: 165,
                      )),
                    )),
              );
            }),
      ),
    );
  }
}
