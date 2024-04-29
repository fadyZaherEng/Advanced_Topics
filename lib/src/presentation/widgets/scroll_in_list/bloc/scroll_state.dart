part of 'scroll_bloc.dart';

@immutable
sealed class ScrollState {}

final class ScrollInitial extends ScrollState {}

class ScrollToItemState extends ScrollState {
  final GlobalKey key;

  ScrollToItemState(this.key);
}
