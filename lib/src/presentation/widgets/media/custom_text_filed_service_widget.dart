import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/utils/new/constants.dart';

class CustomTextFiledServiceWidget extends StatelessWidget {
  final String serviceTitle;
  final TextEditingController textEditingController;
  String? errorMessage;
  final void Function(String? value) onChanged;

  CustomTextFiledServiceWidget({
    super.key,
    required this.textEditingController,
    required this.serviceTitle,
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
          serviceTitle,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: ColorSchemes.black,
                fontSize: 14,
                fontFamily: "Montserrat",
                fontWeight: Constants.fontWeightBold,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
          ),
          controller: textEditingController,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: Constants.fontWeightRegular,
              color: ColorSchemes.black),
          onChanged: onChanged,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,}'))
          ],
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: ColorSchemes.border),
                borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: ColorSchemes.border,
                ),
                borderRadius: BorderRadius.circular(12)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: ColorSchemes.redError),
                borderRadius: BorderRadius.circular(12)),
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: ColorSchemes.border),
                borderRadius: BorderRadius.circular(12)),
            errorText: errorMessage,
            hintText: "Set Amount",
            suffixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 1,
                    height: 15,
                    color: ColorSchemes.gray,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "EGP",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: const Color(0xFF222222),
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          fontFamily: "Montserrat",
                        ),
                  ),
                ],
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFFC7C4CC),
                  fontSize: 12,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w400,
                ),
            errorMaxLines: 2,
          ),
        ),
      ],
    );
  }
}
