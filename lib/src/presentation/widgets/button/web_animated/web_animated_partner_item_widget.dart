import 'package:flutter/material.dart';

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
