import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/calender_props/event_screen/models.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/custom_radio_button_widget.dart';

class SortBottomSheetWidget extends StatelessWidget {
  final List<Sort> sorts;
  final Sort selectedSort;
  final Function(Sort) onSortSelected;

  const SortBottomSheetWidget({
    Key? key,
    required this.sorts,
    required this.selectedSort,
    required this.onSortSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: sorts.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                onSortSelected(sorts[index]);
              },
              child: Row(
                children: [
                  Text(
                    sorts[index].name,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          letterSpacing: -0.24,
                          color: ColorSchemes.black,
                        ),
                  ),
                  const Expanded(child: SizedBox()),
                  CustomRadioButtonWidget(
                    isSelected: selectedSort.id == sorts[index].id,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            sorts[index].id != 4
                ? Container(
                    color: ColorSchemes.border,
                    height: 1.5,
                    width: double.infinity,
                  )
                : const SizedBox.shrink(),
          ],
        );
      },
    );
  }
}
