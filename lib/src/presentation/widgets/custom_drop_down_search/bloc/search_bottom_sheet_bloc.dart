import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_bottom_sheet_event.dart';

part 'search_bottom_sheet_state.dart';

class SearchBottomSheetBloc
    extends Bloc<SearchBottomSheetEvent, SearchBottomSheetState> {
  SearchBottomSheetBloc() : super(SearchBottomSheetInitial()) {
    on<SearchBottomSheetEvents>(_onSearchBottomSheetEvent);
  }

  FutureOr<void> _onSearchBottomSheetEvent(
      SearchBottomSheetEvents event, Emitter<SearchBottomSheetState> emit) {
    emit(SearchBottomSheetLoading());
    List<String> filteredChoices = [];
    event.value.isEmpty
        ? filteredChoices.addAll(event.choices) : event.choices.map((e) =>
         e.contains(event.value)
            ? filteredChoices.add(e)
            : null).toList();
    emit(SearchBottomSheetSuccessState(filteredChoices));
  }
}
