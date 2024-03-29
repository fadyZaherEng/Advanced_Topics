import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MultiSelectionItem extends StatefulWidget {
  final void Function() onTap;
  bool isSelected;
  String text;
  double? width;
  double height;

  MultiSelectionItem(
      {Key? key,
      required this.text,
      this.isSelected = false,
      required this.onTap,
      this.height = 36,
      this.width})
      : super(key: key);

  @override
  State<MultiSelectionItem> createState() => _MultiSelectionItemState();
}

class _MultiSelectionItemState extends State<MultiSelectionItem> {
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
  void didUpdateWidget(covariant MultiSelectionItem oldWidget) {
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
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: widget.height,
              width: widget.width,
              child: Container(
                key: _containerKey,
                decoration: BoxDecoration(
                    border: Border.all(color: ColorSchemes.gray),
                    color: ColorSchemes.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: widget.isSelected
                                      ? ColorSchemes.primary
                                      : ColorSchemes.lightGray,
                                  borderRadius: BorderRadius.circular(4)),
                              child: widget.isSelected
                                  ? SvgPicture.asset(
                                      ImagePaths.approve,
                                    )
                                  : const SizedBox(),
                            )),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          widget.text,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: _borderWithTitleColor,
                                    fontSize: 13,
                                    height: 1.4,
                                    letterSpacing: -0.13,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                      height: widget.isSelected ? containerHeight : 0,
                      width: widget.isSelected ? containerWidth : 0,
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
                      height: widget.isSelected ? containerHeight : 0,
                      width: widget.isSelected ? containerWidth : 0,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _checkButtonIsSelected() {
    setState(() {
      if (widget.isSelected) {
        _borderWithTitleColor = ColorSchemes.primary;
      } else {
        _borderWithTitleColor = ColorSchemes.gray;
      }
    });
  }

  int _animationDuration() {
    return widget.isSelected ? 500 : 300;
  }
}
