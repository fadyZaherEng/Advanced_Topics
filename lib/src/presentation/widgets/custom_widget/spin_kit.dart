import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpinKitWidget extends StatefulWidget {
  const SpinKitWidget({super.key});

  @override
  State<SpinKitWidget> createState() => _SpinKitWidgetState();
}

class _SpinKitWidgetState extends State<SpinKitWidget> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50,),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.only(bottom: 8),
                child: const SizedBox(
                  width: 50,
                  child: SpinKitThreeBounce(
                    color: Colors.blueGrey,
                    size: 20.0,
                  ),
                ),
              )
            ),
          ],
        ),
      )
    );
  }
}
