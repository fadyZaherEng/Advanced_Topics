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
        child: RatingBar.builder(
          initialRating: 3,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 20,
          ignoreGestures: true,
          wrapAlignment: WrapAlignment.center,
          glowRadius: 0.6,
          itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
          itemBuilder: (context, _) => SvgPicture.asset(
            ImagePaths.icRecentAdded,
            fit: BoxFit.scaleDown,
          ),
          onRatingUpdate: (rating) {},
        ),
      ),
    );
  }
}
