import 'package:flutter/material.dart';

class ScrollInListScreen extends StatefulWidget {
  const ScrollInListScreen({super.key});

  @override
  State<ScrollInListScreen> createState() => _ScrollInListScreenState();
}

class _ScrollInListScreenState extends State<ScrollInListScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Future<void> _scrollToIndex(GlobalKey key) async {
    Future.delayed(const Duration(milliseconds: 500));
    Scrollable.ensureVisible(
      key.currentContext ?? context,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
