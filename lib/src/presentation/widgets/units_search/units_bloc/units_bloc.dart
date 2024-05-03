// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/resource/data_state.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/units_search/compound_units.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/units_search/units_bottom_sheet_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'units_event.dart';

part 'units_state.dart';

class UnitsBloc extends Bloc<UnitsEvent, UnitsState> {
  final GetCompoundUnitsUseCase _getCompoundUnitsUseCase;
  List<CompoundUnit> _units = [];
  List<List<CompoundUnit>> unitsStack = [];

  UnitsBloc(
    this._getCompoundUnitsUseCase,
  ) : super(ShowSkeletonState()) {
    on<GetUnitsEvent>(_onGetUnitsEvent);
    on<SelectUnitEvent>(_onSelectUnitEvent);
    on<OnTapNextEvent>(_onTapNextEvent);
    on<OnTapBackEvent>(_onTapBackEvent);
    on<UnitSearchEvent>(_onUnitSearchEvent);
    on<UnitHeightSearchEvent>(_onUnitHeightSearchEvent);
    on<ApplyButtonPressedEvent>(_onApplyButtonPressedEvent);
    on<ClearUnitSearchEvent>(_onClearUnitSearchEvent);
  }

  FutureOr<void> _onGetUnitsEvent(
      GetUnitsEvent event, Emitter<UnitsState> emit) async {
    emit(ShowSkeletonState());
    final DataState dataState =
        await _getCompoundUnitsUseCase(event.request, event.userId);
    if (dataState is DataSuccess) {
      _units = dataState.data;
      emit(GetUnitsSuccessState(units: _units));
    } else {
      emit(GetUnitsErrorStateState(errorMessage: dataState.message ?? ""));
    }
    emit(HideLoadingState());
  }

  FutureOr<void> _onSelectUnitEvent(
      SelectUnitEvent event, Emitter<UnitsState> emit) {
    for (int i = 0; i < event.units.length; i++) {
      if (event.units[i].id == event.unit.id) {
        event.units[i] = event.units[i].copyWith(isSelected: true);
      } else {
        event.units[i] = event.units[i].copyWith(isSelected: false);
      }
    }
    emit(SelectUnitState(unit: event.unit, units: event.units));
  }

  FutureOr<void> _onTapNextEvent(
      OnTapNextEvent event, Emitter<UnitsState> emit) {
    unitsStack.insert(0, event.units);
    for (int i = 0; i < event.units.length; i++) {
      if (event.units[i].id == event.unit.id) {
        emit(OnTapNextState(units: event.units[i].units));
        break;
      }
    }
  }

  FutureOr<void> _onTapBackEvent(
      OnTapBackEvent event, Emitter<UnitsState> emit) {
    if (unitsStack.isNotEmpty) {
      emit(OnTapBackState(units: unitsStack[0]));
      unitsStack.removeAt(0);
    } else {
      emit(NavigateBackState());
    }
  }

  FutureOr<void> _onUnitSearchEvent(
      UnitSearchEvent event, Emitter<UnitsState> emit) {
    List<CompoundUnit> units = [];
    for (int i = 0; i < event.units.length; i++) {
      if (event.units[i].name
          .toLowerCase()
          .contains(event.value.trim().toLowerCase())) {
        units.add(event.units[i]);
      }
    }
    emit(UnitSearchState(units: units));
  }

  FutureOr<void> _onUnitHeightSearchEvent(
      UnitHeightSearchEvent event, Emitter<UnitsState> emit) async {
    emit(UnitSearchState(
        units: await getAllUnitsLevels(event.units, event.value)));
  }

  //Traverse DFS  to get all units levels by Algorithm
  FutureOr<List<CompoundUnit>> getAllUnitsLevels(
      List<CompoundUnit> units, String searchValue) {
    List<CompoundUnit> unitsLevels = [];
    void traverse(CompoundUnit node, String path) {
      String currentPath = "";
      if (node.units.isEmpty &&
          node.name.toLowerCase().startsWith(searchValue.toLowerCase()) &&
          unitsLevels.length < 3) {
        unitsLevels.add(
            node.copyWith(name: '$path - ${node.name}'.replaceFirst("-", "")));
      } else {
        currentPath = '$path - ${node.name}';
      }
      for (var child in node.units) traverse(child, currentPath);
    }

    for (var node in units) traverse(node, '');
    return unitsLevels;
  }

  FutureOr<void> _onApplyButtonPressedEvent(
      ApplyButtonPressedEvent event, Emitter<UnitsState> emit) {
    if (event.isShowUnit) {
      String unitName = "";
      for (int i = unitsStack.length - 1; i >= 0; i--) {
        for (int j = 0; j < unitsStack[i].length; j++) {
          if (unitsStack[i][j].isSelected) {
            unitName += "${unitsStack[i][j].name} - ";
            break;
          }
        }
      }

      unitName += event.selectedUnit.name;
      unitsStack.clear();
      emit(ApplyButtonPressedState(
        unit: event.selectedUnit,
        unitName: unitName,
      ));
    } else {
      emit(ApplyButtonPressedState(
        unit: event.selectedUnit,
        unitName: event.selectedUnit.name,
      ));
    }
  }

  FutureOr<void> _onClearUnitSearchEvent(
      ClearUnitSearchEvent event, Emitter<UnitsState> emit) {
    emit(ClearUnitSearchState(units: []));
  }
}

class GetCompoundUnitsUseCase {
  Future<DataState<List<CompoundUnit>>> call(
      CompoundUnitsRequest request, int userId) async {
    //call api
    return DataSuccess<List<CompoundUnit>>();
  }
}
