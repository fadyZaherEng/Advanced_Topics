import 'package:flutter/material.dart';

class CustomBtnAnim extends StatefulWidget {
  const CustomBtnAnim({super.key});

  @override
  State<CustomBtnAnim> createState() => _CustomBtnAnimState();
}

class ContainerDetails {
  double width;
  double height;
  double borderWidth;

  ContainerDetails(this.width, this.height, this.borderWidth);
}

AnimationController? animationController;

class _CustomBtnAnimState extends State<CustomBtnAnim>
    with SingleTickerProviderStateMixin {
  final double _width = 200;
  final double _height = 60;
  final Color _color = const Color(0xFF7bdcb5);
  final Color _border = const Color(0xFF00d084);
  bool _opacityBtn1 = false;
  bool _opacityBtn2 = false;
  bool _opacityBtn3 = false;
  Animation<ContainerDetails>? _animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 700,
      ),
    );
    _animation = Tween<ContainerDetails>(
      begin: ContainerDetails(0, 0, 0),
      end: ContainerDetails(200, 60, 3),
    ).animate(
      CurvedAnimation(
        parent: animationController!,
        curve: Curves.easeOutBack,
        reverseCurve: Curves.easeOutBack.flipped,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _customBtn1(),
            const SizedBox(
              height: 100,
            ),
            _customBtn2(),
            const SizedBox(
              height: 100,
            ),
            _customBtn3(),
            const SizedBox(
              height: 100,
            ),
            OutlineButtonTransition(
              borderWidth: _animation!,
            ),
          ],
        ),
      ),
    );
  }

  Widget _customBtn1() => InkWell(
        onTap: () {
          setState(() {
            _opacityBtn1 = !_opacityBtn1;
            Future.delayed(const Duration(
              milliseconds: 1500,
            )).then((value) {
              setState(() {
                _opacityBtn1 = !_opacityBtn1;
              });
            });
          });
        },
        child: SizedBox(
          height: _height,
          width: _width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(
                  milliseconds: 700,
                ),
                width: _width,
                height: _height,
                decoration: BoxDecoration(
                  color: _color,
                  border: Border.all(
                    width: 3,
                    color: _border,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 25,
                      offset: const Offset(-1, 0),
                      spreadRadius: 15,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "foo",
                    style: TextStyle(
                      color: _opacityBtn1 ? Colors.white : Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(
                  milliseconds: 700,
                ),
                opacity: _opacityBtn1 ? 1 : 0,
                child: Align(
                  alignment: const Alignment(1, -1),
                  child: AnimatedScale(
                    duration: const Duration(
                      milliseconds: 700,
                    ),
                    scale: _opacityBtn1 ? 1 : 0,
                    alignment: const Alignment(1, -1),
                    child: AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 700,
                      ),
                      width: _width,
                      height: 4,
                      decoration: BoxDecoration(
                        color: _color,
                        border: const Border(
                          top: BorderSide(
                            width: 3,
                            color: Colors.white,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 25,
                            offset: const Offset(1, -1),
                            spreadRadius: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(
                  milliseconds: 700,
                ),
                opacity: _opacityBtn1 ? 1 : 0,
                child: Align(
                  alignment: const Alignment(1, -1),
                  child: AnimatedScale(
                    duration: const Duration(
                      milliseconds: 700,
                    ),
                    scale: _opacityBtn1 ? 1 : 0,
                    alignment: const Alignment(1, -1),
                    child: AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 700,
                      ),
                      width: 3,
                      height: _height,
                      decoration: BoxDecoration(
                        color: _color,
                        border: const Border(
                          left: BorderSide(
                            width: 3,
                            color: Colors.white,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 25,
                            offset: const Offset(1, -1),
                            spreadRadius: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(
                  milliseconds: 700,
                ),
                opacity: _opacityBtn1 ? 1 : 0,
                child: Align(
                  alignment: const Alignment(-1, 1),
                  child: AnimatedScale(
                    duration: const Duration(
                      milliseconds: 700,
                    ),
                    scale: _opacityBtn1 ? 1 : 0,
                    alignment: const Alignment(-1, 1),
                    child: AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 700,
                      ),
                      width: _width,
                      height: 4,
                      decoration: BoxDecoration(
                        color: _color,
                        border: const Border(
                          bottom: BorderSide(
                            width: 3,
                            color: Colors.white,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 25,
                            offset: const Offset(-1, 1),
                            spreadRadius: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(
                  milliseconds: 700,
                ),
                opacity: _opacityBtn1 ? 1 : 0,
                child: Align(
                  alignment: const Alignment(-1, 1),
                  child: AnimatedScale(
                    duration: const Duration(
                      milliseconds: 700,
                    ),
                    scale: _opacityBtn1 ? 1 : 0,
                    alignment: const Alignment(-1, 1),
                    child: AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 700,
                      ),
                      width: 3,
                      height: _height,
                      decoration: BoxDecoration(
                        color: _color,
                        border: const Border(
                          right: BorderSide(
                            width: 3,
                            color: Colors.white,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 25,
                            offset: const Offset(-1, 1),
                            spreadRadius: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _customBtn2() => InkWell(
        onTap: () {
          _opacityBtn2 = !_opacityBtn2;
          setState(() {});
          Future.delayed(const Duration(
            milliseconds: 1500,
          )).then((value) => {
                setState(() {
                  _opacityBtn2 = !_opacityBtn2;
                })
              });
        },
        child: SizedBox(
          height: _height,
          width: _width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedOpacity(
                duration: const Duration(
                  milliseconds: 700,
                ),
                opacity: !_opacityBtn2 ? 1 : 0,
                child: Container(
                  height: _height,
                  width: _width,
                  decoration: BoxDecoration(
                    color: _color,
                    border: Border.all(
                      color: _border,
                      width: 3,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'curmudgeon',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              // if (opacity)
              AnimatedOpacity(
                duration: const Duration(
                  milliseconds: 700,
                ),
                opacity: _opacityBtn2 ? 1 : 0,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: _height - 2,
                    width: _width,
                    decoration: BoxDecoration(
                      color: _color,
                    ),
                    child: const Center(
                      child: Text(
                        'curmudgeon',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //if (opacity)
              AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: _opacityBtn2 ? 1 : 0,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 56,
                  ),
                  child: AnimatedScale(
                    duration: const Duration(
                      milliseconds: 700,
                    ),
                    scale: _opacityBtn2 ? 1 : 0,
                    alignment: const Alignment(-1, -1),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 25,
                            offset: const Offset(-1, 0),
                            spreadRadius: 15,
                          ),
                        ],
                      ),
                      height: 4,
                      width: _width,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _customBtn3() => InkWell(
        onTap: () {
          _opacityBtn3 = !_opacityBtn3;
          setState(() {});
          Future.delayed(const Duration(
            milliseconds: 1500,
          )).then((value) {
            _opacityBtn3 = !_opacityBtn3;
            setState(() {});
          });
        },
        child: SizedBox(
          height: _height,
          width: _width,
          child: Stack(
            children: [
              Container(
                height: _height,
                width: _width,
                decoration: BoxDecoration(
                  color: _color,
                  border: Border.all(
                    color: _border,
                    width: 3,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'bar',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(
                  milliseconds: 700,
                ),
                opacity: _opacityBtn3 ? 1 : 0,
                child: AnimatedAlign(
                  duration: const Duration(
                    milliseconds: 700,
                  ),
                  alignment: const Alignment(0, 0),
                  child: AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 700,
                    ),
                    height: _opacityBtn3 ? _height : 0,
                    width: _opacityBtn3 ? _width : 0,
                    decoration: BoxDecoration(
                      color: _color,
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'bar',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

class OutlineButtonTransition extends AnimatedWidget {
  Animation<ContainerDetails> get borderWidth =>
      listenable as Animation<ContainerDetails>;

  OutlineButtonTransition({super.key, borderWidth})
      : super(listenable: borderWidth);
  bool opacity = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //   opacity = !opacity;
        animationController!.forward(
          from: 0,
        );
        Future.delayed(const Duration(
          milliseconds: 1500,
        )).then(
          (value) {
            //     opacity = !opacity;
            animationController!.reverse(
              from: 1,
            );
          },
        );
      },
      child: SizedBox(
        height: 60,
        width: 200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 60,
              width: 200,
              decoration: BoxDecoration(
                color: const Color(0xFF7bdcb5),
                border: Border.all(
                  color: const Color(0xFF00d084),
                  width: 3,
                ),
              ),
              child: Center(
                child: Text(
                  "Foo",
                  style: TextStyle(
                    fontSize: 16,
                    color: opacity ? Colors.white : null,
                  ),
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(
                milliseconds: 700,
              ),
              height: borderWidth.value.height,
              width: borderWidth.value.width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: borderWidth.value.borderWidth,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
