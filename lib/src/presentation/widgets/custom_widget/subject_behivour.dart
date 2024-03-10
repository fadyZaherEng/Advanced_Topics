import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SubjectBehivourScreen extends StatefulWidget {
  const SubjectBehivourScreen({super.key});

  @override
  State<SubjectBehivourScreen> createState() => _SubjectBehivourScreenState();
}

class _SubjectBehivourScreenState extends State<SubjectBehivourScreen> {
  //in rx dart
  final _subject = PublishSubject<int>();
  final _SubjectBehivour = BehaviorSubject<String>();

  @override
  void initState() {
    super.initState();
    _subject.add(1);
    _subject.add(2);
    _subject.add(3);
    _subject.stream.listen((event) {
      print(event);
    }); //

    _SubjectBehivour.add('1');
    _SubjectBehivour.add('2');
    _SubjectBehivour.add('3');

    _SubjectBehivour.stream.listen((event) {
      print(event);
    });
  }

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
