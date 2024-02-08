import 'package:flutter/material.dart';

class CustomBtnAnim extends StatefulWidget {
  const CustomBtnAnim({super.key});

  @override
  State<CustomBtnAnim> createState() => _CustomBtnAnimState();
}

class _CustomBtnAnimState extends State<CustomBtnAnim>
    with SingleTickerProviderStateMixin {
  bool _isAnimate = false;

  double _height = 60;
  double _width = 120;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter'),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            setState(() {
              _isAnimate = !_isAnimate;
              Future.delayed(const Duration(
                milliseconds: 700,
              )).then((value) {
                setState(() {
                  _isAnimate = !_isAnimate;
                });
              });
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: _height,
                width: _width,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 700,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: const Border(
                          top: BorderSide(color: Colors.blueAccent, width: 2),
                          right: BorderSide(color: Colors.blueAccent, width: 2),
                        ),
                      ),
                      height: _isAnimate ? _height : 0,
                      width: _isAnimate ? _width : 0,
                    ),
                  ],
                ),
              ),
              Container(
                height: _height,
                width: _width,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 700,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: const Border(
                          bottom:
                              BorderSide(color: Colors.blueAccent, width: 2),
                          left: BorderSide(color: Colors.blueAccent, width: 2),
                        ),
                      ),
                      height: _isAnimate ? _height : 0,
                      width: _isAnimate ? _width : 0,
                    ),
                  ],
                ),
              ),
              Text(
                "Text",
                style:
                    TextStyle(color: _isAnimate ? Colors.blue : Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
