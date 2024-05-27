
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';

class ScrollToKeyExample extends StatefulWidget {
  const ScrollToKeyExample({super.key});

  @override
  _ScrollToKeyExampleState createState() => _ScrollToKeyExampleState();
}

class _ScrollToKeyExampleState extends State<ScrollToKeyExample> {
  final ScrollController _scrollController = ScrollController();
  final int _scrollId = 500;
  int _selectedIndex = 0;
  final List<Item> _items = List.generate(1000, (index) => Item(
    GlobalKey(),
    'Item $index',
    index
  ));

  void _scrollToItem(int index) {
    setState(() {});
    print('index: $index');
    print("key ${_items[index].key}");
    final keyContext = _items[index].key.currentContext;
    if (keyContext != null) {
      Scrollable.ensureVisible(keyContext,
          duration: const Duration(seconds: 1),
          alignment: 0.5,
          curve: Curves.easeInOut);
    }
  }
  @override
  void initState() {
    super.initState();
    print("length: ${_items.length}");
    for(int i = 0; i < _items.length; i++) {
      if(_scrollId == _items[i].id) {
        _selectedIndex = i;
        break;
      }
    }
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollToItem(_selectedIndex);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scroll To Key Example'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => _scrollToItem(_selectedIndex), // Scroll to item with index 50
            child: const Text('Scroll to Item 50'),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _items.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                print("index: $index");
                return Container(
                  key: _items[index].key,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorSchemes.primary,
                      width: 2,
                    ),
                    color: index % 2 == 0 ? Colors.blue : Colors.green,

                  ),
                  height: 50,
                  alignment: Alignment.center,
                  child: Text('Item $index'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
// import 'package:flutter_advanced_topics/src/presentation/widgets/scroll_in_list/bloc/scroll_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class ScrollInAnotherListScreen extends StatefulWidget {
//   final List<Item> items ;
//   const ScrollInAnotherListScreen({super.key, required this.items});
//
//   @override
//   State<ScrollInAnotherListScreen> createState() =>
//       _ScrollInAnotherListScreenState();
// }
//
// class _ScrollInAnotherListScreenState extends State<ScrollInAnotherListScreen> {
//   Color _borderColor = ColorSchemes.primary;
//   int scrollToId = 500;
//   ScrollBloc get _bloc => BlocProvider.of<ScrollBloc>(context);
// @override
//   void initState() {
//     super.initState();
//
//     _scrollToIndex(widget.items[scrollToId].key);
//   }
//   @override
//   Widget build(BuildContext context) {
//     print("scrollToId: $scrollToId");
//     print("LIST LENGTH: ${widget.items.length}");
//     return BlocConsumer<ScrollBloc, ScrollState>(
//       listener: (context, state) {
//         if (state is ScrollToItemState) {
//           _scrollToIndex(state.key);
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           appBar: AppBar(
//             title: const Text('Scroll In List'),
//           ),
//           body: ListView.separated(
//             itemCount: widget.items.length,
//             itemBuilder: (context, index) {
//               print("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD ${widget.items[index].id}");
//               return Container(
//                 margin: const EdgeInsetsDirectional.symmetric(horizontal: 5),
//                 child: Text(
//                   widget.items[index].title,
//                 )
//               );
//               // if (scrollToId != 0 && widget.items[index].id == scrollToId) {
//               //   print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
//               //   // Future.delayed(const Duration(milliseconds: 500)).then((value) {
//               //   //   _scrollToIndex(widget.items[index].key);
//               //   // });
//               //   _scrollToIndex(widget.items[index].key);
//               // }
//               // return Container(
//               //   margin: const EdgeInsetsDirectional.symmetric(horizontal: 5),
//               //   decoration: BoxDecoration(
//               //     border: Border.all(
//               //       color: widget.items[index].id == scrollToId
//               //           ? _borderColor
//               //           : ColorSchemes.white,
//               //       width: 2,
//               //     ),
//               //   ),
//               //   child: ListTile(
//               //     title: Text(widget.items[index].title),
//               //     onTap: () {},
//               //   ),
//               // );
//             },
//             separatorBuilder: (context, index) {
//               return const Divider();
//             },
//           ),
//         );
//       },
//     );
//   }
//
//   Future<void> _scrollToIndex(GlobalKey key) async {
//     print("keyRRRRRRRRRRRRrr: $key");
//     Future.delayed(const Duration(milliseconds: 300));
//     Scrollable.ensureVisible(
//       key.currentContext ?? context,
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//     );
//     setState(() {});
//     _getColor();
//   }
//
//   void _getColor() {
//     Future.delayed(const Duration(seconds: 3)).then((value) {
//       _borderColor = ColorSchemes.white;
//       setState(() {});
//     });
//   }
// }
//
class Item {
  final GlobalKey key;
  final String title;
  final int id;
  Item(this.key, this.title, this.id);
}
