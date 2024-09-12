import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:meta/meta.dart';

part 'multi_image_event.dart';

part 'multi_image_state.dart';

class MultiImageBloc extends Bloc<MultiImageEvent, MultiImageState> {
  MultiImageBloc() : super(MultiImageInitial()) {
    on<AddMultipleImageEvent>(_onAddMultipleImageEvent);
    on<DeleteMultipleImageEvent>(_onDeleteMultipleImageEvent);
    on<SelectMultipleImageEvent>(_onSelectMultipleImageEvent);
  }

  FutureOr<void> _onAddMultipleImageEvent(
      AddMultipleImageEvent event, Emitter<MultiImageState> emit) {
    emit(AddMultipleImageState(
        imagesList: event.imageList + [File(event.image.path)]));
  }

  FutureOr<void> _onDeleteMultipleImageEvent(
      DeleteMultipleImageEvent event, Emitter<MultiImageState> emit) {
    event.imageList.removeAt(event.index);

    emit(DeleteMultipleImageState(
        imagesList: event.imageList, isMultiImage: true, index: event.index));
  }

  FutureOr<void> _onSelectMultipleImageEvent(
      SelectMultipleImageEvent event, Emitter<MultiImageState> emit) {
    emit(SelectMultipleImageState(imagesList: event.images));
  }
}
