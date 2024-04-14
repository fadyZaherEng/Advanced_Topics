import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/base/widget/base_stateful_widget.dart';

class QrCreateScreen extends BaseStatefulWidget {
  const QrCreateScreen({super.key});

  @override
  BaseState<QrCreateScreen> baseCreateState() => _QrCreateScreenState();
}

class _QrCreateScreenState extends BaseState<QrCreateScreen> {
  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
