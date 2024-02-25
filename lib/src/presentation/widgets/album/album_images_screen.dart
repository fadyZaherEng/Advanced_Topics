import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/base/widget/base_stateful_widget.dart';
import 'package:flutter_advanced_topics/src/domain/entities/album/album_class.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/album/grid_album_screen.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/album/widget/album_custom_indicator_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/album/widget/album_view_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/album/widget/close_image_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/album/widget/show_image_number_widget.dart';

class AlbumImageScreen extends BaseStatefulWidget {
  final ImagesAlbum imagesAlbum;
  final ImageType imageType;
  const AlbumImageScreen({
    Key? key,
    required this.imagesAlbum,
    required this.imageType,
  }) : super(key: key);

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _AlbumImageScreenState();
}

class _AlbumImageScreenState extends BaseState<AlbumImageScreen> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    _currentIndex = widget.imagesAlbum.initialIndex;
    _pageController = PageController(
      initialPage: _currentIndex,
    );
    super.initState();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AlbumViewWidget(
            imagesAlbum: widget.imagesAlbum,
            currentIndex: _currentIndex,
            pageController: _pageController,
            imageType: widget.imageType,
          ),
          const CloseImagesWidget(),
          ShowImageNumberWidget(
            length: widget.imagesAlbum.images.length,
            idx: _currentIndex,
          ),
          AlbumCustomIndicatorWidget(
            imagesAlbum: widget.imagesAlbum,
            pageController: _pageController,
            currentIndex: _currentIndex,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
