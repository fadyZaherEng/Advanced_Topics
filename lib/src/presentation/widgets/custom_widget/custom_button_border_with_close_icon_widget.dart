import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_svg/svg.dart';

class CustomButtonBorderWithCloseIconWidget extends StatefulWidget {
  final void Function() onTap;
  final void Function() onTapClose;
  final String buttonTitle;
  final double height;
  final double? width;
  late bool? isSelected;
  final bool isAllItems;
  final bool isCarType;

  CustomButtonBorderWithCloseIconWidget({
    Key? key,
    required this.onTap,
    required this.buttonTitle,
    this.height = 34,
    this.width,
    this.isSelected = false,
    required this.onTapClose,
    required this.isAllItems,
    this.isCarType = false,
  }) : super(key: key);

  @override
  State<CustomButtonBorderWithCloseIconWidget> createState() =>
      _CustomButtonBorderWithCloseIconWidgetState();
}

class _CustomButtonBorderWithCloseIconWidgetState
    extends State<CustomButtonBorderWithCloseIconWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          widget.onTap();
        },
        child: SizedBox(
          height: widget.height,
          width: widget.width,
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: widget.isSelected == true
                            ? ColorSchemes.primary
                            : widget.isCarType ? ColorSchemes.gray:Colors.transparent),
                    color: ColorSchemes.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      widget.buttonTitle,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: widget.isSelected == true
                              ? ColorSchemes.primary
                              : widget.isCarType ?  ColorSchemes.gray : ColorSchemes.black,
                          letterSpacing: -0.13),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: widget.onTapClose,
                child: Visibility(
                  visible: widget.isSelected!,
                  child: widget.isAllItems
                      ? const SizedBox.shrink()
                      : Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                                color: ColorSchemes.primary,
                                borderRadius: BorderRadius.circular(40)),
                            child: SvgPicture.asset(
                              ImagePaths.close,
                              color: Colors.white,
                              fit: BoxFit.scaleDown,
                            ),
                          )),
                ),
              )
            ],
          ),
        ));
  }
}
