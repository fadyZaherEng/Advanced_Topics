import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/calender_props/calender_bloc/events_bloc.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/calender_props/event_screen/models.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/calender_props/event_screen/widgets/sort_bottom_sheet_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/bottom_sheet_widget.dart';

Future showSortsBottomSheet({
  required BuildContext context,
  required double height,
  required List<Sort> sorts,
  required Sort selectedSort,
  required Function(Sort) onSortSelected,
}) async {
  return await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    enableDrag: false,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: BottomSheetWidget(
        titleLabel: "Sort",
        height: height,
        content: SortBottomSheetWidget(
          sorts: sorts,
          selectedSort: selectedSort,
          onSortSelected: onSortSelected,
        ),
      ),
    ),
  );
}
