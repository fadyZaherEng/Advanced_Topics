import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class VibrationScreen extends StatelessWidget {
  const VibrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vibration"),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            const snackBar = SnackBar(
              content: Text(
                'Pattern: wait 0.5s, vibrate 1s, wait 0.5s, vibrate 2s, wait 0.5s, vibrate 3s, wait 0.5s, vibrate 0.5s',
              ),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Vibration.vibrate(
              duration: 1000,
              pattern: [500, 1000, 500, 2000, 500, 3000, 500, 500],
              intensities: [0, 128, 0, 255, 0, 64, 0, 255],
            );
          },
          child: const Text("Vibration"),
        ),
      ),
    );
  }
}
