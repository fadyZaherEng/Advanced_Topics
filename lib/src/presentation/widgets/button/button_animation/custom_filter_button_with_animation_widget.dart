import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomFilterButtonWidget extends StatefulWidget {
  final double width;
  final double height;
  final void Function() onTapFilter;
  bool isClicked;
  bool isOpacity;

  CustomFilterButtonWidget({
    super.key,
    this.width = 100,
    this.height = 35,
    required this.onTapFilter,
    required this.isClicked,
    required this.isOpacity,
  });

  @override
  State<CustomFilterButtonWidget> createState() =>
      _CustomFilterButtonWidgetState();
}

class _CustomFilterButtonWidgetState extends State<CustomFilterButtonWidget> {
  final BorderSide _borderSide = const BorderSide(
    width: 2,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!widget.isClicked) {
          widget.isClicked = true;
          setState(() {
            widget.isOpacity = !widget.isOpacity;
            Future.delayed(const Duration(
              milliseconds: 1200,
            )).then((value) {
              setState(() {
                widget.isOpacity = !widget.isOpacity;
                widget.onTapFilter();
              });
            });
          });
        }
      },
      // onTap: widget.onTapFilter,
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(
                milliseconds: 1000,
              ),
              width: widget.width,
              height: widget.height,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: ColorSchemes.primary,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  width: 2,
                  color: widget.isOpacity
                      ? ColorSchemes.white
                      : ColorSchemes.primary,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 25,
                    offset: const Offset(-1, 0),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    ImagePaths.icPinCode,
                    color: ColorSchemes.white,
                    width: 14,
                    height: 14,
                    fit: BoxFit.scaleDown,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    "S.current.filter",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorSchemes.white,
                        ),
                  ),
                ],
              ),
            ),
            _customAnimationWidget(
              opacity: widget.isOpacity,
              width: widget.width,
              height: 2,
              alignment: const Alignment(1, -1),
              offset: const Offset(1, -1),
              sideName: 'top',
            ),
            _customAnimationWidget(
              opacity: widget.isOpacity,
              width: 2,
              height: widget.height,
              alignment: const Alignment(1, -1),
              offset: const Offset(1, -1),
              sideName: 'left',
            ),
            _customAnimationWidget(
              opacity: widget.isOpacity,
              width: widget.width,
              height: 2,
              alignment: const Alignment(-1, 1),
              offset: const Offset(-1, 1),
              sideName: 'bottom',
            ),
            _customAnimationWidget(
              opacity: widget.isOpacity,
              width: 2,
              height: widget.height,
              alignment: const Alignment(-1, 1),
              offset: const Offset(-1, 1),
              sideName: 'right',
            ),
          ],
        ),
      ),
    );
  }

  Widget _customAnimationWidget({
    required bool opacity,
    required double width,
    required double height,
    required Alignment alignment,
    required Offset offset,
    required String sideName,
  }) =>
      AnimatedOpacity(
        duration: const Duration(
          milliseconds: 1000,
        ),
        opacity: opacity ? 1 : 0,
        curve: Curves.easeIn,
        child: Align(
          alignment: alignment,
          child: AnimatedScale(
            duration: const Duration(
              milliseconds: 1000,
            ),
            scale: opacity ? 1 : 0,
            curve: Curves.easeIn,
            alignment: alignment,
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 1000,
              ),
              width: width,
              height: height,
              margin: EdgeInsetsDirectional.only(
                start: sideName == 'top' || sideName == 'bottom' ? 4 : 0,
                end: sideName == 'top' || sideName == 'bottom' ? 4 : 0,
                top: sideName == 'left' || sideName == 'right' ? 4 : 0,
                bottom: sideName == 'right' || sideName == 'left' ? 4 : 0,
              ),
              curve: Curves.easeIn,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: ColorSchemes.white,
                borderRadius:
                    const BorderRadiusDirectional.all(Radius.circular(6)),
                border: Border(
                  right: sideName == 'right' ? _borderSide : BorderSide.none,
                  left: sideName == 'left' ? _borderSide : BorderSide.none,
                  top: sideName == 'top' ? _borderSide : BorderSide.none,
                  bottom: sideName == 'bottom' ? _borderSide : BorderSide.none,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 25,
                    offset: offset,
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
