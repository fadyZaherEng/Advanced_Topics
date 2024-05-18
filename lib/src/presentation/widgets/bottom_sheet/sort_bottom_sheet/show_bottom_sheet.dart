import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/new_media/show_bottom_sheet_widget.dart';

class Sort {
  final int id;
  final String name;

  final String imagePath;

  Sort(
    this.id,
    this.name,
    this.imagePath,
  );
}

List<Sort> sorts = [
  Sort(0, "priceLowToHigh", ImagePaths.icSortAscending),
  Sort(1, "priceHighToLow,", ImagePaths.icSortDescending),
  Sort(2, "DateNewestOlder", ImagePaths.icRecentAdded),
  Sort(3, "DateOldestNewer", ImagePaths.icOldDate),
];
Sort selectedSort =
    Sort(0, "priceLowToHigh", ImagePaths.icSortAscending);

void _showSortBottomSheet({required BuildContext context}) {
  showBottomSheetWidget(
    context: context,
    height: 273,
    isDismissible: false,
    isPadding: false,
    content: SortBottomSheetWidget(
      sorts: sorts,
      selectedSort: selectedSort,
      onChange: (value) {
        selectedSort = value;
        //  setState(() {});
      },
      onClear: () {},
    ),
    onClose: () {
      Navigator.pop(context);
    },
    titleLabel: "S.of(context).sort",
  );
}
