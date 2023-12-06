import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';

class CardWidget extends StatelessWidget {
  final Widget widget;
  final String title;
  final String subtitle;

  const CardWidget({
    Key? key,
    required this.widget,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 24,
            spreadRadius: 0,
            color: ColorSchemes.lightGray,
            blurStyle: BlurStyle.outer,
          )
        ],
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 16,
          ),
          widget,
          const SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: ColorSchemes.black,
                  letterSpacing: -0.24,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            width: 132,
            child: Text(
              subtitle,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: ColorSchemes.gray,
                    letterSpacing: -0.24,
                  ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
