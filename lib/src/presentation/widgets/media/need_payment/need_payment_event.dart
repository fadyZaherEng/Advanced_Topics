part of 'need_payment_bloc.dart';

@immutable
abstract class NeedPaymentEvent {}

class OnNeedPaymentProblemValidateEvent extends NeedPaymentEvent {
  String text;
  int min;

  OnNeedPaymentProblemValidateEvent(this.min, this.text);
}

class OnNeedPaymentServiceValidateEvent extends NeedPaymentEvent {
  String text;

  OnNeedPaymentServiceValidateEvent(this.text);
}

class OnNeedPaymentGalleryEvent extends NeedPaymentEvent {}

class OnGetAudioPathEvent extends NeedPaymentEvent {
  String path;

  OnGetAudioPathEvent(this.path);
}

class OnGetVideoPathEvent extends NeedPaymentEvent {
  String path;

  OnGetVideoPathEvent(this.path);
}

class OnBottomNeedPaymentClickEvent extends NeedPaymentEvent {
  // final ChangeSupportRequest changeSupportRequest;
  //
  // OnBottomNeedPaymentClickEvent(this.changeSupportRequest);
}

class OnNeedPaymentClickEvent extends NeedPaymentEvent {}

class OnNeedPaymentAddGalleryEvent extends NeedPaymentEvent {
  // List<XFile> images;
  //
  // OnNeedPaymentAddGalleryEvent(this.images);
}

class OnNeedPaymentAddMediaEvent extends NeedPaymentEvent {}

class OnNeedPaymentDeleteMediaEvent extends NeedPaymentEvent {
  int index;

  OnNeedPaymentDeleteMediaEvent(this.index);
}

class OnNeedPaymentClearDataEvent extends NeedPaymentEvent {}

class OnNeedPaymentSubmitMediaEvent extends NeedPaymentEvent {
  // final List<XFile> images;
  // final JobDetailsController jobDetailsController;
  // final String audioPath;
  // final String videoPath;
  // final int min;
  // final ChangeSupportRequest changeSupportRequest;
  //
  // OnNeedPaymentSubmitMediaEvent({
  //   required this.images,
  //   required this.audioPath,
  //   required this.videoPath,
  //   required this.jobDetailsController,
  //   required this.min,
  //   required this.changeSupportRequest,
  // });
}

class OnNeedPaymentClearVideoEvent extends NeedPaymentEvent {}

class OnNeedPaymentClearAudioEvent extends NeedPaymentEvent {}
