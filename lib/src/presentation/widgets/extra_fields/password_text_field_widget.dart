
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/new/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PasswordTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String labelTitle;
  final String? errorMessage;
  final Function(String) onChange;
  final TextInputType textInputType;
  final bool showPrefix;

  const PasswordTextFieldWidget({
    Key? key,
    required this.controller,
    required this.labelTitle,
    required this.onChange,
    this.errorMessage,
    this.textInputType = TextInputType.text,
    this.showPrefix = false,
  }) : super(key: key);

  @override
  State<PasswordTextFieldWidget> createState() =>
      _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  bool _showPassword = true;
  String _passwordIcon = ImagePaths.showPassword;
  final FocusNode _focus = FocusNode();
  bool _textFieldHasFocus = false;

  @override
  void initState() {
    _focus.addListener(() {
      setState(() {
        _textFieldHasFocus = _focus.hasFocus;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focus,
      keyboardType: widget.textInputType,
      controller: widget.controller,
      onChanged: widget.onChange,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
          fontWeight: Constants.fontWeightRegular,
          color: ColorSchemes.black,
          letterSpacing: -0.13),
      obscureText: _showPassword,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorSchemes.border),
              borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorSchemes.border),
              borderRadius: BorderRadius.circular(12)),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorSchemes.redError),
              borderRadius: BorderRadius.circular(12)),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorSchemes.border),
              borderRadius: BorderRadius.circular(12)),
          errorText: widget.errorMessage,
          labelText: widget.labelTitle,
          prefixIcon: widget.showPrefix ? Padding(
            padding: const EdgeInsets.only(left: 28, right: 8),
            child: SvgPicture.asset(
             ImagePaths.passwordLock,
              color: ColorSchemes.gray,
            ),
          ): null,
          suffixIcon: IconButton(
            icon: SvgPicture.asset(_passwordIcon),
            onPressed: _toggleVisibilityIcon,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
          labelStyle: _labelStyle(context, _textFieldHasFocus),
          errorMaxLines: 2),
    );
  }

  void _toggleVisibilityIcon() {
    setState(() {
      _showPassword = !_showPassword;
      if (_showPassword) {
        _passwordIcon = ImagePaths.showPassword;
      } else {
        _passwordIcon = ImagePaths.headPassword;
      }
    });
  }

  TextStyle _labelStyle(BuildContext context, bool hasFocus) {
    if (hasFocus || widget.controller.text.isNotEmpty) {
      return Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: Constants.fontWeightRegular,
            color: widget.errorMessage == null
                ? ColorSchemes.gray
                : ColorSchemes.redError,
            letterSpacing: -0.13,
          );
    } else {
      return Theme.of(context).textTheme.titleSmall!.copyWith(
            fontWeight: Constants.fontWeightRegular,
            color: widget.errorMessage == null
                ? ColorSchemes.gray
                : ColorSchemes.redError,
            letterSpacing: -0.13,
          );
    }
  }

  @override
  void deactivate() {
    _focus.dispose();
    super.deactivate();
  }
}
