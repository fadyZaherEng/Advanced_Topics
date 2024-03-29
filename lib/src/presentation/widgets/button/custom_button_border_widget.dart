import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_svg/svg.dart';

class CustomButtonBorderWidget extends StatefulWidget {
  final void Function() onTap;
  final String buttonTitle;
  final double height;
  final double? width;
  late bool? isSelected;

  CustomButtonBorderWidget({
    Key? key,
    required this.onTap,
    required this.buttonTitle,
    this.height = 34,
    this.width,
    this.isSelected = false,
  }) : super(key: key);

  @override
  State<CustomButtonBorderWidget> createState() =>
      _CustomButtonBorderWidgetState();
}

class _CustomButtonBorderWidgetState extends State<CustomButtonBorderWidget> {
  Color _borderWithTitleColor = ColorSchemes.gray;

  final GlobalKey _containerKey = GlobalKey();
  double containerWidth = 0.0;
  double containerHeight = 0.0;

  bool _performAnimation = false;

  @override
  void initState() {
    super.initState();
    _checkButtonIsSelected();
    _getContainerSize();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (widget.isSelected == false) _performAnimation = true;
  }

  @override
  void didUpdateWidget(covariant CustomButtonBorderWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.isSelected == true
        ? _borderWithTitleColor = ColorSchemes.primary
        : _borderWithTitleColor = ColorSchemes.gray;
    _performAnimation = true;
    _getContainerSize();
  }

  void _getContainerSize() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      containerWidth = _containerKey.currentContext?.size?.width ?? 0.0;
      containerHeight = _containerKey.currentContext?.size?.height ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          widget.onTap();
          _checkButtonIsSelected();
        },
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    key: _containerKey,
                    height: widget.height,
                    width: widget.width,
                    decoration: BoxDecoration(
                        color: ColorSchemes.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: _performAnimation
                                ? ColorSchemes.gray
                                : _borderWithTitleColor)),
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              widget.buttonTitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                      color: _borderWithTitleColor,
                                      fontSize: 13,
                                      letterSpacing: -0.13),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_performAnimation) ...[
                    Container(
                      height: widget.height,
                      width: containerWidth,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          AnimatedContainer(
                            duration: Duration(
                              milliseconds: _animationDuration(),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border(
                                top: BorderSide(color: ColorSchemes.primary),
                                right: BorderSide(color: ColorSchemes.primary),
                              ),
                            ),
                            height: widget.isSelected! ? containerHeight : 0,
                            width: widget.isSelected! ? containerWidth : 0,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: widget.height,
                      width: containerWidth,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          AnimatedContainer(
                            duration: Duration(
                              milliseconds: _animationDuration(),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border(
                                bottom: BorderSide(color: ColorSchemes.primary),
                                left: BorderSide(color: ColorSchemes.primary),
                              ),
                            ),
                            height: widget.isSelected! ? containerHeight : 0,
                            width: widget.isSelected! ? containerWidth : 0,
                          ),
                        ],
                      ),
                    ),
                  ]
                ],
              ),
            ),
            Visibility(
              visible: widget.isSelected!,
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        color: ColorSchemes.primary,
                        borderRadius: BorderRadius.circular(40)),
                    child: SvgPicture.asset(
                      ImagePaths.approve,
                    ),
                  )),
            )
          ],
        ));
  }

  void _checkButtonIsSelected() {
    setState(() {
      if (widget.isSelected!) {
        _borderWithTitleColor = ColorSchemes.primary;
      } else {
        _borderWithTitleColor = ColorSchemes.gray;
      }
    });
  }

  int _animationDuration() {
    return widget.isSelected! ? 500 : 300;
  }
}
