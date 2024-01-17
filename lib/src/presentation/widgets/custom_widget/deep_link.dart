import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/utils/firebase_dynamic_link.dart';

class DeepLinkWidget extends StatefulWidget {
  const DeepLinkWidget({super.key});

  @override
  State<DeepLinkWidget> createState() => _DeepLinkWidgetState();
}

class _DeepLinkWidgetState extends State<DeepLinkWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Deep Link'),
        ),
        body: Center(
          child: TextButton(
              onPressed: () {
                createDynamicLink();
              },
              child: Text('Deep Link')),
        ));
  }

  //on tap
  void createDynamicLink() async {
    DynamicLinkService.instance.createDynamicLink();
  }
}
