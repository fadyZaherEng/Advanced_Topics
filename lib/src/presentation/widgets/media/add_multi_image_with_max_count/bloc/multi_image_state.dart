part of 'multi_image_bloc.dart';

@immutable
sealed class MultiImageState {}

final class MultiImageInitial extends MultiImageState {}
class SelectMultipleImageState extends MultiImageState {
  final PageField document;

  SelectMultipleImageState({
    required this.document,
  });
}
class AddMultipleImageState extends MultiImageState {
  final PageField document;

  AddMultipleImageState({
    required this.document,
  });
}

class DeleteMultipleImageState extends MultiImageState {
  final PageField document;
  final bool isMultiImage;
  final int index;

  DeleteMultipleImageState({
    required this.document,
    this.isMultiImage = false,
    this.index = -1,
  });
}
