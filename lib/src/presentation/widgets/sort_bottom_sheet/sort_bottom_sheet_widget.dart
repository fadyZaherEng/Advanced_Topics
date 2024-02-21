import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/presentation/widgets/custom_radio_tile_list_item_widget.dart';
import 'package:flutter/material.dart';

class SortBottomSheetWidget extends StatefulWidget {
  final List<Sort> sorts;
  Sort selectedSort;
  final Function(Sort) onChange;
  final Function() onClear;
  SortBottomSheetWidget({
    Key? key,
    required this.sorts,
    required this.selectedSort,
    required this.onChange,
    required this.onClear,
  }) : super(key: key);

  @override
  State<SortBottomSheetWidget> createState() => _SortBottomSheetWidgetState();
}

class _SortBottomSheetWidgetState extends State<SortBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => _divider(),
      itemCount: widget.sorts.length,
      itemBuilder: (context, index) => CustomRadioListTileWidget(
        title: widget.sorts[index].name,
        id: widget.sorts[index].id,
        imagePath: widget.sorts[index].imagePath,
        groupValue: widget.selectedSort.id,
        onChange: (value) {
          widget.selectedSort = widget.sorts[value];
          setState(() {});
          widget.onChange(widget.selectedSort);
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _divider() => const Divider(
        color: ColorSchemes.gray,
        thickness: 0.2,
      );
}

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
