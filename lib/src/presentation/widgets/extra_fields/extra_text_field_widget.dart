import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/calender_props/event_screen/models.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/custom_text_form_widget.dart';

class ExtraTextFieldWidget extends StatefulWidget {
  final PageField pageField;
  final Function(String) addAnswer;
  final double verticalPadding;
  final double horizontalPadding;
  final bool updateAnswer;
  final bool showSeparator;

  const ExtraTextFieldWidget({
    Key? key,
    required this.pageField,
    required this.addAnswer,
    this.horizontalPadding = 16,
    this.verticalPadding = 16,
    this.updateAnswer = true,
    this.showSeparator = true,
  }) : super(key: key);

  @override
  State<ExtraTextFieldWidget> createState() => _ExtraTextFieldWidgetState();
}

class _ExtraTextFieldWidgetState extends State<ExtraTextFieldWidget> {
  TextEditingController controller = TextEditingController();

  @override
  void didUpdateWidget(covariant ExtraTextFieldWidget oldWidget) {
    if (widget.updateAnswer) {
      controller.text = widget.pageField.value;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    controller.text = widget.pageField.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: widget.pageField.key,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: widget.verticalPadding,
              horizontal: widget.horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.pageField.label,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: ColorSchemes.black),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                child: CustomTextFieldWidget(
                  controller: controller,
                  labelTitle: widget.pageField.description,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r' \s'),
                        replacementString: " "),
                  ],
                  onChange: (value) {
                    controller.text.trim();
                    widget.addAnswer(value.trim());
                  },
                  errorMessage: widget.pageField.notAnswered &&
                          widget.pageField.isRequired
                      ? "thisFieldIsRequired"
                      : !widget.pageField.isValid
                          ? widget.pageField.validationMessage
                          : null,
                ),
              ),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
        Visibility(
          visible: widget.showSeparator,
          child: const Divider(
            height: 1,
            color: ColorSchemes.gray,
          ),
        ),
      ],
    );
  }
}
