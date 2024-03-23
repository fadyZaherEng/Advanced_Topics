import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/calender_props/event_screen/events_screen.dart';

class CalenderPropertyScreen extends StatefulWidget {
  const CalenderPropertyScreen({super.key});

  @override
  State<CalenderPropertyScreen> createState() => _CalenderPropertyScreenState();
}

class _CalenderPropertyScreenState extends State<CalenderPropertyScreen> {
  @override
  Widget build(BuildContext context) {
    return const EventsScreen();
  }
}
