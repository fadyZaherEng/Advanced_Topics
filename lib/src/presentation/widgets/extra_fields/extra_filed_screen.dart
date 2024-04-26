import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/dynamic_questions/bloc_dynamic_questions/dynamic_questions_event.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/extra_fields/custom_text_field_with_button_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/extra_fields/custom_date_picker_text_field_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/extra_fields/custom_mobile_number_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/extra_fields/custom_text_field_with_suffix_icon_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/extra_fields/custom_text_form_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/extra_fields/date_text_field_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/extra_fields/extra_text_field_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/extra_fields/multi_selection_field_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/extra_fields/numaric_text_field_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/extra_fields/password_text_field_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/extra_fields/search_text_field_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/extra_fields/searchable_field_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/extra_fields/signle_selection_field_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/extra_fields/upload_image_field_widget.dart';

class ExtraFiledWidget extends StatefulWidget {
  const ExtraFiledWidget({super.key});

  @override
  State<ExtraFiledWidget> createState() => _ExtraFiledWidgetState();
}

class _ExtraFiledWidgetState extends State<ExtraFiledWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Extra Filed'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DateTextFieldWidget(
                pageField: PageField(),
                pickDate: (date) {},
                deleteDate: () {},
                horizontalPadding: 16,
                verticalPadding: 16,
                showSeparator: true),
            const SizedBox(height: 16),
            ExtraTextFieldWidget(
              pageField: PageField(),
              addAnswer: (value) {},
            ),
            const SizedBox(height: 16),
            CustomDatePickerTextFieldWidget(
              controller: TextEditingController(),
              labelTitle: "Date",
              onTap: () {},
            ),
            const SizedBox(height: 16),
            CustomMobileNumberWidget(
              controller: TextEditingController(),
              labelTitle: "Mobile Number",
              onChange: (value, isValid) {},
            ),
            const SizedBox(height: 16),
            CustomTextFieldWidget(
              controller: TextEditingController(),
              labelTitle: "Text Field",
              onChange: (value) {},
            ),
            const SizedBox(height: 16),
            CustomTextFieldWithButtonWidget(
              controller: TextEditingController(),
              labelTitle: "Text Field",
              onChange: (value) {},
              buttonOnTap: () {},
            ),
            const SizedBox(height: 16),
            CustomTextFieldWithSuffixIconWidget(
              controller: TextEditingController(),
              labelTitle: "Text Field",
              onTap: () {},
              onChanged: (v) {},
              suffixIcon: const Icon(Icons.calendar_month),
            ),
            const SizedBox(height: 16),
            MultiSelectionFieldWidget(
              pageField: PageField(),
              selectAnswer: (int index) {},
            ),
            const SizedBox(height: 16),
            NumericTextFieldWidget(
              pageField: PageField(),
              addAnswer: (value) {},
            ),
            const SizedBox(height: 16),
            PasswordTextFieldWidget(
              controller: TextEditingController(),
              labelTitle: "Text Field",
              onChange: (value) {},
            ),
            const SizedBox(height: 16),
            SearchTextFieldWidget(
              controller: TextEditingController(),
              onChange: (value) {},
              searchText: "",
              onClear: () {},
            ),
            const SizedBox(height: 16),
            SearchableFieldWidget(
              pageField: PageField(),
              openBottomSheet: () {},
            ),
            const SizedBox(height: 16),
            SingleSelectionFieldWidget(
              pageField: PageField(),
              selectAnswer: (int index) {},
            ),
            const SizedBox(height: 16),
            MultiSelectionFieldWidget(
              pageField: PageField(),
              selectAnswer: (int index) {},
            ),
            const SizedBox(height: 16),
            UploadImageFieldWidget(
              pageField: PageField(),
              showUploadImageBottomSheet: () {},
              showDialogToDeleteImage: () {},
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
