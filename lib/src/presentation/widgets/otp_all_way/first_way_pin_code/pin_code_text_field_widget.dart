import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';

class CustomOtpFieldWidget extends StatefulWidget {
  final List<TextEditingController>? controllers;
  final void Function(String value) onOtpChange;
  final bool error;
  final String errorMessage;

  const CustomOtpFieldWidget({
    Key? key,
    this.controllers = const [],
    required this.onOtpChange,
    required this.error,
    required this.errorMessage,
  }) : super(key: key);

  @override
  State<CustomOtpFieldWidget> createState() => _CustomOtpFieldWidgetState();
}

class _CustomOtpFieldWidgetState extends State<CustomOtpFieldWidget> {
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;
  bool _waiting = false;
  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(
      6,
      (index) => FocusNode(
        onKeyEvent: (node, event) {
          if (event.logicalKey == LogicalKeyboardKey.backspace && _waiting) {
            _controllers[index - 1].text = "";
            _focusNodes[index - 1].requestFocus();
            widget.onOtpChange(_getOtp());
            _waiting = false;
            _delay();
            return KeyEventResult.ignored;
          }
          return KeyEventResult.ignored;
        },
      ),
    );
    _controllers = widget.controllers ?? [];
    for (int i = 0; i < 6; i++) {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            6,
            (index) => _buildOtpField(index),
          ),
        ),
        if (widget.errorMessage.isNotEmpty) ...[
          const SizedBox(height: 22.0),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: Text(
              widget.errorMessage,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: ColorSchemes.redError),
            ),
          )
        ]
      ],
    );
  }

  @override
  void dispose() {
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  Widget _buildOtpField(int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.12,
      height: 55,
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.01),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 55,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorSchemes.iconBackGround,
              border: Border.all(
                color: widget.error == true
                    ? ColorSchemes.redError
                    : Colors.transparent,
              ),
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
            autofocus: false,
            onChanged: (value) {
              _waiting = true;
              widget.onOtpChange(_getOtp());
              if (value.isNotEmpty) {
                if (index < 6 - 1) {
                  _focusNodes[index + 1].requestFocus();
                } else {
                  _focusNodes[index].unfocus();
                }
              } else {
                if (index > 0) {
                  _focusNodes[index - 1].requestFocus();
                }
              }
            },
            keyboardType: TextInputType.number,
            inputFormatters: [
              // Number only
              FilteringTextInputFormatter.digitsOnly
            ],
            textAlign: TextAlign.center,
            style: const TextStyle(
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

  void _delay() async {
    await Future.delayed(const Duration(milliseconds: 200)).then((value) {
      _waiting = true;
    });
  }
}
