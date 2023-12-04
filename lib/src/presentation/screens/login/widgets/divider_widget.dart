import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DividerWidget extends StatefulWidget {
  const DividerWidget({super.key});

  @override
  State<DividerWidget> createState() => _DividerWidgetState();
}

class _DividerWidgetState extends State<DividerWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width * 0.26,
          height: 1.h,
          decoration: const BoxDecoration(
            color: Color(0xffe0e0e0),
          ),
        ),
        const Text(
          "    Or sign in with    ",
          style: TextStyle(
            color: Color(0xffe0e0e0),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          width: MediaQuery.sizeOf(context).width * 0.26,
          height: 1.h,
          decoration: const BoxDecoration(
            color: Color(0xffe0e0e0),
          ),
        ),
      ],
    );
  }
}
