import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/scroll_in_list/bloc/scroll_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScrollInAnotherListScreen extends StatefulWidget {
  const ScrollInAnotherListScreen({super.key});

  @override
  State<ScrollInAnotherListScreen> createState() =>
      _ScrollInAnotherListScreenState();
}

class _ScrollInAnotherListScreenState extends State<ScrollInAnotherListScreen> {
  final List<Item> _items = [];
  Color borderColor = ColorSchemes.primary;
  var _key;
  Timer? _timer;
  var scrollToId = 5000;
  @override
  void initState() {
    _fetchData();
  }

  _fetchData() {
    for (int i = 0; i < 1000000; i++) {
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

  ScrollBloc get _bloc => BlocProvider.of<ScrollBloc>(context);
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("scrollToId: $scrollToId");
    return BlocConsumer<ScrollBloc, ScrollState>(
      listener: (context, state) {
        if (state is ScrollToItemState) {
          getColor();
          _scrollToIndex(state.key);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Scroll In List'),
          ),
          body: ListView.builder(
            itemCount: _items.length,
            itemBuilder: (context, index) {
              if (scrollToId != 0 && _items[index].id == scrollToId) {
                _key = _items[index].key;
              }
              if (index < _items.length && _key != null) {
                _bloc.add(ScrollToItemEvent(_key));
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
      },
    );
  }
}

class Item {
  final GlobalKey key;
  final String title;
  final int id;
  Item(this.key, this.title, this.id);
}
