part of 'search_bottom_sheet_bloc.dart';

@immutable
sealed class SearchBottomSheetState {}

final class SearchBottomSheetInitial extends SearchBottomSheetState {}

final class SearchBottomSheetLoading extends SearchBottomSheetState {}

final class SearchBottomSheetSuccessState extends SearchBottomSheetState {
  final List<String> choices;
   SearchBottomSheetSuccessState(this.choices);
}
