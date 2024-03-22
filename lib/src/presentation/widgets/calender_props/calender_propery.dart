import 'package:flutter/material.dart';

class CalenderPropertyScreen extends StatefulWidget {
  const CalenderPropertyScreen({super.key});

  @override
  State<CalenderPropertyScreen> createState() => _CalenderPropertyScreenState();
}

class _CalenderPropertyScreenState extends State<CalenderPropertyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calender Property"),
      ),
    );
  }
}
