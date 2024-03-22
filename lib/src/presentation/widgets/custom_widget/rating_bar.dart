import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RatingBarWidget extends StatelessWidget {
  const RatingBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rating Bar'),
      ),
      body: Center(
        child:  RatingBar.builder(
          initialRating: 3,
          minRating: 1,
          direction: Axis.horizontal,
          itemPadding: const EdgeInsets.symmetric(
              horizontal: 2, vertical: 0),
          itemCount: 5,
          itemSize: 12,
          ignoreGestures: true,
          allowHalfRating: false,
          itemBuilder: (context, index) {
            if (index < 3) {
              return SvgPicture.asset(
                ImagePaths.ratingStarYellow,
                width: 8,
                height: 8,
                fit: BoxFit.scaleDown,
              );
            } else {
              return SvgPicture.asset(
                ImagePaths.ratingStarGrey,
                width: 8,
                height: 8,
                fit: BoxFit.scaleDown,
              );
            }
          },
          onRatingUpdate: (rating) {},
        ),
      ),
    );
  }
}
