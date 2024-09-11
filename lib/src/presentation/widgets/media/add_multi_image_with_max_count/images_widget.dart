import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/generated/l10n.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageWidgets extends StatelessWidget {
  final List<File> images;
  final int imagesMaxNumber;
  final int? imagesMinNumber;
  final String? title;
  final Function(int index) onClearImageTap;
  final Function(int index) onTapImage;
  final Function() onAddImageTap;
  final bool isNeverHide;
  final String errorMessages;
  bool isRequired;
  final GlobalKey? globalKey;

  ImageWidgets({
    Key? key,
    required this.images,
    required this.imagesMaxNumber,
    this.imagesMinNumber,
    required this.onClearImageTap,
    required this.onAddImageTap,
    required this.onTapImage,
    this.errorMessages = "",
    this.title,
    this.globalKey,
    this.isNeverHide = false,
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: showWidget(),
      child: Container(
        key: globalKey,
        height: (isRequired && (images.isEmpty || checkMinImagesRequired()))
            ? 180
            : 150,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isNeverHide
                ? Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      title ?? "",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: ColorSchemes.black,
                            letterSpacing: -0.24,
                          ),
                    ),
                  )
                : Text(
                    "Images",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: ColorSchemes.black,
                          letterSpacing: -0.24,
                        ),
                  ),
            const SizedBox(
              height: 26,
            ),
            Expanded(
              child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  itemBuilder: (context, index) {
                    return index == images.length
                        ? Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Visibility(
                                visible: images.length < imagesMaxNumber,
                                child: InkWell(
                                  onTap: () {
                                    onAddImageTap();
                                  },
                                  child: Container(
                                    width: 84,
                                    height: 84,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: ColorSchemes.white,
                                      border: Border.all(
                                        width: 1,
                                        color: ColorSchemes.primary,
                                      ),
                                    ),
                                    child: Center(
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: ColorSchemes.white,
                                          border: Border.all(
                                            width: 1.5,
                                            color: ColorSchemes.primary,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        child: SvgPicture.asset(
                                          ImagePaths.add,
                                          fit: BoxFit.scaleDown,
                                          color: ColorSchemes.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Stack(
                            clipBehavior: Clip.none,
                            children: [
                              InkWell(
                                onTap: () {
                                  onTapImage(index);
                                },
                                child: Container(
                                  width: 84,
                                  height: 84,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Image(
                                    image: FileImage(images[index]),
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: ColorSchemes.primary,
                                        ),
                                      );
                                    },
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned.directional(
                                textDirection: Directionality.of(context),
                                start: 6,
                                top: -10,
                                child: InkWell(
                                  onTap: () {
                                    onClearImageTap(index);
                                  },
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: const BoxDecoration(
                                      color: ColorSchemes.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgPicture.asset(
                                      ImagePaths.close,
                                      fit: BoxFit.scaleDown,
                                      color: ColorSchemes.gray,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 16,
                    );
                  },
                  itemCount: images.length + 1),
            ),
            SizedBox(
              height: isNeverHide ? 0 : 16,
            ),
            Container(
              height: isNeverHide ? 0 : 1,
              color: ColorSchemes.border,
            ),
            SizedBox(
              height: isNeverHide ? 8 : 16,
            ),
            Visibility(
              visible:
                  (isRequired && (images.isEmpty || checkMinImagesRequired())),
              child: Text(
                errorMessages == ""
                    ? "${"youCanUploadAMinimumOf"} $imagesMinNumber ${"imageAndAMaximumOf"} $imagesMaxNumber ${"image"}"
                    : errorMessages,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: ColorSchemes.redError),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool checkMinImagesRequired() {
    if (imagesMinNumber == null) {
      return false;
    } else if (images.length < imagesMinNumber!) {
      return true;
    } else {
      return false;
    }
  }

  bool showWidget() {
    if (isNeverHide) {
      return true;
    } else if (images.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
