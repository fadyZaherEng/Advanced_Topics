import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_svg/svg.dart';

class CustomButtonOptionWidget extends StatefulWidget {
  final void Function() onTap;
  final String buttonTitle;
  final double height;
  final double? width;
  late bool? isSelected;

  CustomButtonOptionWidget({
    Key? key,
    required this.onTap,
    required this.buttonTitle,
    this.height = 34,
    this.width,
    this.isSelected = false,
  }) : super(key: key);

  @override
  State<CustomButtonOptionWidget> createState() =>
      _CustomButtonOptionWidgetState();
}

class _CustomButtonOptionWidgetState extends State<CustomButtonOptionWidget> {
  Color _borderWithTitleColor = ColorSchemes.gray;

  @override
  void didUpdateWidget(covariant CustomButtonOptionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.isSelected == true
        ? _borderWithTitleColor = ColorSchemes.primary
        : _borderWithTitleColor = ColorSchemes.gray;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          widget.onTap();
          _checkButtonIsSelected();
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
                            ? _borderWithTitleColor = ColorSchemes.primary
                            : _borderWithTitleColor = ColorSchemes.gray),
                    color: ColorSchemes.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      widget.buttonTitle,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: _borderWithTitleColor,
                          fontSize: 13,
                          letterSpacing: -0.13),
                    ),
                  ),
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
                        ImagePaths.icLocation,
                      ),
                    )),
              )
            ],
          ),
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
}
