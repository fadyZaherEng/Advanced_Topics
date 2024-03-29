import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/calender_props/event_screen/models.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/calender_props/event_screen/widgets/event_card_widget.dart';

class EventsWidget extends StatefulWidget {
  final List<HomeEventItem> events;
  final TextEditingController textEditingController;
  final Function(String) onSendAction;
  final Function(HomeEventItem, HomeEventOption) onActionSelected;
  final Function(String) onChange;
  final Function(HomeEventItem) onCardTap;
  final Function() onPullToRefresh;
  final Function(GlobalKey)? onScrollToItem;
  final int id;
  final Color borderColor;

  const EventsWidget({
    Key? key,
    required this.events,
    required this.textEditingController,
    required this.onSendAction,
    required this.onActionSelected,
    required this.onChange,
    required this.onCardTap,
    required this.onPullToRefresh,
    this.onScrollToItem,
    this.id = -1,
    this.borderColor = ColorSchemes.white,
  }) : super(key: key);

  @override
  State<EventsWidget> createState() => _EventsWidgetState();
}

class _EventsWidgetState extends State<EventsWidget> {
  var itemCount = 0;
  var _key;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () => widget.onPullToRefresh(),
        child: ListView.builder(
            itemCount: widget.events.length,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              itemCount++;
              if (widget.id != -1 && widget.events[index].id == widget.id) {
                _key = widget.events[index].key;
              }
              if (itemCount <= widget.events.length && _key != null) {
                widget.onScrollToItem!(_key);
              }
              return Column(
                children: [
                  EventCardWidget(
                    key: widget.events[index].key,
                    borderColor:
                        widget.events[index].id == widget.id && _key != null
                            ? widget.borderColor
                            : ColorSchemes.white,
                    textEditingController: widget.textEditingController,
                    width: double.infinity,
                    boxShadows: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.12),
                        blurRadius: 32,
                        spreadRadius: 0,
                        offset: Offset(0, 4),
                      ),
                    ],
                    onSelectAction: (value) {
                      widget.onActionSelected(widget.events[index], value);
                    },
                    onChange: widget.onChange,
                    selectedEventAction: widget.events[index].selectAction,
                    onSendAction: widget.onSendAction,
                    event: widget.events[index],
                    onCardTap: (event) {
                      widget.onCardTap(event);
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              );
            }),
      ),
    );
  }
}
