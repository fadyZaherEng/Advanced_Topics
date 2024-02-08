// ignore_for_file: deprecated_member_use

import 'package:city_eye/src/config/theme/color_schemes.dart';
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
      content: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SvgPicture.asset(
                path,
                height: 24,
                width: 24,
                color: ColorSchemes.black,
                matchTextDirection: true,
              ),
              const SizedBox(
                width: 25,
              ),
              Text(
                message,
                maxLines: 3,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: ColorSchemes.black),
              )
            ],
          ),
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
