import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ScrollInListScreen extends StatefulWidget {
  const ScrollInListScreen({super.key});

  @override
  State<ScrollInListScreen> createState() => _ScrollInListScreenState();
}

class _ScrollInListScreenState extends State<ScrollInListScreen> {
  final List<Item> _items = [];
  int _selectedIndex = 0;
  int seconds = 0;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 5000; i++) {
      _items.add(Item(GlobalKey(), 'Item $i'));
      if (i == 4000) _selectedIndex = i;
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      _scrollToIndex(_selectedIndex);
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() {
            seconds++;
            if (seconds == 3) {
              timer.cancel();
            }
          });
        }
      });
    });
  }

  final ItemScrollController itemScrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scroll In List'),
      ),
      body: ScrollablePositionedList.builder(
        itemScrollController: itemScrollController,
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return seconds < 3 && index == _selectedIndex
              ? Container(
                  margin: const EdgeInsetsDirectional.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorSchemes.primary,
                      width: 2,
                    ),
                  ),
                  child: ListTile(
                    title: Text(_items[index].title),
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                      _scrollToIndex(index);
                    },
                  ),
                )
              : ListTile(
                  title: Text(_items[index].title),
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                    _scrollToIndex(index);
                  },
                );
        },
      ),
    );
  }

  Future<void> _scrollToIndex(int index) async {
    Future.delayed(const Duration(milliseconds: 500));
    itemScrollController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic);
    //itemScrollController.jumpTo(index: index);
  }
}

class Item {
  final GlobalKey key;
  final String title;

  Item(this.key, this.title);
}
