import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/base/widget/base_stateful_widget.dart';

class LogUpScreen extends BaseStatefulWidget {
  const LogUpScreen({super.key});
  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _LogUpScreenState();
}

class _LogUpScreenState extends BaseState<LogUpScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return const Scaffold();
  }
}
