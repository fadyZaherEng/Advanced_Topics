import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/skeleton/skeleton_item_widget.dart';

class SkeletonRowWidget extends StatelessWidget {
  const SkeletonRowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsetsDirectional.only(
        start: 16,
        end: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonItemWidget(),
          SkeletonItemWidget(),
        ],
      ),
    );
  }
}
