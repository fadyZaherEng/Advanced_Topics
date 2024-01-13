part of 'need_payment_bloc.dart';

@immutable
abstract class NeedPaymentState {}

class NeedPaymentInitial extends NeedPaymentState {}

class OnNeedPaymentClickState extends NeedPaymentState {}

class ShowLoadingState extends NeedPaymentState {}

class OnNeedPaymentSubmitFailedMediaState extends NeedPaymentState {
  String massage;
  OnNeedPaymentSubmitFailedMediaState({required this.massage});
}

class OnNeedPaymentSubmitSuccessMediaState extends NeedPaymentState {
  String massage;
  OnNeedPaymentSubmitSuccessMediaState({required this.massage});
}

class HideLoadingState extends NeedPaymentState {}

class ShowVideoSkeletonState extends NeedPaymentState {}

class OnGetAudioPathState extends NeedPaymentState {
  final String path;

  OnGetAudioPathState(this.path);
}

class OnGetVideoPathState extends NeedPaymentState {
  final String path;

  OnGetVideoPathState(this.path);
}

class OnNeedPaymentGalleryState extends NeedPaymentState {}

class OnNeedPaymentProblemValidState extends NeedPaymentState {}

class OnNeedPaymentProblemNotValidState extends NeedPaymentState {
  String? massage;
  OnNeedPaymentProblemNotValidState({required this.massage});
}

class OnNeedPaymentProblemEmptyState extends NeedPaymentState {
  String? massage;
  OnNeedPaymentProblemEmptyState({required this.massage});
}

class OnNeedPaymentServiceValidClickState extends NeedPaymentState {}

class OnNeedPaymentServiceNotValidClickState extends NeedPaymentState {}

class OnNeedPaymentAddGalleryState extends NeedPaymentState {
  List<XFile> images;

  OnNeedPaymentAddGalleryState(this.images);
}

class OnNeedPaymentAddMediaState extends NeedPaymentState {}

class OnNeedPaymentDeleteMediaState extends NeedPaymentState {
  int index;

  OnNeedPaymentDeleteMediaState(this.index);
}

class OnNeedPaymentClearDataState extends NeedPaymentState {}

class OnNeedPaymentSubmitMediaState extends NeedPaymentState {
  String massage;

  OnNeedPaymentSubmitMediaState({required this.massage});
}

class OnNeedPaymentClearVideoState extends NeedPaymentState {}

class OnNeedPaymentClearAudioState extends NeedPaymentState {}
