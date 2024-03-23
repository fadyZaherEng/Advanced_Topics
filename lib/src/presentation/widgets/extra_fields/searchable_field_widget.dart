import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/calender_props/event_screen/models.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_text_field_with_suffix_icon_widget/custom_text_field_with_suffix_icon_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchableFieldWidget extends StatefulWidget {
  final PageField pageField;
  final Function() openBottomSheet;
  final double verticalPadding;
  final double horizontalPadding;
  final bool showSeparator;

  const SearchableFieldWidget({
    Key? key,
    required this.pageField,
    required this.openBottomSheet,
    this.horizontalPadding = 16,
    this.verticalPadding = 16,
    this.showSeparator = true,
  }) : super(key: key);

  @override
  State<SearchableFieldWidget> createState() => _SearchableFieldWidgetState();
}

class _SearchableFieldWidgetState extends State<SearchableFieldWidget> {
  TextEditingController controller = TextEditingController();

  @override
  void didUpdateWidget(covariant SearchableFieldWidget oldWidget) {
    controller.text = "";
    widget.pageField.choices.forEach((element) {
      if (element.isSelected) {
        controller.text = controller.text.isEmpty
            ? element.value
            : "${controller.text},${element.value}";
      }
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    widget.pageField.choices.forEach((element) {
      if (element.isSelected) {
        controller.text = controller.text.isEmpty
            ? element.value
            : "${controller.text},${element.value}";
      }
    });
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
            horizontal: widget.horizontalPadding,
          ),
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
                child: CustomTextFieldWithSuffixIconWidget(
                    isReadOnly: true,
                    controller: controller,
                    labelTitle: widget.pageField.description,
                    textInputType: TextInputType.text,
                    errorMessage: widget.pageField.notAnswered &&
                            widget.pageField.isRequired
                        ? "thisFieldIsRequired"
                        : null,
                    suffixIcon: SvgPicture.asset(
                      ImagePaths.arrowDown,
                      fit: BoxFit.scaleDown,
                      matchTextDirection: true,
                    ),
                    onTap: () {
                      widget.openBottomSheet();
                    },
                    onChanged: (value) {
                      controller.text.trim();
                    }),
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
