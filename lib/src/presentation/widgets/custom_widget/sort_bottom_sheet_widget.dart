import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/generated/l10n.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SortBottomSheetWidget extends StatelessWidget {
  final List<Sort> sorts;
  final Sort selectedSort;

  const SortBottomSheetWidget({
    Key? key,
    required this.sorts,
    required this.selectedSort,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => _divider(),
      itemCount: sorts.length,
      itemBuilder: (context, index) => CustomRadioListTileWidget(
        title: sorts[index].name,
        id: sorts[index].id,
        imagePath: sorts[index].imagePath,
        groupValue: selectedSort.id,
        onChange: (value) {
          Navigator.pop(context, sorts[index]);
        },
      ),
    );
  }

  Widget _divider() => const Divider(
        color: ColorSchemes.gray,
        thickness: 0.2,
      );
}

class CustomRadioListTileWidget extends StatelessWidget {
  final int groupValue;
  final String imagePath;
  final String title;
  final int id;
  final Function(dynamic) onChange;

  const CustomRadioListTileWidget({
    Key? key,
    required this.title,
    required this.id,
    required this.groupValue,
    required this.onChange,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChange(id),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(imagePath),
            SizedBox(width: 8),
            Text(title),
            const Expanded(child: SizedBox()),
            RadioButtonWidget(
              value: id,
              groupValue: groupValue,
              onChanged: onChange,
            )
          ],
        ),
      ),
    );
  }
}

class RadioButtonWidget<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final String label;
  final ValueChanged<T> onChanged;

  const RadioButtonWidget(
      {Key? key,
      required this.value,
      required this.groupValue,
      this.label = "",
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;
    return InkWell(
      onTap: () => onChanged(value),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: ShapeDecoration(
                shape: CircleBorder(
                  side: BorderSide(
                    color:
                        isSelected ? ColorSchemes.primary : ColorSchemes.white,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(1.5),
                child: Container(
                  decoration: ShapeDecoration(
                    shape: CircleBorder(
                      side: BorderSide(
                        color: isSelected
                            ? ColorSchemes.primary
                            : ColorSchemes.gray,
                      ),
                    ),
                    color:
                        isSelected ? ColorSchemes.primary : ColorSchemes.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              label.toString(),
              style: TextStyle(
                color: isSelected ? ColorSchemes.primary : ColorSchemes.gray,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Sort {
  final int id;
  final String name;
  final String sortColumn;
  final String columnDirection;
  final String imagePath;

  Sort(
    this.id,
    this.name,
    this.sortColumn,
    this.columnDirection,
    this.imagePath,
  );
}

List<Sort> sorts = [
  Sort(
    0,
    S.current.sortAscending,
    "projectName",
    "asc",
    ImagePaths.icSortAscending,
  ),
  Sort(
    1,
    S.current.sortDescending,
    "projectName",
    "desc",
    ImagePaths.icSortDescending,
  ),
  Sort(
    2,
    S.current.recentlyAdded,
    "creationDate",
    "asc",
    ImagePaths.icRecentAdded,
  ),
  Sort(
    3,
    S.current.oldDate,
    "creationDate",
    "desc",
    ImagePaths.icOldDate,
  ),
];
