import 'package:draggable_expandable_fab/draggable_expandable_fab.dart';
import 'package:flutter/material.dart';

class DraggableExpandableFabWidget extends StatefulWidget {
  const DraggableExpandableFabWidget({super.key});

  @override
  State<DraggableExpandableFabWidget> createState() =>
      _DraggableExpandableFabWidgetState();
}

class _DraggableExpandableFabWidgetState
    extends State<DraggableExpandableFabWidget> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonAnimator: NoScalingAnimation(),
      floatingActionButtonLocation: ExpandableFloatLocation(),
      floatingActionButton: ExpandableDraggableFab(
        childrenCount: 6,
        onTab: () {
          debugPrint("Tab");
        },
        childrenTransition: ChildrenTransition.fadeTransation,
        initialOpen: false,
        childrenBoxDecoration: const BoxDecoration(color: Colors.transparent),
        enableChildrenAnimation: true,
        curveAnimation: Curves.linear,
        reverseAnimation: Curves.linear,
        childrenType: ChildrenType.columnChildren,
        closeChildrenRotate: false,
        childrenAlignment: Alignment.topRight,
        initialDraggableOffset: Offset(size.width - 90, size.height - 100),
        distance: 100,
        // Animation distance during open and close.
        children: [
          FloatingActionButton(
            onPressed: () {},
            child: const Icon(
              Icons.add,
            ),
          ),
          FloatingActionButton(
            onPressed: () {},
            child: const Icon(
              Icons.home,
            ),
          ),
          FloatingActionButton(
            onPressed: () {},
            child: const Icon(
              Icons.settings,
            ),
          ),
          FloatingActionButton(
            onPressed: () {},
            child: const Icon(
              Icons.add,
            ),
          ),
          FloatingActionButton(
            onPressed: () {},
            child: const Icon(
              Icons.home,
            ),
          ),
          FloatingActionButton(
            onPressed: () {},
            child: const Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
