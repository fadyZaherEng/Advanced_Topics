// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:quick_actions/quick_actions.dart';

class QuickActionScreen extends StatefulWidget {
  const QuickActionScreen({super.key});

  @override
  State<QuickActionScreen> createState() => _QuickActionScreenState();
}

class _QuickActionScreenState extends State<QuickActionScreen> {
  String shortcut = 'no action set';

  @override
  void initState() {
    super.initState();
    const QuickActions quickActions = QuickActions();
    quickActions.initialize((String shortcutType) {
      setState(() {
        shortcut = shortcutType;
      });
    });

    quickActions.setShortcutItems(
      <ShortcutItem>[
        // NOTE: This first action icon will only work on iOS.
        // In a real world project keep the same file name for both platforms.
        const ShortcutItem(
          type: 'action_one',
          localizedTitle: 'Action one',
          icon: ImagePaths.logo,
        ),
        // NOTE: This second action icon will only work on Android.
        // In a real world project keep the same file name for both platforms.
        const ShortcutItem(
          type: 'action_two',
          localizedTitle: 'Action two',
          icon: ImagePaths.apple,
        ),
      ],
    ).then((void _) {
      setState(() {
        if (shortcut == 'no action set') {
          shortcut = 'actions ready';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shortcut),
      ),
      body: const Center(
        child: Text('On home screen, long press the app icon to '
            'get Action one or Action two options. Tapping on that action should  '
            'set the toolbar title.'),
      ),
    );
  }
}
