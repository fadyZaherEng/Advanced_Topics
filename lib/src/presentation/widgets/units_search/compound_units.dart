import 'package:equatable/equatable.dart';

class CompoundUnit extends Equatable {
  final int id;
  final String name;
  final List<CompoundUnit> units;
  final bool isSelected;

  const CompoundUnit({
    this.id = 0,
    this.name = "",
    this.isSelected = false,
    this.units = const [],
  });

  CompoundUnit copyWith({
    int? id,
    String? name,
    List<CompoundUnit>? units,
    bool? isSelected,
  }) {
    return CompoundUnit(
      id: id ?? this.id,
      name: name ?? this.name,
      units: units ?? this.units,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        units,
        isSelected,
      ];
}
