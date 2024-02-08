import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSnackBarWidget {
  static void show({
    required BuildContext context,
    required String message,
    required String path,
    required Color backgroundColor,
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      behavior: SnackBarBehavior.floating,
      hitTestBehavior: HitTestBehavior.opaque,
      content: Expanded(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 80,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SvgPicture.asset(
                  path,
                  height: 24,
                  width: 24,
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
