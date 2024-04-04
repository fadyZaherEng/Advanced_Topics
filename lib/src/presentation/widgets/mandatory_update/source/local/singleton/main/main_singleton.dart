import 'package:flutter/material.dart';

final class MainSingleton {
  MainSingleton._();

  static final MainSingleton _instance = MainSingleton._();

  factory MainSingleton() => _instance;

  String pinCode = "";
  bool isScan = false;
  User user = User();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class User {}
