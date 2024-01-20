import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class LikeBtnWidget extends StatefulWidget {
  const LikeBtnWidget({super.key});

  @override
  State<LikeBtnWidget> createState() => _LikeBtnWidgetState();
}

class _LikeBtnWidgetState extends State<LikeBtnWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LikeButton(
              size: 60,
              // padding: const EdgeInsets.all(12),
              // bubblesSize: 20,
              // circleSize: 40,
              animationDuration: const Duration(milliseconds: 500),
              circleColor: const CircleColor(
                start: Color(0xff00ddff),
                end: Color(0xff0099ff),
              ),
              bubblesColor: const BubblesColor(
                dotPrimaryColor: Color(0xff33b5e5),
                dotSecondaryColor: Color(0xff0099ff),
              ),
              likeBuilder: (bool isLiked) {
                return Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  size: 50,
                );
              },
              onTap: (bool isLiked) {
                return Future.value(!isLiked);
              },
              likeCount: 10,
            ),
          ],
        ),
      ),
    );
  }
}
