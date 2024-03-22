import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/build_app_bar_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/tow_way_gallerys/gallery_screen/widgets/gallery_item_widget.dart';

class GalleryContentWidget extends StatefulWidget {
  final List<Gallery> gallery;
  final Function() onBackButtonPressed;
  final void Function({
    required int imageIndex,
    required List<GalleryAttachment> images,
  }) onTapImage;
  final Function() onPullToRefresh;

  const GalleryContentWidget({
    Key? key,
    required this.onBackButtonPressed,
    required this.gallery,
    required this.onTapImage,
    required this.onPullToRefresh,
  }) : super(key: key);

  @override
  State<GalleryContentWidget> createState() => _GalleryContentWidgetState();
}

class GalleryAttachment {
  final String attachment;
  const GalleryAttachment({
    required this.attachment,
  });
}

class Gallery {
  final List<GalleryAttachment> galleryAttachments;
  final String title;
  final String mainImage;
  final String galleryDate;
  final String description;
  final String createdBy;
  const Gallery({
    required this.galleryAttachments,
    required this.title,
    required this.mainImage,
    required this.galleryDate,
    required this.description,
    required this.createdBy,
  });
}

class _GalleryContentWidgetState extends State<GalleryContentWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWidget(
        context,
        title: "Gallery",
        isHaveBackButton: true,
        onBackButtonPressed: widget.onBackButtonPressed,
      ),
      body: Column(
        children: [
          Container(
            height: 3,
            color: ColorSchemes.border,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => widget.onPullToRefresh(),
              child: ListView.builder(
                  itemCount: widget.gallery.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GalleryItemWidget(
                      gallery: widget.gallery[index],
                      isLastItem:
                          index == widget.gallery.length - 1 ? true : false,
                      onTapImage: ({
                        required int imageIndex,
                        required List<GalleryAttachment> images,
                      }) {
                        widget.onTapImage(
                          imageIndex: imageIndex,
                          images: images,
                        );
                      },
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
