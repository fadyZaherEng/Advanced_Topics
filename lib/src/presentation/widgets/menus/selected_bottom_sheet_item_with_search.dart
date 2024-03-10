import 'package:flutter/material.dart';
import 'package:spinner_dropdown/spinner.dart';
import 'package:spinner_dropdown/spinner_list_item.dart';

class SpinnerMenu extends StatelessWidget {
  const SpinnerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            SpinnerState(
              Spinner(
                bottomSheetTitle: const Text(
                  'Stops',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                submitButtonChild: const Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                data: [
                  SpinnerListItem(data: 'London'),
                  SpinnerListItem(data: 'New York')
                ],
                selectedItems: (List<dynamic> selectedList) {
                  List<String> list = [];
                  for (var item in selectedList) {
                    if (item is SpinnerListItem) {
                      list.add(item.data.toString());
                    }
                  }
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(list.toString())));
                },
                enableMultipleSelection: true,
              ),
            ).showModal(context);
          },
          child: const Text("Spinner Menu"),
        ),
      ),
    );
  }
}
