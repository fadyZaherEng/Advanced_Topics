import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:skeletons/skeletons.dart';

class CustomImageBuilder extends StatelessWidget {
  const CustomImageBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 250,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40),
              ),
            ),
            child: Image.network(
              "imageUrl",
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  ImagePaths.imagePlaceHolder,
                  fit: BoxFit.cover,
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                    borderRadius: BorderRadius.circular(12.0),
                  )),
                );
              },
            ),
          ),
          Container(
            height: 250,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3), // Shadow color
                  spreadRadius: 2, // Spread radius of the shadow
                  blurRadius: 4, // Blur radius of the shadow
                  offset: const Offset(0, 2), // Offset of the shadow
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
