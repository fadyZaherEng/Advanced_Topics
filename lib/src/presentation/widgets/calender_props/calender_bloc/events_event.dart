part of 'events_bloc.dart';

abstract class EventsEvent extends Equatable {
  const EventsEvent();

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class OpenSortBottomSheetEvent extends EventsEvent {}

class SelectSortEvent extends EventsEvent {
  final Sort sort;

  const SelectSortEvent({
    required this.sort,
  });
}

class GetEventsEvent extends EventsEvent {}

class SearchEventsEvent extends EventsEvent {
  final String value;

  const SearchEventsEvent({
    required this.value,
  });
}

class NavigateToEventDetailsScreen extends EventsEvent {
  final HomeEventItem event;

  const NavigateToEventDetailsScreen({
    required this.event,
  });
}

class SelectEventEvent extends EventsEvent {
  final HomeEventItem event;

  const SelectEventEvent({
    required this.event,
  });
}

class SendEventEvent extends EventsEvent {
  final HomeEventItem event;

  const SendEventEvent({
    required this.event,
  });
}

class NavigateBackEvent extends EventsEvent {
  final List<HomeEventItem> events;

  const NavigateBackEvent({
    this.events = const [],
  });
}

class SelectEventActionEvent extends EventsEvent {
  final HomeEventOption eventAction;
  final HomeEventItem event;

  const SelectEventActionEvent({
    required this.eventAction,
    required this.event,
  });
}

class SortEventsEvent extends EventsEvent {
  final List<HomeEventItem> events;
  final Sort sort;

  const SortEventsEvent({
    required this.events,
    required this.sort,
  });
}

class CheckForDynamicQuestionEvent extends EventsEvent {
  final HomeEventItem event;
  final HomeEventOption eventAction;

  CheckForDynamicQuestionEvent(
      {required this.event, required this.eventAction});
}

class OnBottomSheetOkClickEvent extends EventsEvent {
  final List<PageField> questions;
  final HomeEventItem event;
  final HomeEventOption eventAction;

  OnBottomSheetOkClickEvent(
      {required this.questions,
      required this.event,
      required this.eventAction});
}

class AddEventToCalendarEvent extends EventsEvent {
  HomeEventItem event;
  HomeEventOption eventAction;
  String? eventId;
  String? title;
  String? location;
  String? description;
  TZDateTime? startDate;
  TZDateTime? endDate;
  bool? isAllDay;

  AddEventToCalendarEvent({
    required this.event,
    required this.eventAction,
    this.eventId,
    this.title,
    this.location,
    this.description,
    this.startDate,
    this.endDate,
    this.isAllDay,
  });
}

class DeleteEventFromCalendarEvent extends EventsEvent {
  final HomeEventItem event;
  final HomeEventOption eventAction;
  final String eventId;

  DeleteEventFromCalendarEvent({
    required this.event,
    required this.eventAction,
    required this.eventId,
  });
}


class ShowCalendarActionDialogEvent extends EventsEvent {
  HomeEventItem event;
  HomeEventOption eventAction;
  List<PageField> questions;

  ShowCalendarActionDialogEvent({
    required this.event,
    required this.eventAction,
    this.questions = const [],
  });
}

class SendEventReferenceIdEvent extends EventsEvent{
  HomeEventItem event;
  HomeEventOption eventAction;
  String eventReferenceId;

  SendEventReferenceIdEvent(
      {required this.event,
        required this.eventAction,
        required this.eventReferenceId});
}

class DeleteEventReferenceIdEvent extends EventsEvent {
  final List<PageField> questions;
  final HomeEventItem event;
  final HomeEventOption eventAction;

  DeleteEventReferenceIdEvent(
      {required this.questions, required this.event, required this.eventAction});
}

class ScrollToItemEvent extends EventsEvent {
  final GlobalKey key;

  ScrollToItemEvent({required this.key});
}
