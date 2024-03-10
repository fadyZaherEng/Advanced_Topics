import 'package:flutter/material.dart';

class DropDownMenu extends StatefulWidget {
  const DropDownMenu({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  String dropdownvalue = 'Item 1';
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Drop Down Menu"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              value: dropdownvalue,

              icon: const Icon(Icons.keyboard_arrow_down),

              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
