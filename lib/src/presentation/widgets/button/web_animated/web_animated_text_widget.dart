import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';

class WebAnimatedTextWidget extends StatefulWidget {
  final String text;
  final Color normalTextColor;
  final Color animateTextColor;
  final double normalTextSize;
  final double animateTextSize;
  final Function() onTap;

  const WebAnimatedTextWidget({
    super.key,
    required this.text,
    this.normalTextColor = ColorSchemes.black,
    this.animateTextColor = ColorSchemes.black,
    this.normalTextSize = 16,
    this.animateTextSize = 16,
    required this.onTap,
  });

  @override
  State<WebAnimatedTextWidget> createState() => _WebAnimatedTextWidgetState();
}

class _WebAnimatedTextWidgetState extends State<WebAnimatedTextWidget> {
  bool isCursorPointer = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        isCursorPointer = true;
        setState(() {});
      },
      onExit: (event) {
        isCursorPointer = false;
        setState(() {});
      },
      child: InkWell(
        onTap: () {
          widget.onTap();
        },
        child: Text(
          widget.text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: isCursorPointer
                    ? widget.animateTextSize
                    : widget.normalTextSize,
                color: isCursorPointer
                    ? widget.animateTextColor
                    : widget.normalTextColor,
              ),
        ),
      ),
    );
  }
}
