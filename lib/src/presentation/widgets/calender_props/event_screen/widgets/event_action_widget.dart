import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/calender_props/event_screen/models.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/button/custom_button_border_widget.dart';

class EventActionWidget extends StatelessWidget {
  final List<HomeEventOption> actions;
  final Function(HomeEventOption) onSelectAction;

  EventActionWidget(
      {Key? key, this.actions = const [], required this.onSelectAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: actions
                .map((element) => Row(
                      children: [
                        CustomButtonBorderWidget(
                          onTap: () {
                            onSelectAction(element);
                          },
                          buttonTitle: element.name,
                          isSelected: element.isSelectedByUser,
                        ),
                        const SizedBox(
                          width: 32,
                        )
                      ],
                    ))
                .toList(),
          ),
        ));
  }
}
