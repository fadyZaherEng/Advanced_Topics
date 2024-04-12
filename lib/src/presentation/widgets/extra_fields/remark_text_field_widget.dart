import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/utils/new_utils/constants.dart';

class RemarkTextFieldWidget extends StatelessWidget {
  final bool isRemarkValid;
  final TextEditingController remarkController;
  final Function(String) onRemarkChanged;
  final String text;
  final String? errorMassage;
  final GlobalKey globalKey;

  const RemarkTextFieldWidget({
    super.key,
    required this.isRemarkValid,
    required this.remarkController,
    required this.onRemarkChanged,
    required this.text,
    this.errorMassage,
    required this.globalKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      key: globalKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorSchemes.black,
              ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: errorMassage == null ? 100 : 125,
          child: TextField(
            keyboardType: TextInputType.text,
            controller: remarkController,
            onChanged: (value) {
              onRemarkChanged(value);
            },
            expands: true,
            maxLines: null,
            maxLength: 30,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: Constants.fontWeightRegular,
                color: ColorSchemes.black,
                letterSpacing: -0.13),
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              counterText: '',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: _getBorderColor()),
                  borderRadius: BorderRadius.circular(12)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: _getBorderColor()),
                  borderRadius: BorderRadius.circular(12)),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: _getBorderColor()),
                  borderRadius: BorderRadius.circular(12)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: _getBorderColor()),
                  borderRadius: BorderRadius.circular(12)),
              errorText: errorMassage,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: _getBorderColor(),
                    letterSpacing: -0.13,
                  ),
              errorMaxLines: 2,
            ),
          ),
        )
      ],
    );
  }

  Color _getBorderColor() {
    if (isRemarkValid) {
      return ColorSchemes.border;
    } else {
      return ColorSchemes.redError;
    }
  }
}
