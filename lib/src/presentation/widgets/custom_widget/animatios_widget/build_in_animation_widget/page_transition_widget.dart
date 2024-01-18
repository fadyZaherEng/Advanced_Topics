import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class PageTransitionWidget extends StatefulWidget {
  const PageTransitionWidget({super.key});

  @override
  State<PageTransitionWidget> createState() => _PageTransitionWidgetState();
}

class _PageTransitionWidgetState extends State<PageTransitionWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: const NextScreen(),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
              child: const Text(
                'Next',
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NextScreen extends StatefulWidget {
  const NextScreen({super.key});

  @override
  State<NextScreen> createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ))),
              child: const Text(
                'Back',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
