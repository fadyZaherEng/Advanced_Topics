import 'package:flutter/cupertino.dart';

class FadeInImageWidget extends StatefulWidget {
  const FadeInImageWidget({super.key});

  @override
  State<FadeInImageWidget> createState() => _FadeInImageWidgetState();
}

class _FadeInImageWidgetState extends State<FadeInImageWidget> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FadeInImage(
          placeholder: NetworkImage(
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
          ),
          image: NetworkImage(
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
          ),
          height: 200,
          width: 200,
          fit: BoxFit.cover,
        )
      ],
    );
  }
}
