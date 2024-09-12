import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';

class CustomButtonAnimationFilter extends StatefulWidget {
  const CustomButtonAnimationFilter({super.key});

  @override
  State<CustomButtonAnimationFilter> createState() =>
      _CustomButtonAnimationFilterState();
}

class _CustomButtonAnimationFilterState extends State<CustomButtonAnimationFilter> {
  final double _height = 48;
  final double _width = 200;
  bool _isAnimate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Button Filter Animation'),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            setState(() {
              _isAnimate = !_isAnimate;
              Future.delayed(const Duration(milliseconds: 500)).then((value) {
                _isAnimate = !_isAnimate;
                setState(() {});
              });
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
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        height: _isAnimate ? _height : 0,
                        width: _isAnimate ? _width : 0,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: const BorderDirectional(
                            bottom: BorderSide(
                              color: ColorSchemes.white,
                              width: 2,
                            ),
                            start: BorderSide(
                              color: ColorSchemes.white,
                              width: 2,
                            ),

                          )
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
                        duration: const Duration(milliseconds: 500),
                        height: _isAnimate ? _height : 0,
                        width: _isAnimate ? _width : 0,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: const BorderDirectional(
                            top: BorderSide(
                              color: ColorSchemes.white,
                              width: 2,
                            ),
                            end: BorderSide(
                              color: ColorSchemes.white,
                              width: 2,
                            ),
                          )
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Text(
                    'Button Filter',
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
