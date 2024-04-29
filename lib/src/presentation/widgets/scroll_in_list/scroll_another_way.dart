import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';

class ScrollInListScreen extends StatefulWidget {
  const ScrollInListScreen({super.key});

  @override
  State<ScrollInListScreen> createState() => _ScrollInListScreenState();
}

class _ScrollInListScreenState extends State<ScrollInListScreen> {
  final List<Item> _items = [];
  Color borderColor = ColorSchemes.primary;
  var itemCount = 0;
  var _key;
  Timer? _timer;
  var scrollToId = 5000;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 1000000; i++) {
      _items.add(Item(GlobalKey(), 'Item $i', i));
    }
  }

  Future<void> _scrollToIndex(GlobalKey key) async {
    Future.delayed(const Duration(milliseconds: 300));
    Scrollable.ensureVisible(
      key.currentContext ?? context,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  getColor() {
    _timer = Timer(const Duration(seconds: 5), () {
      borderColor = ColorSchemes.white;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scroll In List'),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          itemCount++;
          if (scrollToId != 0 && _items[index].id == scrollToId) {
            _key = _items[index].key;
          }
          if (itemCount <= _items.length && _key != null) {
            setState(() {
              _scrollToIndex(_key);
              getColor();
            });
          }
          return Container(
            margin: const EdgeInsetsDirectional.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              border: Border.all(
                color: _items[index].id == scrollToId && _key != null
                    ? borderColor
                    : ColorSchemes.white,
                width: 2,
              ),
            ),
            child: ListTile(
              title: Text(_items[index].title),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}

class Item {
  final GlobalKey key;
  final String title;
  final int id;
  Item(this.key, this.title, this.id);
}
