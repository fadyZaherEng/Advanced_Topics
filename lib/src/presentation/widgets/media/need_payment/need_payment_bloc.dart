import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'need_payment_event.dart';
part 'need_payment_state.dart';

class NeedPaymentBloc extends Bloc<NeedPaymentEvent, NeedPaymentState> {
  // final ChangeSupportStatusUseCase _changeSupportUseCase;
  // final JopDescriptionValidationUseCase _jopDescriptionValidationUseCase;

  NeedPaymentBloc(
    // this._changeSupportUseCase,
    // this._jopDescriptionValidationUseCase,
  ) : super(NeedPaymentInitial()) {
    on<OnNeedPaymentProblemValidateEvent>(_onOnNeedPaymentProblemValidateEvent);
    on<OnNeedPaymentServiceValidateEvent>(_onOnNeedPaymentServiceValidateEvent);
    on<OnNeedPaymentAddGalleryEvent>(_onOnNeedPaymentAddGalleryEvent);
    on<OnGetAudioPathEvent>(_onGetAudioPathEvent);
    on<OnGetVideoPathEvent>(_onGetVideoPathEvent);
    on<OnNeedPaymentGalleryEvent>(_onNeedPaymentGalleryEvent);
    on<OnNeedPaymentAddMediaEvent>(_onOnNeedPaymentAddMediaEvent);
    on<OnNeedPaymentDeleteMediaEvent>(_onOnNeedPaymentDeleteMediaEvent);
    on<OnNeedPaymentClearDataEvent>(_onNeedPaymentClearDataEvent);
    on<OnNeedPaymentSubmitMediaEvent>(_onNeedPaymentSubmitMediaEvent);
    on<OnNeedPaymentClearVideoEvent>(_onNeedPaymentClearVideoEvent);
    on<OnNeedPaymentClearAudioEvent>(_onNeedPaymentClearAudioEvent);
  }

  FutureOr<void> _onOnNeedPaymentProblemValidateEvent(
      OnNeedPaymentProblemValidateEvent event, Emitter<NeedPaymentState> emit) {
    // JobDetailsValidationState jobDetailsValidationState =
    //     _jopDescriptionValidationUseCase.validateProblemDescription(
    //   event.text,
    //   event.min,
    // );
    // if (jobDetailsValidationState == JobDetailsValidationState.problemEmpty) {
    //   emit(OnNeedPaymentProblemEmptyState(massage: ""));
    // } else if (jobDetailsValidationState ==
    //     JobDetailsValidationState.problemNotValid) {
    //   emit(OnNeedPaymentProblemNotValidState(massage: ""));
    // } else {
    //   emit(OnNeedPaymentProblemValidState());
    // }
  }

  FutureOr<void> _onOnNeedPaymentServiceValidateEvent(
      OnNeedPaymentServiceValidateEvent event, Emitter<NeedPaymentState> emit) {
    // JobDetailsValidationState jobDetailsValidationState =
    //     _jopDescriptionValidationUseCase.validateServiceDescription(event.text);
    // if (jobDetailsValidationState == JobDetailsValidationState.notValid) {
    //   emit(OnNeedPaymentServiceNotValidClickState());
    // } else {
    //   emit(OnNeedPaymentServiceValidClickState());
    // }
  }

  FutureOr<void> _onOnNeedPaymentAddGalleryEvent(
      OnNeedPaymentAddGalleryEvent event, Emitter<NeedPaymentState> emit) {
  //  emit(OnNeedPaymentAddGalleryState(event.images));
  }

  FutureOr<void> _onGetAudioPathEvent(
      OnGetAudioPathEvent event, Emitter<NeedPaymentState> emit) {
    emit(OnGetAudioPathState(event.path));
  }

  FutureOr<void> _onGetVideoPathEvent(
      OnGetVideoPathEvent event, Emitter<NeedPaymentState> emit) {
    emit(OnGetVideoPathState(event.path));
  }

  FutureOr<void> _onNeedPaymentGalleryEvent(
      OnNeedPaymentGalleryEvent event, Emitter<NeedPaymentState> emit) {
    emit(OnNeedPaymentGalleryState());
  }

  FutureOr<void> _onOnNeedPaymentAddMediaEvent(
      OnNeedPaymentAddMediaEvent event, Emitter<NeedPaymentState> emit) {
    emit(OnNeedPaymentAddMediaState());
  }

  FutureOr<void> _onOnNeedPaymentDeleteMediaEvent(
      OnNeedPaymentDeleteMediaEvent event, Emitter<NeedPaymentState> emit) {
    emit(OnNeedPaymentDeleteMediaState(event.index));
  }

  FutureOr<void> _onNeedPaymentClearDataEvent(
      OnNeedPaymentClearDataEvent event, Emitter<NeedPaymentState> emit) {
    emit(OnNeedPaymentClearDataState());
  }

  FutureOr<void> _onNeedPaymentSubmitMediaEvent(
      OnNeedPaymentSubmitMediaEvent event,
      Emitter<NeedPaymentState> emit) async {
    // final validationsState =
    //     _jopDescriptionValidationUseCase.validateFormUseCase(
    //   problem: event.jobDetailsController.problemTextEditingController.text,
    //   service: event.jobDetailsController.serviceTextEditingController.text,
    //   min: event.min,
    // );
    // if (validationsState.contains(JobDetailsValidationState.notValid) ||
    //     (validationsState.contains(JobDetailsValidationState.problemNotValid) &&
    //         (event.audioPath.isEmpty &&
    //             event.images.isEmpty &&
    //             event.videoPath.isEmpty))) {
    //   for (var element in validationsState) {
    //     if (element == JobDetailsValidationState.problemNotValid &&
    //         (event.audioPath.isEmpty) &&
    //         (event.images.isEmpty) &&
    //         (event.videoPath.isEmpty)) {
    //       emit(OnNeedPaymentProblemNotValidState(massage: ""));
    //     }
    //     if (element == JobDetailsValidationState.notValid) {
    //       emit(OnNeedPaymentServiceNotValidClickState());
    //     }
    //   }
    //   if (event.audioPath.isEmpty &&
    //       event.images.isEmpty &&
    //       event.videoPath.isEmpty &&
    //       (validationsState
    //           .contains(JobDetailsValidationState.problemNotValid))) {
    //     emit(OnNeedPaymentSubmitMediaState(
    //         massage: S.current.shouldNotBeTheAttachmentsEmpty));
    //   }
    // } else {
    //   emit(ShowLoadingState());
    //   List<MediaModel> files = [];
    //   if (event.audioPath.isNotEmpty) {
    //     files.add(MediaModel(event.audioPath, "audio."));
    //   }
    //   if (event.videoPath.isNotEmpty) {
    //     files.add(MediaModel(event.videoPath, "video."));
    //   }
    //   if (event.images.isNotEmpty) {
    //     for (var element in event.images) {
    //       files.add(MediaModel(element.path, "image."));
    //     }
    //   }
    //   final DataState<Support> jobState =
    //       await _changeSupportUseCase(event.changeSupportRequest, files);
    //   if (jobState is DataSuccess) {
    //     emit(OnNeedPaymentSubmitSuccessMediaState(
    //         massage: jobState.message ?? ""));
    //   } else if (jobState is DataFailed) {
    //     emit(OnNeedPaymentSubmitFailedMediaState(
    //       massage: jobState.message ?? "",
    //     ));
    //   }
      emit(HideLoadingState());
    }


  FutureOr<void> _onNeedPaymentClearVideoEvent(
      OnNeedPaymentClearVideoEvent event, Emitter<NeedPaymentState> emit) {
    emit(OnNeedPaymentClearVideoState());
  }

  FutureOr<void> _onNeedPaymentClearAudioEvent(
      OnNeedPaymentClearAudioEvent event, Emitter<NeedPaymentState> emit) {
    emit(OnNeedPaymentClearAudioState());
  }
}
