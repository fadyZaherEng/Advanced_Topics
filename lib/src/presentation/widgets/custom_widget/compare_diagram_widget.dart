import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/compare_diagram_item_widget.dart';

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
