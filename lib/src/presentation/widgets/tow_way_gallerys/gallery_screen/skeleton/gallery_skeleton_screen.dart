import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/generated/l10n.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/build_app_bar_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/tow_way_gallerys/gallery_screen/skeleton/gallery_skeleton_item_widget.dart';

class GallerySkeletonScreen extends StatefulWidget {
  const GallerySkeletonScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<GallerySkeletonScreen> createState() => _GallerySkeletonScreenState();
}

class _GallerySkeletonScreenState extends State<GallerySkeletonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWidget(
        context,
        title: "gallery",
        isHaveBackButton: true,
        onBackButtonPressed: () {},
      ),
      body: Column(
        children: [
          Container(
            height: 3,
            color: ColorSchemes.border,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return const GallerySkeletonItemWidget();
                }),
          )
        ],
      ),
    );
  }
}
