part of 'units_bloc.dart';

@immutable
abstract class UnitsState extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(this),
      ];
}

class UnitsInitialState extends UnitsState {}

class ShowSkeletonState extends UnitsState {}

class ClearUnitSearchState extends UnitsState {
  final List<CompoundUnit> units;

  ClearUnitSearchState({
    required this.units,
  });
}

class ShowLoadingState extends UnitsState {}

class HideLoadingState extends UnitsState {}

class GetUnitsSuccessState extends UnitsState {
  final List<CompoundUnit> units;

  GetUnitsSuccessState({
    required this.units,
  });
}

class GetUnitsErrorStateState extends UnitsState {
  final String errorMessage;

  GetUnitsErrorStateState({
    required this.errorMessage,
  });
}

class SelectUnitState extends UnitsState {
  final CompoundUnit unit;
  final List<CompoundUnit> units;

  SelectUnitState({
    required this.unit,
    required this.units,
  });
}

class OnTapNextState extends UnitsState {
  final List<CompoundUnit> units;

  OnTapNextState({
    required this.units,
  });
}

class OnTapBackState extends UnitsState {
  final List<CompoundUnit> units;

  OnTapBackState({
    required this.units,
  });
}

class UnitSearchState extends UnitsState {
  final List<CompoundUnit> units;
  UnitSearchState({
    required this.units,
  });
}

class NavigateBackState extends UnitsState {}

class ApplyButtonPressedState extends UnitsState {
  final CompoundUnit unit;
  final String unitName;

  ApplyButtonPressedState({
    required this.unit,
    required this.unitName,
  });
}
