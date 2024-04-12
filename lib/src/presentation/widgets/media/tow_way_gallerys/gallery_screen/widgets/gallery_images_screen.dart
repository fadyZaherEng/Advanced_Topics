import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/tow_way_gallerys/gallery_screen/widgets/gallery_content_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:skeletons/skeletons.dart';

class GalleryImagesScreen extends StatefulWidget {
  final GalleryImages imagesScreen;

  const GalleryImagesScreen({
    Key? key,
    required this.imagesScreen,
  }) : super(key: key);

  @override
  State<GalleryImagesScreen> createState() => _GalleryImagesScreenState();
}

class GalleryImages {
  final List<GalleryAttachment> images;
  final int initialIndex;
  const GalleryImages({
    required this.images,
    required this.initialIndex,
  });
}

class _GalleryImagesScreenState extends State<GalleryImagesScreen> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    _currentIndex = widget.imagesScreen.initialIndex;
    _pageController = PageController(
      initialPage: _currentIndex,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.imagesScreen.images.length + 1,
            onPageChanged: (index) {
              setState(() {
                if (index == widget.imagesScreen.images.length) {
                  _currentIndex = 0;
                  _pageController.jumpToPage(
                    0,
                  );
                } else {
                  _currentIndex = index;
                  _pageController.jumpToPage(
                    index,
                  );
                }
              });
            },
            itemBuilder: (BuildContext context, int index) {
              if (index == widget.imagesScreen.images.length) {
                index = 0;
              }
              return isUrl(widget.imagesScreen.images[index].attachment)
                  ? PhotoView(
                      imageProvider: NetworkImage(
                        widget.imagesScreen.images[index].attachment,
                      ),
                      initialScale: PhotoViewComputedScale.contained,
                      minScale: PhotoViewComputedScale.contained * 0.8,
                      maxScale: PhotoViewComputedScale.covered * 1.8,
                      loadingBuilder: (context, event) => Center(
                        child: SkeletonLine(
                            style: SkeletonLineStyle(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                        )),
                      ),
                    )
                  : Image.file(
                      File(widget.imagesScreen.images[index].attachment),
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Image.asset(
                            ImagePaths.imagePlaceHolder,
                            fit: BoxFit.fill,
                          ),
                        );
                      },
                    );
            },
          ),
          Positioned(
            top: 50,
            left: 20,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.withOpacity(0.5),
                ),
                child: SvgPicture.asset(
                  height: 20,
                  width: 20,
                  ImagePaths.close,
                  color: ColorSchemes.white,
                ),
              ),
            ),
          ),
          Visibility(
            visible: widget.imagesScreen.images.length > 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 25,
                      width: 45,
                      color: ColorSchemes.primary,
                      child: Center(
                        child: Text(
                          "${_currentIndex + 1}/${widget.imagesScreen.images.length}",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: ColorSchemes.white,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 1,
            right: 1,
            bottom: 50,
            child: widget.imagesScreen.images.length != 1
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.imagesScreen.images.asMap().entries.map((
                      entry,
                    ) {
                      int index = entry.key;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentIndex = index;
                            _pageController.jumpToPage(
                              index,
                            );
                          });
                        },
                        child: Container(
                          width: 10.0,
                          height: 10.0,
                          margin: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 2,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == index
                                ? ColorSchemes.white
                                : ColorSchemes.gray,
                          ),
                        ),
                      );
                    }).toList(),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  bool isUrl(String url) {
    if (url.startsWith("http") || url.startsWith("https")) {
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
