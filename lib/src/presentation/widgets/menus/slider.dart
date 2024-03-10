import 'package:flutter/material.dart';
import 'package:slider_side_menu/slider_side_menu.dart';

class SliderSideMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Slider Side Menu Demo"),
      ),
      body: Stack(
        children: [
          const Center(
            child: Text("Demostration of Slider Side Menu Demo"),
          ),
          SliderSideMenu(
            childrenData: [
              MenuItem(
                  const Icon(
                    Icons.thumb_up,
                    color: Colors.white,
                  ),
                  const Text(
                    "Thumb up",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: _thumbUp),
              MenuItem(
                  const Icon(
                    Icons.thumb_down,
                    color: Colors.white,
                  ),
                  const Text(
                    "Thumb down",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: _thumbDown),
            ],
            description: "Sample tooltip message",
            parentStartColor: Colors.teal,
          )
        ],
      ),
    );
  }

  void _thumbUp() {}

  void _thumbDown() {}
}
