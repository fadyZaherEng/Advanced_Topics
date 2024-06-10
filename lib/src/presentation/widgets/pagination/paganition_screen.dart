import 'package:flutter/material.dart';


class PaginationWidget extends StatefulWidget {
  const PaginationWidget({super.key});

  @override
  _PaginationWidgetState createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends State<PaginationWidget> {
  int currentPage = 0;
  final int itemsPerPage = 3; // Number of items per page
  final int pageNumberLimit = 3; // Number of page numbers to show
  final List<String> items = List.generate(50, (index) => 'Item ${index + 1}');

  @override
  Widget build(BuildContext context) {
    final totalPages = (items.length / itemsPerPage).ceil();

    int startPage = currentPage - (currentPage % pageNumberLimit);
    int endPage = startPage + pageNumberLimit;
    if (endPage > totalPages) {
      endPage = totalPages;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagination Example'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: (currentPage + 1) * itemsPerPage < items.length
                  ? itemsPerPage
                  : items.length % itemsPerPage,
              itemBuilder: (context, index) {
                int currentIndex = currentPage * itemsPerPage + index;
                return ListTile(
                  title: Text(items[currentIndex]),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: currentPage > 0
                    ? () {
                  setState(() {
                    currentPage--;
                  });
                }
                    : null,
                child: const Text('Previous'),
              ),
              const SizedBox(width: 10),
              Row(
                children: List.generate(endPage - startPage, (index) {
                  int pageIndex = startPage + index;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        currentPage = pageIndex;
                      });
                    },
                    child: Text('${pageIndex + 1}',style: TextStyle(color: currentPage == pageIndex ? Colors.blue : Colors.grey),),
                  );
                }),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: currentPage < totalPages - 1
                    ? () {
                  setState(() {
                    currentPage++;
                  });
                }
                    : null,
                child: const Text('Next'),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
