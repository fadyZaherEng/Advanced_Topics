import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContextMenu extends StatelessWidget {
  const ContextMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Context Menu"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                _showContextMenu(context);
              },
              child: const Text("Text Button"),
            ),
          ],
        ),
      ),
    );
  }

  final String languageCode = "en";

  void _showContextMenu(BuildContext context) async {
    final RenderObject? overlay =
        Overlay.of(context).context.findRenderObject();
    double width = MediaQuery.of(context).size.width;
    if (languageCode.toLowerCase() == "ar") {
      width = -1 * width;
    } else {
      width = width.abs();
    }
    await showMenu(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromLTWH(
            width, MediaQuery.of(context).size.height - 240, 100, 100),
        Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
            overlay.paintBounds.size.height),
      ),
      items: [
        PopupMenuItem(
          padding: EdgeInsets.zero,
          onTap: () {},
          child: Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
            height: 45.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SvgPicture.asset(ImagePaths.hold),
                const SizedBox(width: 8),
                Text(
                  "Hold",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: ColorSchemes.gray,
                      ),
                ),
              ],
            ),
          ),
        ),
        PopupMenuItem(
          padding: EdgeInsets.zero,
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
            height: 45.0,
            color: Colors.grey[200],
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SvgPicture.asset(ImagePaths.needPayment),
                const SizedBox(width: 8),
                Text("NeedPayment",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: ColorSchemes.gray)),
              ],
            ),
          ),
        ),
        PopupMenuItem(
          padding: EdgeInsets.zero,
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
            height: 45.0,
            color: Colors.grey[200],
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SvgPicture.asset(ImagePaths.cancel),
                const SizedBox(width: 8),
                Text(
                  "Cancel",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: ColorSchemes.gray,
                      ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
