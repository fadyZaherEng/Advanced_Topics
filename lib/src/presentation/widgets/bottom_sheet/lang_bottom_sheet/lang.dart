import 'package:equatable/equatable.dart';

class Language extends Equatable {
  final int id;
  final String code;
  final String name;
  final String image;

  const Language({
    this.id = 0,
    this.code = "",
    this.name = "",
    this.image = "",
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'image': image,
    };
  }

  factory Language.fromMap(Map<String, dynamic> map) {
    return Language(
      id: map['id'],
      code: map['code'],
      name: map['name'],
      image: map['image'],
    );
  }

  Language copyWith({
    int? id,
    String? code,
    String? name,
    String? image,
  }) {
    return Language(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [
        id,
        code,
        name,
        image,
      ];
}
