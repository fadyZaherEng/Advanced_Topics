import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/new/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChange;
  final Function() onClear;
  final String searchText;
  final bool isShowSuffixIcon;

  const SearchTextFieldWidget({
    Key? key,
    required this.controller,
    required this.onChange,
    required this.searchText,
    required this.onClear,
    this.isShowSuffixIcon = false,
  }) : super(key: key);

  @override
  State<SearchTextFieldWidget> createState() => _SearchTextFieldWidgetState();
}

class _SearchTextFieldWidgetState extends State<SearchTextFieldWidget> {
  bool _showHideClearIcon = false;
  final FocusNode _focus = FocusNode();
  bool _textFieldHasFocus = false;

  @override
  void initState() {
    _focus.addListener(() {
      setState(() {
        _textFieldHasFocus = _focus.hasFocus;
      });
    });
    widget.controller.addListener(() {
      if (widget.controller.text.isEmpty) {
          _showHideClearIcon = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        focusNode: _focus,
        keyboardType: TextInputType.text,
        controller: widget.controller,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onChanged: (value) {
          _onChange(value);
          widget.onChange(value);
        },
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: ColorSchemes.black, letterSpacing: -0.13),
        decoration: InputDecoration(
          filled: true,
          fillColor: ColorSchemes.gray,
          focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: ColorSchemes.gray),
              borderRadius: BorderRadius.circular(16)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: ColorSchemes.gray),
              borderRadius: BorderRadius.circular(16)),
          border: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: ColorSchemes.gray),
              borderRadius: BorderRadius.circular(16)),
          hintText: widget.searchText,
          hintStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: ColorSchemes.gray, letterSpacing: -0.13),
          prefixIconConstraints:
              const BoxConstraints(maxHeight: 40, maxWidth: 40),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: SvgPicture.asset(
                matchTextDirection: true,
                ImagePaths.search,
                width: 30,
                height: 30),
          ),
          suffixIcon: InkWell(
            onTap: () {
              _onClear();
              widget.onClear();
            },
            child: _showHideClearIcon
                ? Padding(
                    padding: const EdgeInsets.only(
                        left: 10, bottom: 5, right: 10, top: 5),
                    child: SvgPicture.asset(
                      fit: BoxFit.scaleDown,
                      ImagePaths.close,
                      width: 18,
                      height: 18,
                    ),
                  )
                : const SizedBox(),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
          labelStyle: _labelStyle(context, _textFieldHasFocus),
        ));
  }

  void _onClear() {
    setState(() {
      _showHideClearIcon = false;
      widget.controller.clear();
    });
  }

  void _onChange(String value) {
    setState(() {
      if (value.trim().isNotEmpty) {
        _showHideClearIcon = true;
      } else {
        _showHideClearIcon = false;
      }
    });
  }

  TextStyle _labelStyle(BuildContext context, bool hasFocus) {
    if (hasFocus || widget.controller.text.isNotEmpty) {
      return Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: Constants.fontWeightRegular,
            color: ColorSchemes.gray,
            letterSpacing: -0.13,
          );
    } else {
      return Theme.of(context).textTheme.titleSmall!.copyWith(
            fontWeight: Constants.fontWeightRegular,
            color: ColorSchemes.gray,
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
