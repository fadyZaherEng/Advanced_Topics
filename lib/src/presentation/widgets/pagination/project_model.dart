import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final int id;
  final String name;
  final String description;
  final List<String> projectImages;
  final double mSquare;
  final String location;
  final double price;
  final List<String> projectUnits;

  const Project({
    this.id = 0,
    this.name = "",
    this.description = "",
    this.projectImages = const [],
    this.mSquare = 0.0,
    this.location = "",
    this.price = 0.0,
    this.projectUnits = const [],
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    projectImages,
    projectUnits,
    mSquare,
    location,
    price,
  ];
}
