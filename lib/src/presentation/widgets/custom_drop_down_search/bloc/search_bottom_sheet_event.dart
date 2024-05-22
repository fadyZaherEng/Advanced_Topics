part of 'search_bottom_sheet_bloc.dart';

@immutable
sealed class SearchBottomSheetEvent {}

 class SearchBottomSheetEvents implements SearchBottomSheetEvent {
  final String value;
  final List<String> choices;
 const SearchBottomSheetEvents(this.value, this.choices);
}