import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/generated/l10n.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/domain/entities/album/album_class.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/tow_way_gallerys/album/album_images_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletons/skeletons.dart';

class GridAlbumScreen extends StatefulWidget {
  final List<SupportAttachment> images;

  const GridAlbumScreen({
    required this.images,
    super.key,
  });

  @override
  State<GridAlbumScreen> createState() => _GridAlbumScreenState();
}

class _GridAlbumScreenState extends State<GridAlbumScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Grid Gallary"),
        centerTitle: true,
      ),
      body: ImagesWidgetList(
        images: widget.images,
      ),
    );
  }
}

class ImagesWidgetList extends StatefulWidget {
  final List<SupportAttachment> images;

  const ImagesWidgetList({required this.images, super.key});

  @override
  State<ImagesWidgetList> createState() => _ImagesWidgetListState();
}

class _ImagesWidgetListState extends State<ImagesWidgetList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          " S.of(context).images",
          style: Theme
              .of(context)
              .textTheme
              .bodyMedium!
              .copyWith(
              color: ColorSchemes.black, fontSize: 16, letterSpacing: -0.24),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: widget.images.length > 3 ? 200 : 100,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 90, // Set the maximum width for each item
              crossAxisSpacing: 10, // Set the spacing between columns
              mainAxisSpacing: 10, // Set the spacing between rows
              crossAxisCount: 3,
            ),
            itemCount: widget.images.length <= 6 ? widget.images.length : 6,
            // Replace with your desired number of items
            itemBuilder: (BuildContext context, int index) {
              // Replace this with your item widget
              return _image(widget.images[index].pathUrl, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _image(String imageUrl, int index) {
    return GestureDetector(
      onTap: () {
        _onNavigateToAlbumImagesScreenState(
          images: widget.images,
          initialIndex: index,
        );
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  _buildPlaceHolderImage(),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                    maxWidth: double.infinity,
                    width: double.infinity,
                    height: 200.0,
                    maxHeight: 200.0,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                );
              },
            ),
            Visibility(
              visible: widget.images.length > 6 && index == 5,
              child: Container(
                color: Colors.black12,
                child: Center(
                  child: Text(
                    "+${widget.images.length - 6}",
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(
                      color: ColorSchemes.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onNavigateToAlbumImagesScreenState({
    required List<SupportAttachment> images,
    required int initialIndex,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AlbumImageScreen(
              imagesAlbum: ImagesAlbum(
                initialIndex: initialIndex,
                images: images,
              ),
              imageType: ImageType.network,
            ),
      ),
    );
  }

  SvgPicture _buildPlaceHolderImage() {
    return SvgPicture.asset(
      ImagePaths.backArrow,
      fit: BoxFit.fill,
    );
  }
}

enum ImageType {
  file,
  network,
  asset,
}
