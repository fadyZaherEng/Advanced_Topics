part of 'add_payment_bloc.dart';

abstract class AddPaymentEvent extends Equatable {
  const AddPaymentEvent();

  @override
  List<Object?> get props => [
        identityHashCode(this),
      ];
}

class ComplainSubmitEvent extends AddPaymentEvent {}

class DescribeProblemValidationEvent extends AddPaymentEvent {
  final String value;
  final int max;
  final int min;

  const DescribeProblemValidationEvent({
    required this.value,
    required this.max,
    required this.min,
  });
}

class NavigateBackEvent extends AddPaymentEvent {}

class OpenMediaBottomSheetEvent extends AddPaymentEvent {
  final MediaType mediaType;

  const OpenMediaBottomSheetEvent({
    required this.mediaType,
  });
}

class AddImageEvent extends AddPaymentEvent {
  final XFile? image;

  const AddImageEvent({
    required this.image,
  });
}

class AddMultipleImagesEvent extends AddPaymentEvent {
  final List<File?> images;

  const AddMultipleImagesEvent({
    required this.images,
  });
}

class AddVideoEvent extends AddPaymentEvent {
  final XFile? video;
  final ImageSource imageSource;

  const AddVideoEvent({
    required this.video,
    required this.imageSource,
  });
}

class NavigateToVideoTrimmerScreenEvent extends AddPaymentEvent {
  final File video;
  final int maxDuration;

  const NavigateToVideoTrimmerScreenEvent({
    required this.video,
    required this.maxDuration,
  });
}

class RemoveVideoEvent extends AddPaymentEvent {}

class RemoveImageEvent extends AddPaymentEvent {
  final List<File> images;
  final int index;

  const RemoveImageEvent({
    required this.images,
    required this.index,
  });
}

class InitializeRecorderEvent extends AddPaymentEvent {}

class StartRecordingEvent extends AddPaymentEvent {}

class StopRecordingEvent extends AddPaymentEvent {}

class SaveAudioPathEvent extends AddPaymentEvent {
  final String audioPath;

  const SaveAudioPathEvent({
    required this.audioPath,
  });
}

class RemoveAudioFileEvent extends AddPaymentEvent {
  final String audioPath;
  final bool isReplace;

  const RemoveAudioFileEvent({
    this.audioPath = "",
    this.isReplace = false,
  });
}

class AudioStatusChangeEvent extends AddPaymentEvent {
  final bool isRecording;
  final int duration;

  const AudioStatusChangeEvent({
    required this.isRecording,
    required this.duration,
  });
}

class ValidateServiceAmountEvent extends AddPaymentEvent {
  final String value;

  const ValidateServiceAmountEvent({
    required this.value,
  });
}

class SubmitPaymentEvent extends AddPaymentEvent {
  final int requestId;
  final String description;
  final List<File> images;
  final String audioPath;
  final String videoFile;
  final int min;
  final String amount;

  const SubmitPaymentEvent({
    required this.requestId,
    required this.description,
    required this.images,
    required this.audioPath,
    required this.videoFile,
    required this.min,
    required this.amount,
  });
}
