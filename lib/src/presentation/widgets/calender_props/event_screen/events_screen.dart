import 'dart:async';
import 'dart:io';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/base/widget/base_stateful_widget.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/new/permission_service_handler.dart';
import 'package:flutter_advanced_topics/src/core/utils/new/show_action_dialog_widget.dart';
import 'package:flutter_advanced_topics/src/core/utils/new/show_massage_dialog_widget.dart';
import 'package:flutter_advanced_topics/src/core/utils/show_bottom_sheet.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/calender_props/calender_bloc/events_bloc.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/calender_props/event_screen/models.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/calender_props/event_screen/skeleton/skeleton_events_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/calender_props/event_screen/utils/show_sort_bottom_sheet.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/calender_props/event_screen/widgets/events_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/build_app_bar_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/custom_empty_list_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

class EventsScreen extends BaseStatefulWidget {
  final int id;

  const EventsScreen({this.id = -1, Key? key}) : super(key: key);

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _EventsScreenState();
}

class _EventsScreenState extends BaseState<EventsScreen> {
  EventsBloc get _bloc => BlocProvider.of<EventsBloc>(context);
  final DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();

  final TextEditingController _searchTextEditingController =
      TextEditingController();

  List<PageField> answeredQuestions = [];
  List<HomeEventItem> filteredEvents = [];

  EventData _eventData =
      EventData(events: const [], dynamicQuestions: const []);

  String calendarId = '';

  Color borderColor = ColorSchemes.primary;
  var itemCount = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _bloc.add(GetEventsEvent());
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<EventsBloc, EventsState>(
      listener: (context, state) {
        if (state is ShowLoadingState) {
          showLoading();
        } else if (state is HideLoadingState) {
          hideLoading();
        } else if (state is GetEventsSuccessState) {
          _eventData = state.events;
          filteredEvents = state.events.events;
          _bloc.add(SearchEventsEvent(
              value: _searchTextEditingController.text.trim()));
        } else if (state is UpdateEventActionState) {
          _eventData.events = state.events;
          filteredEvents = state.events;
        } else if (state is NavigateBackState) {
          Navigator.pop(context, state.events);
        } else if (state is CheckForDynamicQuestionState) {
          if (!state.eventAction.isSelectedByUser) {
            if (state.questionsList.isNotEmpty) {
              _openDynamicQuestionBottomSheet(
                questions: state.questionsList,
                event: state.event,
                eventAction: state.eventAction,
              );
            } else {
              if (state.eventAction.isCalendar && Platform.isAndroid) {
                _bloc.add(ShowCalendarActionDialogEvent(
                    event: state.event, eventAction: state.eventAction));
              } else {
                if (state.event.calenderRef != "") {
                  _deleteFromCalenderEvent(
                      event: state.event,
                      eventAction: state.eventAction,
                      eventId: state.event.calenderRef);
                } else {
                  _bloc.add(OnBottomSheetOkClickEvent(
                    questions: [],
                    event: state.event,
                    eventAction: state.eventAction,
                  ));
                }
              }
            }
          }
        } else if (state is OnBottomSheetOkClickState) {
          _eventData.dynamicQuestions = state.questions;
          _selectEventAction(
            eventAction: state.eventAction,
            event: state.event,
          );
          _searchTextEditingController.clear();
        } else if (state is AddEventToCalendarState) {
          handleEventToCalendar(
              event: state.event,
              eventAction: state.eventAction,
              title: state.title,
              description: state.description,
              location: state.location,
              startDate: state.startDate,
              endDate: state.endDate,
              isAllDay: false);
        } else if (state is DeleteEventToCalendarState) {
          // selectedEventContent = state.eventContent;
          deleteCalendarEvent(
            event: state.eventContent,
            eventAction: state.eventAction,
            calendarId: calendarId,
          );
        } else if (state is ShowCalendarActionDialogState) {
          _showCalenderActionDialog(
              event: state.event,
              eventAction: state.eventAction,
              questions: state.questions);
        } else if (state is SendEventReferenceSuccessIdState) {
        } else if (state is DeleteEventReferenceIdState) {
          _bloc.add(OnBottomSheetOkClickEvent(
            questions: state.questions,
            event: state.event,
            eventAction: state.eventAction,
          ));
        } else if (state is ScrollToItemState) {
          _scrollToIndex(state.key);
          getColor();
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: buildAppBarWidget(
              context,
              title: "Events",
              isHaveBackButton: true,
              onBackButtonPressed: () {
                _bloc.add(NavigateBackEvent(events: _eventData.events));
              },
            ),
            body: WillPopScope(
              onWillPop: () {
                _bloc.add(NavigateBackEvent(events: _eventData.events));
                return Future.value(true);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    _buildEvents(state),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleRefresh() async {
    _bloc.add(GetEventsEvent());
  }

  Widget _buildEvents(EventsState state) {
    return state is ShowSkeletonState
        ? const SkeletonEventsWidget()
        : filteredEvents.isEmpty
            ? Expanded(
                child: CustomEmptyListWidget(
                  text: "noEventsYet",
                  imagePath: ImagePaths.emptyEvents,
                  onRefresh: () {
                    _handleRefresh();
                  },
                ),
              )
            : EventsWidget(
                id: widget.id,
                borderColor: borderColor,
                textEditingController: TextEditingController(),
                onActionSelected: (event, eventAction) {
                  if (DateTime.now()
                      .isBefore(DateTime.parse(event.closedDate))) {
                    _checkForDynamicQuestion(
                        event: event, eventAction: eventAction);
                  }
                },
                onChange: (value) {},
                onSendAction: (eventAction) {},
                events: filteredEvents,
                onCardTap: (event) {
                  _bloc.add(NavigateToEventDetailsScreen(event: event));
                },
                onPullToRefresh: () {
                  _handleRefresh();
                },
                onScrollToItem: (key) {
                  _bloc.add(ScrollToItemEvent(key: key));
                },
              );
  }

  void _selectEventAction({
    required HomeEventOption eventAction,
    required HomeEventItem event,
  }) {
    _bloc.add(SelectEventActionEvent(
      eventAction: eventAction,
      event: event,
    ));
  }

  void _checkForDynamicQuestion({
    required HomeEventItem event,
    HomeEventOption? eventAction,
  }) {
    _bloc.add(
        CheckForDynamicQuestionEvent(event: event, eventAction: eventAction!));
  }

  void _openDynamicQuestionBottomSheet({
    required List<PageField> questions,
    required HomeEventItem event,
    required HomeEventOption eventAction,
  }) {
    showBottomSheetWidget(
      context: context,
      height: 600,
      content: Center(
        child: InkWell(
          onTap: () {
            if (eventAction.isCalendar && Platform.isAndroid) {
              _bloc.add(ShowCalendarActionDialogEvent(
                  questions: questions,
                  event: event,
                  eventAction: eventAction));
            } else {
              if (event.calenderRef != "") {
                _deleteFromCalenderEvent(
                  event: event,
                  eventAction: eventAction,
                  eventId: event.calenderRef,
                );
              } else {
                _bloc.add(OnBottomSheetOkClickEvent(
                  questions: questions,
                  event: event,
                  eventAction: eventAction,
                ));
              }
            }
            _popBackEvent();
          },
          child: const Text(
            "Event Calendar",
          ),
        ),
      ),
      titleLabel: "Event Calendar",
      isClosed: true,
    );
  }

  void _popBackEvent() {
    Navigator.pop(context);
  }

  final cairoTimeZone = getLocation('Africa/Cairo');

  void _showCalenderActionDialog({
    required HomeEventItem event,
    required HomeEventOption eventAction,
    List<PageField> questions = const [],
  }) {
    _showActionDialog(
      icon: ImagePaths.info,
      text: "do You Want To Add This Event To Your Device",
      primaryText: "yes",
      secondaryText: "no",
      onPrimaryAction: () async {
        Navigator.pop(context);
        if (await PermissionServiceHandler().handleServicePermission(
            setting: PermissionServiceHandler.getCalendarPermission())) {
          _addToCalendarEvent(event: event, eventAction: eventAction);
        } else {
          _showActionDialog(
            icon: ImagePaths.warning,
            onPrimaryAction: () {
              Navigator.pop(context);
              openAppSettings().then((value) async {
                if ((await PermissionServiceHandler.getCalendarPermission()
                    .isGranted)) {
                  _addToCalendarEvent(event: event, eventAction: eventAction);
                }
              });
            },
            onSecondaryAction: () {
              Navigator.pop(context);
            },
            primaryText: "ok",
            secondaryText: "cancel",
            text: "you Should Have Calendar Permission",
          );
        }
      },
      onSecondaryAction: () {
        _bloc.add(DeleteEventReferenceIdEvent(
          questions: questions,
          event: event,
          eventAction: eventAction,
        ));
        Navigator.pop(context);
      },
    );
  }

  void _showActionDialog({
    required Function() onPrimaryAction,
    required Function() onSecondaryAction,
    required String primaryText,
    required String secondaryText,
    required String text,
    required String icon,
  }) {
    showActionDialogWidget(
      context: context,
      text: text,
      primaryText: primaryText,
      primaryAction: () {
        onPrimaryAction();
      },
      secondaryText: secondaryText,
      secondaryAction: () {
        onSecondaryAction();
      },
      icon: icon,
    );
  }

  void _addToCalendarEvent(
      {required HomeEventItem event, required HomeEventOption eventAction}) {
    _bloc.add(AddEventToCalendarEvent(
      event: event,
      eventAction: eventAction,
      startDate: TZDateTime(
          cairoTimeZone,
          DateTime.parse(event.endDate).year,
          DateTime.parse(event.endDate).month,
          DateTime.parse(event.endDate).day,
          DateTime.parse(event.endDate).hour,
          0),
      endDate: TZDateTime(
          cairoTimeZone,
          DateTime.parse(event.endDate).year,
          DateTime.parse(event.endDate).month,
          DateTime.parse(event.endDate).day,
          DateTime.parse(event.endDate).hour,
          0),
      isAllDay: false,
    ));
    showLoading();
  }

  void _deleteFromCalenderEvent({
    required HomeEventItem event,
    required HomeEventOption eventAction,
    required String eventId,
  }) {
    _bloc.add(DeleteEventFromCalendarEvent(
      event: event,
      eventAction: eventAction,
      eventId: eventId,
    ));
    showLoading();
  }

  Future<void> handleEventToCalendar({
    required HomeEventItem event,
    required HomeEventOption eventAction,
    String? eventId,
    String? title,
    String? location,
    String? description,
    TZDateTime? startDate,
    TZDateTime? endDate,
    bool? isAllDay,
  }) async {
    final DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();
    final calendarsResult = await deviceCalendarPlugin.retrieveCalendars();

    if (calendarsResult.isSuccess && calendarsResult.data!.isNotEmpty) {
      // ignore: prefer_typing_uninitialized_variables
      var foundCalendar;
      foundCalendar = calendarsResult.data!.first;

      if (foundCalendar != null) {
        calendarId = foundCalendar.id;

        createEvent(
            event: event,
            eventAction: eventAction,
            calendarId: calendarId,
            isAllDay: isAllDay ?? false,
            startDate: startDate,
            endDate: endDate);
      } else {
        _showMassageDialogWidget("failed To Add Event", ImagePaths.warning);
        hideLoading();
      }
    } else {
      hideLoading();
    }
  }

  Future<String> createEvent({
    required String? calendarId,
    required HomeEventItem event,
    required HomeEventOption eventAction,
    TZDateTime? startDate,
    TZDateTime? endDate,
    bool? isAllDay,
  }) async {
    try {
      var result = await _deviceCalendarPlugin.createOrUpdateEvent(Event(
        calendarId,
        title: event.title,
        location: event.locationAddress,
        description: event.description,
        allDay: isAllDay ?? false,
        start: startDate,
        end: endDate,
      ));

      if (result!.isSuccess) {
        _sendEventReferenceId(
            event: event, eventAction: eventAction, data: result.data!);
        hideLoading();

        _bloc.add(OnBottomSheetOkClickEvent(
          questions: [],
          event: event,
          eventAction: eventAction,
        ));

        return result.data!;
      } else {
        _showMassageDialogWidget("failed To Add Event", ImagePaths.error);
        hideLoading();
        return "error";
      }
    } catch (e) {
      _showMassageDialogWidget("failed To Add Event", ImagePaths.error);
      hideLoading();
      return "Exception";
    }
  }

  Future<bool> deleteCalendarEvent({
    required HomeEventItem event,
    required HomeEventOption eventAction,
    required String? calendarId,
  }) async {
    try {
      var result = await _deviceCalendarPlugin.deleteEvent(
          calendarId, event.calenderRef);
      if (result.isSuccess) {
        hideLoading();
        _bloc.add(DeleteEventReferenceIdEvent(
          questions: [],
          event: event,
          eventAction: eventAction,
        ));
        return true;
      } else {
        hideLoading();
        return false;
      }
    } catch (e) {
      hideLoading();
      return false;
    }
  }

  void _showMassageDialogWidget(String text, String icon) {
    showMassageDialogWidget(
      context: context,
      text: text,
      icon: icon,
      buttonText: "ok",
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  void _sendEventReferenceId(
      {required HomeEventItem event,
      required HomeEventOption eventAction,
      required String data}) {
    _bloc.add(SendEventReferenceIdEvent(
        event: event, eventAction: eventAction, eventReferenceId: data));
  }

  Future<void> _scrollToIndex(GlobalKey key) async {
    Future.delayed(const Duration(milliseconds: 500));
    Scrollable.ensureVisible(
      key.currentContext ?? context,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  getColor() {
    _timer = Timer(const Duration(seconds: 2), () {
      borderColor = ColorSchemes.white;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
