import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomOtpFieldWidget extends StatefulWidget {
  final void Function(String value) onOtpChange;
  final void Function() verifyAction;
  final bool error;

  const CustomOtpFieldWidget({
    Key? key,
    required this.onOtpChange,
    required this.verifyAction,
    required this.error,
  }) : super(key: key);

  @override
  State<CustomOtpFieldWidget> createState() => _CustomOtpFieldWidgetState();
}

class _CustomOtpFieldWidgetState extends State<CustomOtpFieldWidget> {
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(4, (index) => FocusNode());
    _controllers = List.generate(
      4,
      (index) => TextEditingController(),
    );

    for (int i = 0; i < 4; i++) {
      _focusNodes[i].addListener(() {
        setState(() {});
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) => _buildOtpField(index),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  Widget _buildOtpField(int index) {
    return Container(
      width: 55,
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorSchemes.iconBackGround,
              border: Border.all(
                  color: widget.error == true
                      ? ColorSchemes.redError
                      : Colors.transparent),
              boxShadow: [
                BoxShadow(
                  color: ColorSchemes.black.withOpacity(0.2),
                  blurRadius: 24,
                  offset: const Offset(0, 4),
                  spreadRadius: 0,
                ),
              ],
            ),
          ),
          TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            maxLength: 1,
            onChanged: (value) {
              widget.onOtpChange(_getOtp());
              if (value.isNotEmpty) {
                if (index < 4 - 1) {
                  _focusNodes[index + 1].requestFocus();
                } else {
                  _focusNodes[index].unfocus();
                  widget.verifyAction();
                }
              } else {
                if (index > 0) {
                  _focusNodes[index - 1].requestFocus();
                }
              }
            },
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              FilteringTextInputFormatter.allow(RegExp('[0-9]')),
            ],
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorSchemes.primary),
            decoration: InputDecoration(
              border: InputBorder.none,
              counterText: "",
              hintText: "",
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(50),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getOtp() {
    return _controllers.map((controller) => controller.text).join();
  }
}
