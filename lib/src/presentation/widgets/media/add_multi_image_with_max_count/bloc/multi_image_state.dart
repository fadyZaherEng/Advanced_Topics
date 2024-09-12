part of 'multi_image_bloc.dart';

@immutable
sealed class MultiImageState {}

final class MultiImageInitial extends MultiImageState {}
class SelectMultipleImageState extends MultiImageState {
  final List<File> imagesList;

  SelectMultipleImageState({
    required this.imagesList,
  });
}
class AddMultipleImageState extends MultiImageState {
  final List<File> imagesList;

  AddMultipleImageState({
    required this.imagesList,
  });
}

class DeleteMultipleImageState extends MultiImageState {
  final List<File> imagesList;
  final bool isMultiImage;
  final int index;

  DeleteMultipleImageState({
    required this.imagesList,
    this.isMultiImage = false,
    this.index = -1,
  });
}
