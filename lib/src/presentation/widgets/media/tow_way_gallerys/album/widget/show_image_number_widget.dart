import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';

class ShowImageNumberWidget extends StatefulWidget {
  int idx;
  int length;

  ShowImageNumberWidget({
    super.key,
    required this.length,
    required this.idx,
  });

  @override
  State<ShowImageNumberWidget> createState() => _ShowImageNumberWidgetState();
}

class _ShowImageNumberWidgetState extends State<ShowImageNumberWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 25,
              width: 45,
              color: ColorSchemes.primary,
              child: Center(
                child: Text(
                  "${widget.idx} + 1}/${widget.length}",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: ColorSchemes.white,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
