import 'package:equatable/equatable.dart';

class ImagesAlbum {
  final List<SupportAttachment> images;
  final int initialIndex;

  ImagesAlbum({required this.initialIndex, required this.images});
}

final class SupportAttachment extends Equatable {
  final String name;
  final String pathUrl;

  const SupportAttachment({
    this.name = "",
    this.pathUrl = "",
  });

  @override
  List<Object> get props => [name, pathUrl];

  SupportAttachment copyWith({
    String? name,
    String? pathUrl,
  }) {
    return SupportAttachment(
      name: name ?? this.name,
      pathUrl: pathUrl ?? this.pathUrl,
    );
  }
}
