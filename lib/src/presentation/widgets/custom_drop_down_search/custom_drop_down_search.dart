import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/base/widget/base_stateful_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_drop_down_search/search_bottom_sheet_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/extra_fields/custom_dropdown_text_field_with_label_widget.dart';

import '../../../core/utils/new_utils/show_bottom_sheet_widget.dart';


class CustomDropDownSearch extends BaseStatefulWidget {
  const CustomDropDownSearch({super.key});

  @override
  BaseState<CustomDropDownSearch> baseCreateState() => _CustomDropDownSearchState();
}

class _CustomDropDownSearchState extends BaseState<CustomDropDownSearch> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomDropdownTextFieldWithLabelWidget(
          errorMessage: null,
          globalKey: GlobalKey(),
          title: "Student",
          controller: _controller,
          onTap: () {
            _showSearchBottomSheet(context);
          },
        ),
      ),
    );
  }

  void _showSearchBottomSheet(BuildContext context) {
    showBottomSheetWidget(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.6,
      context: context,
      content: SearchBottomSheetWidget(
        choices:const [
          "Sayed",
          "Ali",
          "Ahmed",
          "Hassan",
          "Abdulrahman",
          "Ahmad",
          "Ahmad",
          "Hassan",
          "Abdulrahman",
          "Ahmad",
          "Hassan",
          "Abdulrahman",
          "Ahmad",
          "Hassan",
          "Abdulrahman",

        ],
         onClosed: () {
          Navigator.pop(context);
        },
        onSearch: (value) {
          print(value);
          _controller.text = value;
        },
        onTap: (value) {
          print(value);
          _controller.text = value;
        },
      ),
       titleLabel: "Student",
      isTitleVisible: true,
    );
  }
}
