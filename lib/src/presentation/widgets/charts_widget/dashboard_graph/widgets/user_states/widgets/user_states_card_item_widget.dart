import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserStatesCardItemWidget extends StatefulWidget {
  final String path;
  final String number;
  final Color color;

  const UserStatesCardItemWidget({
    super.key,
    required this.path,
    required this.number,
    required this.color,
  });

  @override
  State<UserStatesCardItemWidget> createState() =>
      _UserStatesCardItemWidgetState();
}

class _UserStatesCardItemWidgetState extends State<UserStatesCardItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        CircleAvatar(
          backgroundColor: ColorSchemes.white,
          radius: 40,
          child: SvgPicture.asset(
            widget.path,
            fit: BoxFit.scaleDown,
            width: 32,
            height: 32,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Flexible(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "${widget.number.split(" ")[0]} \n",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: widget.color,
                      ),
                ),
                TextSpan(
                  text: " ${widget.number.split(" ")[1]} \n",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: widget.color,
                      ),
                ),
                TextSpan(
                  text: " ${widget.number.split(" ")[2]} \n",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: widget.color,
                      ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
