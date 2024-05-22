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
  Color _borderColor = ColorSchemes.primary;
  int scrollToId = 500;
  ScrollBloc get _bloc => BlocProvider.of<ScrollBloc>(context);

  @override
  void initState() {
    super.initState();
    _init();
  }
_init(){
  for (int i = 0; i < 1000; i++) {
    print("i: $i");
    _items.add(Item(GlobalKey(), 'Item $i', i));
  }
}
  @override
  Widget build(BuildContext context) {
    print("scrollToId: $scrollToId");
    print("LIST LENGTH: ${_items.length}");
    return BlocConsumer<ScrollBloc, ScrollState>(
      listener: (context, state) {
        if (state is ScrollToItemState) {
          _scrollToIndex(state.key);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Scroll In List'),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    print("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD ${_items[index].id}");
                    if (scrollToId != 0 && _items[index].id == scrollToId) {
                      print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
                      // Future.delayed(const Duration(milliseconds: 500)).then((value) {
                      //   _scrollToIndex(_items[index].key);
                      // });
                      _scrollToIndex(_items[index].key);
                    }
                    return Container(
                      margin: const EdgeInsetsDirectional.symmetric(horizontal: 5),
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
                        onTap: () {
                            _init();
                            setState(() {

                            });
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _scrollToIndex(GlobalKey key) async {
    print("keyRRRRRRRRRRRRrr: $key");
    Future.delayed(const Duration(milliseconds: 300));
    Scrollable.ensureVisible(
      key.currentContext ?? context,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    setState(() {});
    _getColor();
  }

  void _getColor() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
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
