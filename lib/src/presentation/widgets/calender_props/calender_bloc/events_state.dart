part of 'events_bloc.dart';

abstract class EventsState extends Equatable {
  const EventsState();

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class EventsInitial extends EventsState {}

class ShowLoadingState extends EventsState {}

class HideLoadingState extends EventsState {}

class ShowSkeletonState extends EventsState {}

class OpenSortBottomSheetState extends EventsState {}

class SelectSortState extends EventsState {
  final Sort sort;

  const SelectSortState({
    required this.sort,
  });
}

class GetEventsSuccessState extends EventsState {
  final EventData events;

  const GetEventsSuccessState({
    required this.events,
  });
}

class GetEventsErrorState extends EventsState {
  final String errorMessage;

  const GetEventsErrorState({
    required this.errorMessage,
  });
}

class SearchEventsState extends EventsState {
  final String value;
  final List<HomeEventItem> events;

  const SearchEventsState({
    required this.value,
    required this.events,
  });
}

class SelectEventState extends EventsState {
  final List<HomeEventItem> events;

  const SelectEventState({
    required this.events,
  });
}

class SendEventSuccessState extends EventsState {
  final HomeEventItem event;

  const SendEventSuccessState({
    required this.event,
  });
}

class SendEventErrorState extends EventsState {
  final String errorMessage;

  const SendEventErrorState({
    required this.errorMessage,
  });
}

class NavigateToEventDetailsScreenState extends EventsState {
  final HomeEventItem event;

  const NavigateToEventDetailsScreenState({
    required this.event,
  });
}

class NavigateBackState extends EventsState {
  final List<HomeEventItem> events;

  const NavigateBackState({
    this.events = const [],
  });
}

class UpdateEventActionState extends EventsState {
  final List<HomeEventItem> events;

  const UpdateEventActionState({
    required this.events,
  });
}

class SortEventsState extends EventsState {
  final List<HomeEventItem> events;

  const SortEventsState({
    required this.events,
  });
}

class CheckForDynamicQuestionState extends EventsState {
  final List<PageField> questionsList;
  final HomeEventItem event;
  final HomeEventOption eventAction;

  CheckForDynamicQuestionState(
      {required this.questionsList,
      required this.event,
      required this.eventAction});
}

class OnBottomSheetOkClickState extends EventsState {
  final List<PageField> questions;
  final HomeEventItem event;
  final HomeEventOption eventAction;
  final String message;

  OnBottomSheetOkClickState({
    required this.questions,
    required this.event,
    required this.eventAction,
    required this.message,
  });
}

class AddEventToCalendarState extends EventsState {
  final HomeEventItem event;
  final HomeEventOption eventAction;
  String? eventId;
  String? title;
  String? location;
  String? description;
  TZDateTime? startDate;
  TZDateTime? endDate;
  bool? isAllDay;

  AddEventToCalendarState(
      {required this.event,
      required this.eventAction,
      this.eventId,
      this.title,
      this.location,
      this.description,
      this.startDate,
      this.endDate,
      this.isAllDay});
}

class DeleteEventToCalendarState extends EventsState {
  final HomeEventItem eventContent;
  final HomeEventOption eventAction;
  final String eventId;

  DeleteEventToCalendarState({
    required this.eventContent,
    required this.eventAction,
    required this.eventId,
  });
}

class ShowCalendarActionDialogState extends EventsState {
  final HomeEventItem event;
  final HomeEventOption eventAction;
  List<PageField> questions;

  ShowCalendarActionDialogState({
    required this.event,
    required this.eventAction,
    this.questions = const [],
  });
}

class SendEventReferenceSuccessIdState extends EventsState {}

class DeleteEventReferenceIdState extends EventsState {
  final List<PageField> questions;
  final HomeEventItem event;
  final HomeEventOption eventAction;

  DeleteEventReferenceIdState(
      {required this.questions, required this.event, required this.eventAction});
}

class ScrollToItemState extends EventsState {
  final GlobalKey key;

  ScrollToItemState({required this.key});
}
