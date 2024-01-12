import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/new_media/add_payment_bottom_sheet.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/new_media/utils/compress_file.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/new_media/utils/compress_video.dart';
import 'package:image_picker/image_picker.dart';

part 'add_payment_event.dart';

part 'add_payment_state.dart';

class AddPaymentBloc extends Bloc<AddPaymentEvent, AddPaymentState> {
  // final ChangeSupportStatusUseCase _changeSupportUseCase;
  // final JopDescriptionValidationUseCase _jopDescriptionValidationUseCase;

  AddPaymentBloc(// this._changeSupportUseCase,
      // this._jopDescriptionValidationUseCase,
      )
      : super(AddPaymentInitial()) {
    on<DescribeProblemValidationEvent>(_onDescribeProblemValidationEvent);
    on<NavigateBackEvent>(_onNavigateBackEvent);
    on<OpenMediaBottomSheetEvent>(_onOpenMediaBottomSheetEvent);
    on<AddImageEvent>(_onAddImageEvent);
    on<AddMultipleImagesEvent>(_onAddMultipleImagesEvent);
    on<AddVideoEvent>(_onAddVideoEvent);
    on<NavigateToVideoTrimmerScreenEvent>(_onNavigateToVideoTrimmerScreenEvent);
    on<RemoveVideoEvent>(_onRemoveVideoEvent);
    on<RemoveImageEvent>(_onRemoveImageEvent);
    on<InitializeRecorderEvent>(_onInitializeRecorderEvent);
    on<StartRecordingEvent>(_onStartRecordingEvent);
    on<StopRecordingEvent>(_onStopRecordingEvent);
    on<SaveAudioPathEvent>(_onSaveAudioPathEvent);
    on<RemoveAudioFileEvent>(_onRemoveAudioFileEvent);
    on<AudioStatusChangeEvent>(_onAudioStatusChangeEvent);
    on<SubmitPaymentEvent>(_onSubmitPaymentEvent);
    on<ValidateServiceAmountEvent>(_onValidateServiceAmountEvent);
  }

  FutureOr<void> _onDescribeProblemValidationEvent(
      DescribeProblemValidationEvent event, Emitter<AddPaymentState> emit) {
    if (event.value.isEmpty || event.value.length >= event.min) {
      emit(DescribeProblemValidState());
    } else {
      emit(DescribeProblemInvalidState());
    }
  }

  FutureOr<void> _onNavigateBackEvent(
      NavigateBackEvent event, Emitter<AddPaymentState> emit) {
    emit(NavigateBackState());
  }

  FutureOr<void> _onOpenMediaBottomSheetEvent(
      OpenMediaBottomSheetEvent event, Emitter<AddPaymentState> emit) {
    emit(OpenMediaBottomSheetState(
      mediaType: event.mediaType,
    ));
  }

  FutureOr<void> _onAddImageEvent(
      AddImageEvent event, Emitter<AddPaymentState> emit) async {
    if (event.image != null) {
      XFile? compressedImage = await compressFile(File(event.image!.path));
      if (compressedImage != null) {
        emit(AddImageState(
          image: File(
            compressedImage.path,
          ),
        ));
      } else {
        emit(NoImageSelectedState(
          message: "S.current.noImageSelected,",
        ));
      }
    } else {
      emit(NoImageSelectedState(
        message: "S.current.noImageSelected",
      ));
    }
  }

  FutureOr<void> _onAddMultipleImagesEvent(
      AddMultipleImagesEvent event, Emitter<AddPaymentState> emit) {
    List<File> images = [];
    for (var i = 0; i < event.images.length; i++) {
      images.add(File(event.images[i]!.path));
    }

    emit(AddMultipleImageState(images: images));
  }

  FutureOr<void> _onAddVideoEvent(
      AddVideoEvent event, Emitter<AddPaymentState> emit) async {
    if (event.video != null) {
      emit(ShowVideoSkeletonState());
      File? compressedFile = await compressVideo(event.video!.path);
      if (compressedFile != null) {
        emit(AddVideoState(
          video: File(compressedFile.path),
          imageSource: event.imageSource,
        ));
      } else {
        emit(NoVideoSelectedState(
          message: "S.current.noImageSelected",
        ));
      }
    } else {
      emit(NoVideoSelectedState(
        message: "S.current.noImageSelected",
      ));
    }
  }

  FutureOr<void> _onNavigateToVideoTrimmerScreenEvent(
      NavigateToVideoTrimmerScreenEvent event, Emitter<AddPaymentState> emit) {
    emit(NavigateToVideoTrimmerScreenState(
      video: event.video,
      maxDuration: event.maxDuration,
    ));
  }

  FutureOr<void> _onRemoveVideoEvent(
      RemoveVideoEvent event, Emitter<AddPaymentState> emit) {
    emit(RemoveVideoState());
  }

  FutureOr<void> _onRemoveImageEvent(
      RemoveImageEvent event, Emitter<AddPaymentState> emit) {
    event.images.removeAt(
      event.index,
    );
    emit(RemoveImageState(
      images: event.images,
      index: event.index,
    ));
  }

  FutureOr<void> _onInitializeRecorderEvent(
      InitializeRecorderEvent event, Emitter<AddPaymentState> emit) {
    emit(InitializeRecorderState());
  }

  FutureOr<void> _onStartRecordingEvent(
      StartRecordingEvent event, Emitter<AddPaymentState> emit) {
    emit(StartRecordingState());
  }

  FutureOr<void> _onStopRecordingEvent(
      StopRecordingEvent event, Emitter<AddPaymentState> emit) {
    emit(StopRecordingState());
  }

  FutureOr<void> _onSaveAudioPathEvent(
      SaveAudioPathEvent event, Emitter<AddPaymentState> emit) {
    emit(SaveAudioPathState(audioPath: event.audioPath));
  }

  FutureOr<void> _onRemoveAudioFileEvent(
      RemoveAudioFileEvent event, Emitter<AddPaymentState> emit) {
    emit(RemoveAudioFileState(
      audioPath: event.audioPath,
      isReplace: event.isReplace,
    ));
  }

  FutureOr<void> _onAudioStatusChangeEvent(
      AudioStatusChangeEvent event, Emitter<AddPaymentState> emit) {
    emit(AudioStatusChangeState(
      isRecording: event.isRecording,
      duration: event.duration,
    ));
  }

  FutureOr<void> _onSubmitPaymentEvent(
      SubmitPaymentEvent event, Emitter<AddPaymentState> emit) async {
    // final validationsState =
    //     _jopDescriptionValidationUseCase.validateFormUseCase(
    //   problem: event.description,
    //   service: event.amount,
    //   min: event.min,
    // );
    // if (validationsState.contains(JobDetailsValidationState.notValid) ||
    //     (validationsState.contains(JobDetailsValidationState.problemNotValid) &&
    //         (event.audioPath.isEmpty &&
    //             event.images.isEmpty &&
    //             event.videoFile.isEmpty))) {
    //   for (var element in validationsState) {
    //     if (element == JobDetailsValidationState.problemNotValid &&
    //         (event.audioPath.isEmpty) &&
    //         (event.images.isEmpty) &&
    //         (event.videoFile.isEmpty)) {
    //       emit(DescribeProblemInvalidState());
    //     }
    //     if (element == JobDetailsValidationState.notValid) {
    //       emit(ServiceAmountInvalidState());
    //     }
    //   }
    //   if (event.audioPath.isEmpty &&
    //       event.images.isEmpty &&
    //       event.videoFile.isEmpty &&
    //       (validationsState
    //           .contains(JobDetailsValidationState.problemNotValid))) {
    //     emit(OneAttachmentRequiredState());
    //   }
    // } else {
    //   emit(ShowLoadingState());
    //   List<MediaModel> files = [];
    //   if (event.audioPath.isNotEmpty) {
    //     files.add(MediaModel(event.audioPath, "audio."));
    //   }
    //   if (event.videoFile.isNotEmpty) {
    //     files.add(MediaModel(event.videoFile, "video."));
    //   }
    //   if (event.images.isNotEmpty) {
    //     for (var element in event.images) {
    //       files.add(MediaModel(element.path, "image."));
    //     }
    //   }
    //   final DataState dataState = await _changeSupportUseCase(
    //     ChangeSupportRequest(
    //         requestId: event.requestId,
    //         description: event.description,
    //         statusCode: "needPayment",
    //         totalAmount: double.parse(event.amount)),
    //     files,
    //   );
    //
    //   if (dataState is DataSuccess) {
    //     emit(SubmitPaymentSuccessState(message: dataState.message ?? ""));
    //   } else {
    //     emit(SubmitPaymentErrorState(message: dataState.message ?? ""));
    //   }
    emit(HideLoadingState());
    // }
  }

  FutureOr<void> _onValidateServiceAmountEvent(
      ValidateServiceAmountEvent event, Emitter<AddPaymentState> emit) {
    // JobDetailsValidationState jobDetailsValidationState =
    //     _jopDescriptionValidationUseCase
    //         .validateServiceDescription(event.value);
    // if (jobDetailsValidationState == JobDetailsValidationState.notValid) {
    //   emit(ServiceAmountInvalidState());
    // } else {
    //   emit(ServiceAmountValidState());
    // }
  }
}
