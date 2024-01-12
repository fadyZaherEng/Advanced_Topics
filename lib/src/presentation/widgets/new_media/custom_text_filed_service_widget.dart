import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/utils/new/constants.dart';

class CustomTextFiledServiceWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  String? errorMessage;
  final void Function(String? value) onChanged;

  CustomTextFiledServiceWidget({
    super.key,
    required this.textEditingController,
    this.errorMessage,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "serviceAmount",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorSchemes.black,
                letterSpacing: -0.13,
              ),
        ),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
          ),
          controller: textEditingController,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: Constants.fontWeightRegular,
                color: ColorSchemes.black,
              ),
          onChanged: onChanged,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,}'))
          ],
          decoration: InputDecoration(
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
            errorText: errorMessage,
            hintText: "setAmount",
            // suffixIcon: Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     mainAxisSize: MainAxisSize.min,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Container(
            //         width: 1,
            //         height: 15,
            //         color: ColorSchemes.gray,
            //       ),
            //       const SizedBox(
            //         width: 5,
            //       ),
            //       Text(
            //         "EGP",
            //         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            //           color: ColorSchemes.black,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFFC7C4CC),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
            errorMaxLines: 2,
          ),
        ),
      ],
    );
  }

  Color _getBorderColor() {
    if (errorMessage == null) {
      return ColorSchemes.border;
    } else {
      return ColorSchemes.redError;
    }
  }
}
