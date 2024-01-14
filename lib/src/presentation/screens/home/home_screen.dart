import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/base/widget/base_stateful_widget.dart';

class HomeScreen extends BaseStatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "Home Screen",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(),
    );
  }
}
