import 'package:city_eye/src/domain/entities/home/city_eye/choice.dart';
import 'package:city_eye/src/presentation/widgets/compare_diagram_item_widget.dart';
import 'package:flutter/material.dart';

class CompareDiagramWidget extends StatelessWidget {
  final List<HomeChoice> choice;

  const CompareDiagramWidget({
    super.key,
    required this.choice,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: choice.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return CompareDiagramItemWidget(
          choice: choice[index],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 20,
      ),
    );
  }
}
