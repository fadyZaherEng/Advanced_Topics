// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';

class ExpansioalPanelScreen extends StatefulWidget {
  const ExpansioalPanelScreen({super.key});

  @override
  _ExpansioalPanelScreenState createState() => _ExpansioalPanelScreenState();
}

class _ExpansioalPanelScreenState extends State<ExpansioalPanelScreen> {
  int activeIndex = -1;
  bool isActive = false;
  String exTitle = "Sport Categories";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expansioal Panel"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) =>
                  ExpansionPanelList(
                expansionCallback: (panelIndex, isExpanded) {
                  activeIndex = index;
                  isActive = isExpanded;
                  if (exTitle == "Sport Categories" && index == activeIndex) {
                    exTitle = "Contract";
                  } else {
                    exTitle = "Sport Categories";
                  }
                  setState(() {});
                },
                children: <ExpansionPanel>[
                  ExpansionPanel(
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        title: Text(exTitle),
                      );
                    },
                    backgroundColor: Colors.white,
                    body: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      spacing: 7,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.red;
                                }
                                return Colors.black;
                              },
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Cricket",
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            "Badminton",
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            "Football",
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            "Tennis",
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            "Swimming",
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            "Volleyball",
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            "Hockey",
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            "Basketball",
                          ),
                        ),
                      ],
                    ),
                    isExpanded: activeIndex == index && isActive,
                    canTapOnHeader: true,
                  )
                ],
              ),
              separatorBuilder: (BuildContext context, int index) =>
                  _separator(),
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }

  _separator() => const Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 1,
          ),
          SizedBox(height: 10)
        ],
      );
}
