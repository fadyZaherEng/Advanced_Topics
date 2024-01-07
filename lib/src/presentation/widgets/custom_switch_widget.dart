// ignore_for_file: camel_case_types

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';

class CustomSwitchWidget extends StatefulWidget {
  final bool value;
  final Color activeColor;
  final Color activeTrackColor;
  final void Function(bool value)? onChanged;

  const CustomSwitchWidget({
    super.key,
    this.value = false,
    required this.onChanged,
    required this.activeColor,
    required this.activeTrackColor,
  });

  @override
  State<CustomSwitchWidget> createState() => _CustomSwitchWidgetState();
}

class _CustomSwitchWidgetState extends State<CustomSwitchWidget> {
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? Container(
            height: 28,
            margin: const EdgeInsetsDirectional.only(start: 30),
            child: GestureDetector(
              onTap: () => widget.onChanged!(widget.value),
              child: Stack(
                  alignment: widget.value
                      ? AlignmentDirectional.centerEnd
                      : AlignmentDirectional.centerStart,
                  children: [
                    Center(
                      child: Container(
                        width: 45.0,
                        height: 18.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: widget.value
                              ? ColorSchemes.primary
                              : ColorSchemes.gray,
                        ),
                      ),
                    ),
                    Container(
                      width: 25.0,
                      height: 25.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorSchemes.white,
                        boxShadow: [
                          BoxShadow(
                            color: ColorSchemes.gray.withOpacity(0.25),
                            spreadRadius: 0.0,
                            blurRadius: 20.0,
                            offset: const Offset(0.0, 0.0),
                          )
                        ],
                      ),
                    ),
                  ]),
            ),
          )
        : Container(
            height: 25,
            margin: const EdgeInsetsDirectional.only(start: 30),
            child: GestureDetector(
              onTap: () => widget.onChanged!(widget.value),
              child: Container(
                width: 45.0,
                height: 25.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color:
                      widget.value ? ColorSchemes.primary : ColorSchemes.gray,
                ),
                child: Stack(
                  alignment: widget.value
                      ? AlignmentDirectional.centerEnd
                      : AlignmentDirectional.centerStart,
                  children: [
                    Container(
                      width: 25.0,
                      height: 25.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: CupertinoColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
