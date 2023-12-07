// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/domain/entities/album/album_class.dart';

class AlbumCustomIndicatorWidget extends StatefulWidget {
  final ImagesAlbum imagesAlbum;
  int currentIndex;
  PageController pageController;

  AlbumCustomIndicatorWidget({
    super.key,
    required this.imagesAlbum,
    required this.pageController,
    required this.currentIndex,
  });

  @override
  State<AlbumCustomIndicatorWidget> createState() =>
      _AlbumCustomIndicatorWidgetState();
}

class _AlbumCustomIndicatorWidgetState
    extends State<AlbumCustomIndicatorWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 1,
      right: 1,
      bottom: 50,
      child: widget.imagesAlbum.images.length != 1
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.imagesAlbum.images.asMap().entries.map((
                entry,
              ) {
                int index = entry.key;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.currentIndex = index;
                      widget.pageController.jumpToPage(
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
                      color: widget.currentIndex == index
                          ? ColorSchemes.primary
                          : ColorSchemes.gray,
                    ),
                  ),
                );
              }).toList(),
            )
          : const SizedBox(),
    );
  }
}
