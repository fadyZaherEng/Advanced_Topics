import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';

class AnimatedSwitcherBetweenRowWidget extends StatefulWidget {
  const AnimatedSwitcherBetweenRowWidget({super.key});

  @override
  State<AnimatedSwitcherBetweenRowWidget> createState() =>
      _AnimatedSwitcherBetweenRowWidgetState();
}

class _AnimatedSwitcherBetweenRowWidgetState
    extends State<AnimatedSwitcherBetweenRowWidget> {
  final List<String> _partners = [
    ImagePaths.carParking,
    ImagePaths.imagesApple,
    ImagePaths.imagesDoller,
    ImagePaths.imagesConfirmationEmail,
  ];
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
        const Duration(seconds: 3), (Timer t) => _rearrangePartnersImages());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: Iterable<int>.generate(_partners.length).map((index) {
              return WebAnimatedPartnerItem(
                image: _partners[index],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _rearrangePartnersImages() {
    setState(() {
      _partners.shuffle();
    });
  }
}

class WebAnimatedPartnerItem extends StatefulWidget {
  final String image;

  const WebAnimatedPartnerItem({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  WebAnimatedPartnerItemState createState() => WebAnimatedPartnerItemState();
}

class WebAnimatedPartnerItemState extends State<WebAnimatedPartnerItem> {
  late String _currentImage;

  @override
  void initState() {
    super.initState();
    _currentImage = widget.image;
  }

  @override
  void didUpdateWidget(WebAnimatedPartnerItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.image != oldWidget.image) {
      setState(() {
        _currentImage = widget.image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: Image.network(
                  _currentImage,
                  key: ValueKey<String>(_currentImage),
                  fit: BoxFit.scaleDown,
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.width * 0.15,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      _currentImage,
                      fit: BoxFit.scaleDown,
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: MediaQuery.of(context).size.width * 0.15,
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 24,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
