// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/scroll_in_list/bloc/scroll_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScrollInAnotherListScreen extends StatefulWidget {
  const ScrollInAnotherListScreen({
    super.key,
  });

  @override
  State<ScrollInAnotherListScreen> createState() =>
      _ScrollInAnotherListScreenState();
}

class _ScrollInAnotherListScreenState extends State<ScrollInAnotherListScreen> {
  Color _borderColor = ColorSchemes.primary;
  int scrollToId = 500;
  int itemsCount = 0;

  ScrollBloc get _bloc => BlocProvider.of<ScrollBloc>(context);
  final List<Item> _items = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 1000; i++) {
      _items.add(Item(GlobalKey(), 'Item $i', i));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScrollBloc, ScrollState>(
      listener: (context, state) {
        if (state is ScrollToItemState) {
          _scrollToIndex(state.key);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Scroll In List')),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ListView.separated(
                itemCount: _items.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  itemsCount++;
                  if (scrollToId != 0 &&
                      _items[index].id == scrollToId &&
                      itemsCount <= _items.length) {
                    //to avoid rebuild screen from second time when we scroll within bloc
                    //so item count will be always increased by length of list
                    //to avoid that check if item count is less than length of list then we can scroll to that item
                    //and if we are not scrolling then we can scroll to that item
                    _bloc.add(ScrollToItemEvent(_items[index].key));
                  }
                  return Container(
                    key: _items[index].key,
                    margin:
                        const EdgeInsetsDirectional.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _items[index].id == scrollToId
                            ? _borderColor
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
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _scrollToIndex(GlobalKey key) async {
    Future.delayed(const Duration(milliseconds: 300));
    Scrollable.ensureVisible(
      key.currentContext ?? context,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    ).then((value) async {});
    getColor();
  }

  void getColor() {
    Future.delayed(const Duration(seconds: 3), () {
      _borderColor = ColorSchemes.white;
      setState(() {});
    });
  }
}

class Item {
  final GlobalKey key;
  final String title;
  final int id;

  Item(this.key, this.title, this.id);
}
