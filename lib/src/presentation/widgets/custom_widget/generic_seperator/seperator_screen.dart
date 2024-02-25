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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text("Separator 1", style: TextStyle(fontSize: 20)),
              const Text("Separator 2", style: TextStyle(fontSize: 20)),
              const Text("Separator 3", style: TextStyle(fontSize: 20)),
              const Text("Separator 4", style: TextStyle(fontSize: 20)),
              const Text("Separator 5", style: TextStyle(fontSize: 20)),
              const Text("Separator 6", style: TextStyle(fontSize: 20)),
              const Text("Separator 7", style: TextStyle(fontSize: 20)),
              const Text("Separator 8", style: TextStyle(fontSize: 20)),
            ]
                .toAddSeparator(
                  separator: const SizedBox(
                    height: 20,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
