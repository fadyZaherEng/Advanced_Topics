part of 'gallery_bloc.dart';

@immutable
abstract class GalleryEvent extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(
          this,
        ),
      ];
}

class GetGalleryEvent extends GalleryEvent {
  final bool isRefresh;

  GetGalleryEvent({this.isRefresh = false});
}

class NavigateToGalleryPictureScreenEvent extends GalleryEvent {
  final int pictureId;
  final List<GalleryAttachment> galleryImages;

  NavigateToGalleryPictureScreenEvent({
    required this.pictureId,
    required this.galleryImages,
  });
}

class NavigationPopEvent extends GalleryEvent {}

