import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/signture_widget.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class KeywordVisibilty extends StatelessWidget {
  const KeywordVisibilty({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Keyboard Visibility Example'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  },
                  child: const Text('Provider KeywordVisibilty'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  },
                  child: const Text('KeyboardDismiss KeywordVisibilty'),
                ),
                const Spacer(),
                const TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Input box for keyboard test',
                  ),
                ),
                Container(height: 60.0),
                KeyboardVisibilityBuilder(builder: (context, visible) {
                  return Text(
                    'The keyboard is: ${visible ? 'VISIBLE' : 'NOT VISIBLE'}',
                  );
                }),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
