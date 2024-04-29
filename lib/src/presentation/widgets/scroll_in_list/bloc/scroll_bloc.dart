import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'scroll_event.dart';
part 'scroll_state.dart';

class ScrollBloc extends Bloc<ScrollEvent, ScrollState> {
  ScrollBloc() : super(ScrollInitial()) {
    on<ScrollToItemEvent>(_onScrollToItemEvent);
  }
  FutureOr<void> _onScrollToItemEvent(
      ScrollToItemEvent event, Emitter<ScrollState> emit) {
    emit(ScrollToItemState(event.key));
  }
}
