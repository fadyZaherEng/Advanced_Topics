import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/utils/show_no_internet_dialog_widget.dart';

class NetworkConnectivity {
  NetworkConnectivity._();

  static final _instance = NetworkConnectivity._();

  static NetworkConnectivity get instance => _instance;
  final _networkConnectivity = Connectivity();
  final _controller = StreamController.broadcast();

  Stream get myStream => _controller.stream;

  void initialise() async {
    ConnectivityResult result = await _networkConnectivity.checkConnectivity();
    _checkStatus(result);
    _networkConnectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('www.google.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    try {
      _controller.sink.add({result: isOnline});
    } catch (e) {
      print(e);
    }
  }

  void showOrHideNoInternetDialog(bool isOnline, BuildContext context) async {
    if (
        //GetNoInternetUseCase(injector())()
        // &&
        isOnline) {
      Navigator.pop(context);
      //   await SetNoInternetUseCase(injector())(false);
    } else if (!isOnline
        //&& !GetNoInternetUseCase(injector())()
        ) {
      showNoInternetDialogWidget(
        context: context,
        onTapTryAgain: () {},
      );
      // await SetNoInternetUseCase(injector())(true);
    }
  }

  void disposeStream() => _controller.close();
}
