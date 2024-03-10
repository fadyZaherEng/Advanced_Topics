import 'package:flutter/material.dart';

class SubjectBehivourScreen extends StatefulWidget {
  const SubjectBehivourScreen({super.key});

  @override
  State<SubjectBehivourScreen> createState() => _SubjectBehivourScreenState();
}

class _SubjectBehivourScreenState extends State<SubjectBehivourScreen> {
  //in rx dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subject Behivour'),
      ),
      body: const Center(
        child: Text('Subject Behivour'),
      ),
    );
  }
}
