import 'package:flutter/material.dart';

class CustomTextAnim extends StatefulWidget {
  const CustomTextAnim({super.key});

  @override
  State<CustomTextAnim> createState() => _CustomTextAnimState();
}

class _CustomTextAnimState extends State<CustomTextAnim> {
  bool _isAnimate = false;
  double? _height;
  double? _width;

  @override
  Widget build(BuildContext context) {
    final Size size = (TextPainter(
      text: TextSpan(
          text: "Flutter", style: Theme.of(context).textTheme.bodyLarge),
      maxLines: 1,
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
      textDirection: TextDirection.ltr,
    )..layout())
        .size;
    _height = size.height + 10;
    _width = size.width + 10;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter'),
      ),
      body: (_height == null || _width == null)
          ? const CircularProgressIndicator()
          : Center(
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isAnimate = !_isAnimate;
                  });
                  Future.delayed(const Duration(
                    milliseconds: 600,
                  )).then((value) => setState(() {
                        _isAnimate = !_isAnimate;
                      }));
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
                              milliseconds: 600,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: const Border(
                                top: BorderSide(
                                    color: Colors.blueAccent, width: 2),
                                right: BorderSide(
                                    color: Colors.blueAccent, width: 2),
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
                              milliseconds: 600,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: const Border(
                                bottom: BorderSide(
                                    color: Colors.blueAccent, width: 2),
                                left: BorderSide(
                                    color: Colors.blueAccent, width: 2),
                              ),
                            ),
                            height: _isAnimate ? _height : 0,
                            width: _isAnimate ? _width : 0,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Flutter",
                      style: TextStyle(
                          color: _isAnimate ? Colors.blue : Colors.white),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
