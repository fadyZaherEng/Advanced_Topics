import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/button/custom_button_border_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/dynamic_questions/bloc_dynamic_questions/dynamic_questions_event.dart';

class SingleSelectionFieldWidget extends StatefulWidget {
  final PageField pageField;
  final Function(int) selectAnswer;
  final double verticalPadding;
  final double horizontalPadding;
  final bool showSeparator;
  final bool isClearSelection;

  const SingleSelectionFieldWidget({
    Key? key,
    required this.pageField,
    required this.selectAnswer,
    this.verticalPadding = 16,
    this.horizontalPadding = 16,
    this.showSeparator = true,
    this.isClearSelection = false,
  }) : super(key: key);

  @override
  State<SingleSelectionFieldWidget> createState() =>
      _SingleSelectionFieldWidgetState();
}

class _SingleSelectionFieldWidgetState
    extends State<SingleSelectionFieldWidget> {
  late PageField _pageField;

  @override
  void initState() {
    _pageField = widget.pageField;
    if (widget.isClearSelection) {
      for (var i = 0; i < _pageField.choices.length; i++) {
        _pageField.choices[i] = _pageField.choices[i].copyWith(
          isSelected: false,
        );
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: _pageField.key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: widget.verticalPadding,
            horizontal: widget.horizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _pageField.label ?? "",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: ColorSchemes.black),
              ),
              const SizedBox(height: 16.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _pageField.choices
                      .map((answer) => Row(
                            children: [
                              CustomButtonBorderWidget(
                                onTap: () {
                                  widget.selectAnswer(answer.id);
                                },
                                buttonTitle: answer.value,
                                isSelected: answer.isSelected,
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                            ],
                          ))
                      .toList(),
                ),
              ),
              Visibility(
                visible: _pageField.notAnswered && _pageField.isRequired,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "thisFieldIsRequired",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: ColorSchemes.redError,
                            letterSpacing: -.24,
                          ),
                    ),
                  ],
                ),
              ),
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
