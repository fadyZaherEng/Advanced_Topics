part of 'units_bloc.dart';

@immutable
abstract class UnitsEvent extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(this),
      ];
}

class GetUnitsEvent extends UnitsEvent {
  final CompoundUnitsRequest request;
  final int userId;

  GetUnitsEvent({
    required this.request,
    required this.userId,
  });
}

class SelectUnitEvent extends UnitsEvent {
  final CompoundUnit unit;
  final List<CompoundUnit> units;

  SelectUnitEvent({
    required this.unit,
    required this.units,
  });
}

class OnTapNextEvent extends UnitsEvent {
  final CompoundUnit unit;
  final List<CompoundUnit> units;

  OnTapNextEvent({
    required this.unit,
    required this.units,
  });
}

class OnTapBackEvent extends UnitsEvent {}

class UnitSearchEvent extends UnitsEvent {
  final String value;
  final List<CompoundUnit> units;

  UnitSearchEvent({
    required this.value,
    required this.units,
  });
}

class ClearUnitSearchEvent extends UnitsEvent {}

class UnitHeightSearchEvent extends UnitsEvent {
  final String value;
  final List<CompoundUnit> units;

  UnitHeightSearchEvent({
    required this.value,
    required this.units,
  });
}

class ApplyButtonPressedEvent extends UnitsEvent {
  final CompoundUnit selectedUnit;
  final bool isShowUnit;

  ApplyButtonPressedEvent({
    required this.selectedUnit,
    required this.isShowUnit,
  });
}
