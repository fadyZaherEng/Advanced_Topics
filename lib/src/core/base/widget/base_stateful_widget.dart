// ignore_for_file: no_logic_in_create_state

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/base/manager/loading/loading_manager.dart';
import 'package:flutter_advanced_topics/src/core/utils/show_no_internet_dialog_widget.dart';
import 'package:flutter_advanced_topics/src/di/injector.dart';
import 'package:flutter_advanced_topics/src/domain/use_case/internet/get_no_internet_use_case.dart';
import 'package:flutter_advanced_topics/src/domain/use_case/internet/set_no_internet_use_case.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class BaseStatefulWidget extends StatefulWidget {
  final Color materialColor;

  const BaseStatefulWidget({
    Key? key,
    this.materialColor = Colors.white,
  }) : super(key: key);

  @override
  BaseState createState() {
    return baseCreateState();
  }

  BaseState baseCreateState();
}

abstract class BaseState<W extends BaseStatefulWidget> extends State<W>
    with LoadingManager {
  final InternetConnectionChecker connectivity = InternetConnectionChecker();
  late StreamSubscription<InternetConnectionStatus> listener;

  @override
  Widget build(BuildContext context) {
    return baseWidget();
  }

  @override
  void initState() {
    super.initState();
    listener = connectivity.onStatusChange.listen(_updateConnectionStatus);
  }

  Widget baseWidget() {
    return Material(
      color: widget.materialColor,
      child: Stack(
        fit: StackFit.expand,
        children: [baseBuild(context), loadingManagerWidget()],
      ),
    );
  }

  void changeState() {
    setState(() {});
  }

  @override
  void runChangeState() {
    changeState();
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  Widget baseBuild(BuildContext context);

  Future<void> _updateConnectionStatus(InternetConnectionStatus status) async {
    if (status == InternetConnectionStatus.disconnected &&
        !GetNoInternetUseCase(injector())()) {
      SetNoInternetUseCase(injector())(true);
      showNoInternetDialogWidget(
        context: context,
        onTapTryAgain: () {
          if (status == InternetConnectionStatus.connected) {
            SetNoInternetUseCase(injector())(false);
            Navigator.pop(context);
          }
        },
      );
    } else if (status == InternetConnectionStatus.connected &&
        GetNoInternetUseCase(injector())()) {
      SetNoInternetUseCase(injector())(false);
      Navigator.pop(context);
    }
    setState(() {});
  }
}
