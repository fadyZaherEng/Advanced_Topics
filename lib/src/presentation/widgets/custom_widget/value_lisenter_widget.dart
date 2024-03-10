import 'package:flutter/material.dart';

class ValueLisenterScreen extends StatefulWidget {
  const ValueLisenterScreen({super.key});

  @override
  State<ValueLisenterScreen> createState() => _ValueLisenterScreenState();
}

class _ValueLisenterScreenState extends State<ValueLisenterScreen> {
  ValueNotifier<String> valueListener = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ValueListenableBuilder(
                valueListenable: valueListener,
                builder: (context, value, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        valueListener.value,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          valueListener.value = '';
                          setState(() {});
                        },
                        child: const Text('Clear'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          valueListener.value = 'value';
                        },
                        child: const Text('ValueLisenter'),
                      )
                    ],
                  );
                },
              ),
              // TextButton(
              //   onPressed: () {
              //     valueListener.value = 'value';
              //     setState(() {});
              //   },
              //   child: const Text('ValueLisenter'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
