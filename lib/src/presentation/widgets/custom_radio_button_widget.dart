import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';

class CustomRadioButtonWidget extends StatefulWidget {
  final bool isSelected;

  const CustomRadioButtonWidget({Key? key, required this.isSelected})
      : super(key: key);

  @override
  State<CustomRadioButtonWidget> createState() =>
      _CustomRadioButtonWidgetState();
}

class _CustomRadioButtonWidgetState extends State<CustomRadioButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: widget.isSelected ? ColorSchemes.primary : ColorSchemes.gray,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Container(
          decoration: BoxDecoration(
            color:
                widget.isSelected ? ColorSchemes.primary : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color:
                  widget.isSelected ? ColorSchemes.primary : Colors.transparent,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
