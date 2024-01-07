import 'package:flutter/material.dart';

class RefreshWidget extends StatefulWidget {
  const RefreshWidget({super.key});

  @override
  State<RefreshWidget> createState() => _RefreshWidgetState();
}

class _RefreshWidgetState extends State<RefreshWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        child: Container(),
        onRefresh: () async {},
      ),
    );
  }
}
