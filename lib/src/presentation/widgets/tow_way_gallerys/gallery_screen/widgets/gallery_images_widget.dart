import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/tow_way_gallerys/gallery_screen/widgets/gallery_content_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/tow_way_gallerys/gallery_screen/widgets/gallery_image_widget.dart';

class GalleryImagesWidget extends StatefulWidget {
  final List<GalleryAttachment> images;
  final void Function({
    required int imageIndex,
    required List<GalleryAttachment> images,
  }) onTapImage;

  const GalleryImagesWidget({
    Key? key,
    required this.onTapImage,
    required this.images,
  }) : super(
          key: key,
        );

  @override
  State<GalleryImagesWidget> createState() => _GalleryImagesWidgetState();
}

class _GalleryImagesWidgetState extends State<GalleryImagesWidget> {
  int _countContainsMoreThanSix = 0;
  int _countContainsLessThanSix = 0;
  int _countContainsFour = 0;

  @override
  void initState() {
    _countContainsMoreThanSix = widget.images.length - 6;
    _countContainsLessThanSix = widget.images.length - 3;
    _countContainsFour = widget.images.length - 3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.images.length == 1
          ? 190
          : widget.images.isNotEmpty
              ? widget.images.length <= 5
                  ? 108
                  : 216
              : 0,
      child: widget.images.length == 1
          ? Padding(
              padding: const EdgeInsets.all(15),
              child: GestureDetector(
                onTap: () => _onTapImage(
                  imageIndex: 0,
                  image: widget.images[0],
                ),
                child: Container(
                  width: double.infinity,
                  height: 53,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                    child: GalleryImageWidget(
                      image: widget.images[0].attachment,
                    ),
                  ),
                ),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              itemCount: (widget.images.length >= 3 && widget.images.length < 6)
                  ? 3
                  : widget.images.length >= 6
                      ? 6
                      : widget.images.length,
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.images.length <= 5 ? 1 : 2,
                mainAxisExtent: 130,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16, right: 8, left: 8),
                  child: GestureDetector(
                    onTap: () {
                      _onTapImage(
                        imageIndex: index,
                        image: widget.images[index],
                      );
                    },
                    child: Container(
                      width: 150,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          8,
                        ),
                        child: widget.images.length <= 3
                            ? GalleryImageWidget(
                                image: widget.images[index].attachment,
                              )
                            : Stack(
                                fit: StackFit.expand,
                                children: [
                                  GalleryImageWidget(
                                    image: widget.images[index].attachment,
                                  ),
                                  index == 5
                                      ? _countWidget(
                                          _countContainsMoreThanSix,
                                        )
                                      : widget.images.length == 5 && index == 2
                                          ? _countWidget(
                                              _countContainsLessThanSix,
                                            )
                                          : widget.images.length == 4 &&
                                                  index == 2
                                              ? _countWidget(
                                                  _countContainsFour,
                                                )
                                              : const SizedBox(),
                                ],
                              ),
                      ),
                    ),
                  ),
                );
              }),
    );
  }

  void _onTapImage({
    required int imageIndex,
    required GalleryAttachment image,
  }) {
    widget.onTapImage(
      imageIndex: imageIndex,
      images: widget.images,
    );
  }

  Widget _countWidget(
    int count,
  ) {
    return Stack(children: [
      Container(
        height: 150,
        decoration: BoxDecoration(
          color: ColorSchemes.backButtonBorderGray,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(
                0.4,
              ),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(
                0,
                2,
              ),
            ),
          ],
        ),
      ),
      Center(
        child: Text(
          "+$count",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: ColorSchemes.white,
              ),
        ),
      ),
    ]);
  }
}
