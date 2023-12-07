import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/domain/entities/album/album_class.dart';
import 'package:photo_view/photo_view.dart';

class AlbumViewWidget extends StatefulWidget {
  PageController pageController;
  int currentIndex;
  ImagesAlbum imagesAlbum;
  AlbumViewWidget({
    super.key,
    required this.pageController,
    required this.currentIndex,
    required this.imagesAlbum,
  });

  @override
  State<AlbumViewWidget> createState() => _AlbumViewWidgetState();
}

class _AlbumViewWidgetState extends State<AlbumViewWidget> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: widget.pageController,
      itemCount: widget.imagesAlbum.images.length + 1,
      onPageChanged: (index) {
        setState(() {
          if (index == widget.imagesAlbum.images.length) {
            widget.currentIndex = 0;
            widget.pageController.jumpToPage(
              0,
            );
          } else {
            widget.currentIndex = index;
            widget.pageController.jumpToPage(
              index,
            );
          }
        });
      },
      itemBuilder: (BuildContext context, int index) {
        if (index == widget.imagesAlbum.images.length) {
          index = 0;
        }
        return PhotoView(
          imageProvider: NetworkImage(
            widget.imagesAlbum.images[index].pathUrl,
          ),
          initialScale: PhotoViewComputedScale.contained,
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 1.8,
        );
      },
    );
  }
}
