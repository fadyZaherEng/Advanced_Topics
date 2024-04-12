part of 'gallery_bloc.dart';

@immutable
abstract class GalleryState extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(
          this,
        ),
      ];
}

class GalleryInitialState extends GalleryState {}

class GetGallerySkeletonState extends GalleryState {}

class GetGallerySuccessState extends GalleryState {
  final List<Gallery> gallery;

  GetGallerySuccessState({
    required this.gallery,
  });
}

class GetGalleryErrorState extends GalleryState {
  final String errorMessage;

  GetGalleryErrorState({
    required this.errorMessage,
  });
}

class NavigateToGalleryPictureScreenState extends GalleryState {
  final int initialIndex;
  final List<GalleryAttachment> images;

  NavigateToGalleryPictureScreenState({
    required this.initialIndex,
    required this.images,
  });
}

class NavigationPopState extends GalleryState {}
