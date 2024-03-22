import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/generated/l10n.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/new/constants.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/tow_way_gallerys/gallery_screen/widgets/gallery_content_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/tow_way_gallerys/gallery_screen/widgets/gallery_images_widget.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';

class GalleryItemWidget extends StatefulWidget {
  final Gallery gallery;
  final bool isLastItem;
  final void Function({
    required int imageIndex,
    required List<GalleryAttachment> images,
  }) onTapImage;

  const GalleryItemWidget({
    Key? key,
    required this.gallery,
    required this.isLastItem,
    required this.onTapImage,
  }) : super(
          key: key,
        );

  @override
  State<GalleryItemWidget> createState() => _GalleryItemWidgetState();
}

class _GalleryItemWidgetState extends State<GalleryItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 38,
                    height: 38,
                    child: ClipOval(
                      child: Image.network(
                        widget.gallery.mainImage,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            ImagePaths.avatarImage,
                            fit: BoxFit.cover,
                          );
                        },
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
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
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 11,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.53,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Text(
                            widget.gallery.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: Constants.fontWeightMedium,
                                      color: ColorSchemes.black,
                                      letterSpacing: -0.24,
                                    ),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text("${"by"} ${widget.gallery.createdBy}",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: ColorSchemes.gray,
                                      letterSpacing: -0.24,
                                    )),
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                      englishNumbers(
                          _converterForDate(widget.gallery.galleryDate)),
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: ColorSchemes.gray,
                            letterSpacing: -0.24,
                          )),
                ],
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.gallery.description,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: ColorSchemes.black,
                      letterSpacing: -0.24,
                    ),
              ),
            ),
            widget.gallery.galleryAttachments.isNotEmpty
                ? GalleryImagesWidget(
                    onTapImage: ({
                      required int imageIndex,
                      required List<GalleryAttachment> images,
                    }) {
                      widget.onTapImage(
                        imageIndex: imageIndex,
                        images: images,
                      );
                    },
                    images: widget.gallery.galleryAttachments,
                  )
                : const SizedBox.shrink(),
          ],
        ),
        widget.isLastItem != true
            ? Padding(
                padding: widget.gallery.galleryAttachments.isNotEmpty
                    ? const EdgeInsets.only(top: 16)
                    : EdgeInsets.zero,
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: ColorSchemes.lightGray,
                ),
              )
            : const SizedBox.shrink()
      ],
    );
  }

  String _converterForDate(String date) {
    final DateTime dateTime = DateTime.parse(date);
    final newDateForMonthAndDay = DateFormat('d MMM').format(dateTime);
    final time = DateFormat.jm().format(dateTime);
    return '$newDateForMonthAndDay - $time';
  }

  String englishNumbers(String input) {
    Map<String, String> arabicToEnglish = {
      '٠': '0',
      '١': '1',
      '٢': '2',
      '٣': '3',
      '٤': '4',
      '٥': '5',
      '٦': '6',
      '٧': '7',
      '٨': '8',
      '٩': '9',
    };

    String output = '';

    for (int i = 0; i < input.length; i++) {
      String char = input[i];
      if (arabicToEnglish.containsKey(char)) {
        output += arabicToEnglish[char]!;
      } else {
        output += char;
      }
    }

    return output;
  }
}
