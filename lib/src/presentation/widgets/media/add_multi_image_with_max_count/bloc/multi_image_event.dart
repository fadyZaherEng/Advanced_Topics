part of 'multi_image_bloc.dart';

@immutable
sealed class MultiImageEvent {}

class AddMultipleImageEvent extends MultiImageEvent {
  final XFile image;
  final List<File>imageList;

  AddMultipleImageEvent({
    required this.imageList,
    required this.image,
  });
}

class DeleteMultipleImageEvent extends MultiImageEvent {
  final List<File>imageList;
  int index;

  DeleteMultipleImageEvent({
    required this.imageList,
    required this.index,
  });
}
class SelectMultipleImageEvent extends MultiImageEvent {
  final List<File> images;

  SelectMultipleImageEvent({
    required this.images,
  });
}