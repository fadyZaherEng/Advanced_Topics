import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';

class CustomButtonAnimationNew extends StatefulWidget {
  const CustomButtonAnimationNew({super.key});

  @override
  State<CustomButtonAnimationNew> createState() =>
      _CustomButtonAnimationNewState();
}

class _CustomButtonAnimationNewState extends State<CustomButtonAnimationNew> {
  double _height = 48;
  double _width = 200;
  bool _isAnimate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Button Animation'),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            setState(() {
              _isAnimate = !_isAnimate;
            });
          },
          child: Container(
            height: _height,
            width: _width,
            decoration: BoxDecoration(
              color: ColorSchemes.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                Container(
                  height: _height,
                  width: _width,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 350),
                        height: _isAnimate ? _height : 0,
                        width: _isAnimate ? _width : 0,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: ColorSchemes.white,
                            width: 1.3,
                          ),
                        ),
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
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 350),
                        height: _isAnimate ? _height : 0,
                        width: _isAnimate ? _width : 0,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: ColorSchemes.white,
                            width: 1.3,
                          ),
                        ),
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
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 350),
                        height: _isAnimate ? _height : 0,
                        width: _isAnimate ? _width : 0,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: ColorSchemes.white,
                            width: 1.3,
                          ),
                        ),
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
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 350),
                        height: _isAnimate ? _height : 0,
                        width: _isAnimate ? _width : 0,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: ColorSchemes.white,
                            width: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Text(
                    'Button Anim',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: ColorSchemes.white,
                          fontSize: 16,
                        ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
