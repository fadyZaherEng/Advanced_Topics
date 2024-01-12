import 'package:flutter/cupertino.dart';

class WidgetId {
  static const int video = 1;
  static const int image = 2;
  static const int audio = 3;
}

class WidgetModel {
  final int id;
  final Widget widget;

  WidgetModel({
    required this.widget,
    required this.id,
  });
}
