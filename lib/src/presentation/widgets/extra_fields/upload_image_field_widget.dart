import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/route/routes_manager.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/dynamic_questions/bloc_dynamic_questions/dynamic_questions_event.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/tow_way_gallerys/gallery_screen/widgets/gallery_content_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/tow_way_gallerys/gallery_screen/widgets/gallery_images_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletons/skeletons.dart';

class UploadImageFieldWidget extends StatefulWidget {
  final PageField pageField;
  final Function() showUploadImageBottomSheet;
  final Function() showDialogToDeleteImage;
  final double verticalPadding;
  final double horizontalPadding;
  final bool showSeparator;
  final bool isNetworkImage;

  const UploadImageFieldWidget({
    Key? key,
    required this.pageField,
    required this.showUploadImageBottomSheet,
    required this.showDialogToDeleteImage,
    this.verticalPadding = 16,
    this.horizontalPadding = 16,
    this.showSeparator = true,
    this.isNetworkImage = false,
  }) : super(key: key);

  @override
  State<UploadImageFieldWidget> createState() => _UploadImageFieldWidgetState();
}

class _UploadImageFieldWidgetState extends State<UploadImageFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      key: widget.pageField.key,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: widget.verticalPadding,
            horizontal: widget.horizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.pageField.label ?? "",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: ColorSchemes.black),
              ),
              const SizedBox(height: 16.0),
              widget.pageField.value.isEmpty
                  ? GestureDetector(
                      onTap: () {
                        widget.showUploadImageBottomSheet();
                      },
                      child: DottedBorder(
                        color: widget.pageField.notAnswered &&
                                widget.pageField.isRequired
                            ? ColorSchemes.redError
                            : ColorSchemes.primary,
                        borderType: BorderType.RRect,
                        strokeWidth: 1,
                        radius: const Radius.circular(8),
                        child: SizedBox(
                          height: 130,
                          width: double.infinity,
                          child: Column(
                            children: [
                              const SizedBox(height: 24.0),
                              SvgPicture.asset(
                                ImagePaths.uploadImagePlaceholder,
                              ),
                              const SizedBox(height: 16.0),
                              Text(
                                widget.pageField.description,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: ColorSchemes.gray,
                                        letterSpacing: -0.13),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            _onTapImage();
                          },
                          child: Container(
                            height: 175,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: _buildImage(widget.pageField.isFromServer),
                            ),
                          ),
                        ),
                        Positioned.directional(
                          textDirection: Directionality.of(context),
                          end: 6,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  widget.showDialogToDeleteImage();
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
                              const SizedBox(height: 8),
                              InkWell(
                                onTap: () {
                                  widget.showUploadImageBottomSheet();
                                },
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                    color: ColorSchemes.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(
                                    ImagePaths.edit,
                                    fit: BoxFit.scaleDown,
                                    color: ColorSchemes.gray,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
              const SizedBox(height: 8.0),
              Visibility(
                visible:
                    widget.pageField.notAnswered && widget.pageField.isRequired,
                child: Text(
                  "thisFieldIsRequired",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: ColorSchemes.redError,
                        letterSpacing: -.24,
                      ),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: widget.showSeparator,
          child: const Divider(
            height: 1,
            color: ColorSchemes.gray,
          ),
        ),
      ],
    );
  }

  Image _buildImage(bool isFromServer) {
    return isFromServer
        ? Image.network(
            widget.pageField.value,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                _buildPlaceHolderImage(),
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: SkeletonLine(
                    style: SkeletonLineStyle(
                  width: double.infinity,
                  height: 200,
                  borderRadius: BorderRadius.circular(8),
                )),
              );
            },
          )
        : Image.file(
            File(widget.pageField.value),
            fit: BoxFit.cover,
          );
  }

  Widget _buildPlaceHolderImage() {
    return Image.asset(
      ImagePaths.imagePlaceHolder,
      fit: BoxFit.fill,
    );
  }

  void _onTapImage() {
    Navigator.pushNamed(context, AppRoutes.galleryImagesScreen,
        arguments: GalleryImages(initialIndex: 0, images: [
          GalleryAttachment(attachment: widget.pageField.value),
        ]));
  }
}
