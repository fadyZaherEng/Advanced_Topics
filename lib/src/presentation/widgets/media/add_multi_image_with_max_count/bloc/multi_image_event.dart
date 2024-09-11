part of 'multi_image_bloc.dart';

@immutable
sealed class MultiImageEvent {}

class AddMultipleImageEvent extends MultiImageEvent {
  final XFile image;
  final PageField document;

  AddMultipleImageEvent({
    required this.document,
    required this.image,
  });
}

class DeleteMultipleImageEvent extends MultiImageEvent {
  final PageField document;
  int index;

  DeleteMultipleImageEvent({
    required this.document,
    required this.index,
  });
}
class SelectMultipleImageEvent extends MultiImageEvent {
  final List<File> images;
  final PageField document;

  SelectMultipleImageEvent({
    required this.images,
    required this.document,
  });
}