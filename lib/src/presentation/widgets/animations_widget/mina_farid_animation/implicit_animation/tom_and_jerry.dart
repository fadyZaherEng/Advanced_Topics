import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';

class TomAndJerryWidget extends StatefulWidget {
  const TomAndJerryWidget({super.key});

  @override
  State<TomAndJerryWidget> createState() => _TomAndJerryWidgetState();
}

class _TomAndJerryWidgetState extends State<TomAndJerryWidget> {
  int _jerryAligned = 0;

  @override
  void initState() {
    super.initState();
    Stream.periodic(const Duration(milliseconds: 400), (i) => i).listen((event) {
      setState(() {
        _jerryAligned = _jerryAligned + 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tom and Jerry'),
      ),
      body: Stack(
        children: [
          AnimatedAlign(
            alignment: getNextAlignment(_jerryAligned),
            duration: const Duration(milliseconds: 400),
            child: Container(
              width: 100,
              height: 100,
              color: Colors.transparent,
              child: Image.asset(ImagePaths.tom),
            ),
          ),
          AnimatedAlign(
            alignment: getNextAlignment(_jerryAligned + 1),
            duration: const Duration(milliseconds: 400),
            child: Container(
              width: 100,
              height: 100,
              color: Colors.transparent,
              child: Image.asset(ImagePaths.jerry),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.animation),
          onPressed: () {
            setState(() {
              _jerryAligned = _jerryAligned + 1;
            });
          }),
    );
  }

  Alignment getNextAlignment(int alignment) {
    switch (alignment) {
      case 1:
        return Alignment.topCenter;
      case 2:
        return Alignment.topRight;
      case 3:
        return Alignment.centerLeft;
      case 4:
        return Alignment.center;
      case 5:
        return Alignment.centerRight;
      case 6:
        return Alignment.bottomLeft;
      case 7:
        return Alignment.bottomCenter;
      case 8:
        return Alignment.bottomRight;
      default:
        _jerryAligned = 0;
        return Alignment.topLeft;
    }
  }
}
