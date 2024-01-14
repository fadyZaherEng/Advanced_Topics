// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget newLoadingAnimationWidget() {
  return SizedBox(
    width: double.infinity,
    height: double.infinity,
    child: Center(
        child: LoadingAnimationWidget.threeArchedCircle(
      color: ColorSchemes.primary,
      size: 50,
    )),
  );
}
