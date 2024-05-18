import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FileBottomSheetWidget extends StatefulWidget {
  final Function() onTapCamera;
  final Function() onTapGallery;
  final Function() onTapFile;

  const FileBottomSheetWidget(
      {super.key,
      required this.onTapCamera,
      required this.onTapGallery,
      required this.onTapFile});

  @override
  State<FileBottomSheetWidget> createState() => _FileBottomSheetWidgetState();
}

class _FileBottomSheetWidgetState extends State<FileBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        InkWell(
          onTap: widget.onTapCamera,
          child: Row(
            children: [
              SvgPicture.asset(
                ImagePaths.cameraTwo,
                fit: BoxFit.scaleDown,
              ),
              const SizedBox(width: 10),
              Text(
                "S.of(context).camera",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: ColorSchemes.black,
                    ),
              )
            ],
          ),
        ),
        const SizedBox(height: 15),
        const Divider(height: 1, color: ColorSchemes.black),
        const SizedBox(height: 15),
        InkWell(
          onTap: widget.onTapGallery,
          child: Row(
            children: [
              SvgPicture.asset(
                ImagePaths.gallery,
                fit: BoxFit.scaleDown,
              ),
              const SizedBox(width: 10),
              Text(
                "S.of(context).gallery",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: ColorSchemes.black,
                    ),
              )
            ],
          ),
        ),
        const SizedBox(height: 15),
        const Divider(height: 1, color: ColorSchemes.black),
        const SizedBox(height: 15),
        InkWell(
          onTap: widget.onTapFile,
          child: Row(
            children: [
              SvgPicture.asset(
                ImagePaths.filePdf,
                fit: BoxFit.scaleDown,
              ),
              const SizedBox(width: 10),
              Text(
                "S.of(context).file",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: ColorSchemes.black,
                    ),
              )
            ],
          ),
        )
      ],
    );
  }
}
