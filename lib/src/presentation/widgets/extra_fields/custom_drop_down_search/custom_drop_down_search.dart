import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/extra_fields/custom_dropdown_text_field_with_label_widget.dart';

class CustomDropDownSearch extends StatelessWidget {
  const CustomDropDownSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomDropdownTextFieldWithLabelWidget(
        errorMessage: null,
        globalKey: GlobalKey(),
        title: "Student",
        controller: TextEditingController(),
        onTap: () {},
      ),
    );
  }
}
