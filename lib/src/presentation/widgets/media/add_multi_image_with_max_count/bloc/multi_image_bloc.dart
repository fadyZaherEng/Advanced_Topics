import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/add_multi_image_with_max_count/multi_image_widget.dart';
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
    // List<File> images = event.document.imagesList;
    // images.add(File(event.image.path));
    // event.document.copyWith(imagesList: images);
    event.document.imagesList.insert(0, File(event.image.path));
    emit(AddMultipleImageState(document: event.document));
  }

  FutureOr<void> _onDeleteMultipleImageEvent(
      DeleteMultipleImageEvent event, Emitter<MultiImageState> emit) {
    event.document.imagesList.removeAt(event.index);

    emit(DeleteMultipleImageState(
        document: event.document, isMultiImage: true, index: event.index));
  }

  FutureOr<void> _onSelectMultipleImageEvent(
      SelectMultipleImageEvent event, Emitter<MultiImageState> emit) {
    emit(SelectMultipleImageState(
      document: event.document.copyWith(
        errorMessage: "",
      ),
    ));
  }
}
