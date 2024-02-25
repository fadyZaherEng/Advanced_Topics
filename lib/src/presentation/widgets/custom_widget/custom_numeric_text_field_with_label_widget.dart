import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_topics/generated/l10n.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/custom_text_form_widget.dart';

class CustomNumericTextFieldWithLabelWidget extends StatefulWidget {
  final String title;
  final String? errorMassage;
  final GlobalKey globalKey;
  final TextEditingController controller;
  final String label;
  final void Function(String value) onChange;
  final bool hasMaxDays;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;

  final String maxDays;

  const CustomNumericTextFieldWithLabelWidget(
      {Key? key,
      required this.title,
      this.errorMassage,
      required this.globalKey,
      this.label = '',
      required this.onChange,
      required this.controller,
      this.hasMaxDays = false,
      this.readOnly = false,
      this.maxDays = '',
      this.inputFormatters})
      : super(key: key);

  @override
  State<CustomNumericTextFieldWithLabelWidget> createState() =>
      _CustomNumericTextFieldWithLabelWidgetState();
}

class _CustomNumericTextFieldWithLabelWidgetState
    extends State<CustomNumericTextFieldWithLabelWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      key: widget.globalKey,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: ColorSchemes.black),
                ),
                const SizedBox(width: 12),
                Visibility(
                  visible: widget.hasMaxDays,
                  child: Text(
                    "${"S.of(context).maximumDays"} =${widget.maxDays}",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: ColorSchemes.redError),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              child: CustomTextFieldWidget(
                readOnly: widget.readOnly,
                controller: widget.controller,
                labelTitle: widget.label,
                onChange: (value) => widget.onChange(value),
                inputFormatters: widget.inputFormatters,
                textInputType: TextInputType.number,
                errorMessage: widget.errorMassage,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
