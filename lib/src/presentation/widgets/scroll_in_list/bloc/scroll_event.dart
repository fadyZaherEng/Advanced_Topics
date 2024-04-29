part of 'scroll_bloc.dart';

@immutable
sealed class ScrollEvent {}

class ScrollToItemEvent extends ScrollEvent {
  final GlobalKey key;

  ScrollToItemEvent(this.key);
}
