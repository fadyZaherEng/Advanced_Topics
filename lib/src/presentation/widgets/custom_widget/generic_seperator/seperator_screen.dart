import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/generic_seperator/seperator_extension.dart';

class SeperatorScreen extends StatefulWidget {
  const SeperatorScreen({super.key});

  @override
  State<SeperatorScreen> createState() => _SeperatorScreenState();
}

class _SeperatorScreenState extends State<SeperatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text("Seperator 1"),
            const Text("Seperator 2"),
            const Text("Seperator 3"),
            const Text("Seperator 4"),
            const Text("Seperator 5"),
            const Text("Seperator 6"),
            const Text("Seperator 7"),
            const Text("Seperator 8"),
          ]
              .toAddSeparator(
                separator: const Divider(
                  color: Colors.black,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
