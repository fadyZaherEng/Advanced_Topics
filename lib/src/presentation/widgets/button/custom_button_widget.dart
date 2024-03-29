import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';

class CustomButtonWidget extends StatefulWidget {
  void Function()? onPressed;
  String title;
  double padding;

  CustomButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
    this.padding = 20,
  });

  @override
  State<CustomButtonWidget> createState() => _CustomButtonWidgetState();
}

class _CustomButtonWidgetState extends State<CustomButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.padding),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            color: ColorSchemes.buttonOnBoarding,
            borderRadius: BorderRadiusDirectional.all(Radius.circular(12))),
        child: MaterialButton(
          onPressed: widget.onPressed,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          height: 50,
          child: Text(
            widget.title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: ColorSchemes.whit),
          ),
        ),
      ),
    );
  }
}
