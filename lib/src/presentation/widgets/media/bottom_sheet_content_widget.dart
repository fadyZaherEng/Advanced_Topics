// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/base/widget/base_stateful_widget.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/new/permission_service_handler.dart';
import 'package:flutter_advanced_topics/src/core/utils/new/show_action_dialog_widget.dart';
import 'package:flutter_advanced_topics/src/core/utils/show_bottom_sheet_upload_media.dart';
import 'package:flutter_advanced_topics/src/core/utils/show_massage_dialog_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_button_internet_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/bottom_sheet_images_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/custom_text_filed_problem_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/custom_text_filed_service_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/custom_video_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/need_payment/need_payment_bloc.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/show_voice_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

class BottomSheetContentWidget extends BaseStatefulWidget {
  final int maxLengthOfVoice;
  final int maxLengthOfVideo;
  final int maxlengthOfImages;
  final int minLengthOfImages;
  final int maxLengthOfProblem;
  final int minLengthOfProblem;
  final int requestId;

  const BottomSheetContentWidget({
    super.key,
    required this.maxLengthOfVoice,
    required this.maxLengthOfVideo,
    required this.maxlengthOfImages,
    required this.minLengthOfImages,
    required this.maxLengthOfProblem,
    required this.minLengthOfProblem,
    required this.requestId,
  });

  @override
  BaseState<BottomSheetContentWidget> baseCreateState() =>
      _BottomSheetContentWidgetState();
}

class _BottomSheetContentWidgetState
    extends BaseState<BottomSheetContentWidget> {
  NeedPaymentBloc get _bloc => BlocProvider.of<NeedPaymentBloc>(context);
  String? _errorProblemMessage;
  String? _errorServiceMessage;
  String _audioPath = "";
  String _videoPath = "";
  final List<XFile> _images = [];
  // JobDetailsController _jobDetailsController = JobDetailsController(
  //   problemTextEditingController: TextEditingController(),
  //   serviceTextEditingController: TextEditingController(),
  // );

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<NeedPaymentBloc, NeedPaymentState>(
        listener: (context, state) {
      if (state is OnNeedPaymentServiceValidClickState) {
        _errorServiceMessage = null;
      } else if (state is OnNeedPaymentServiceNotValidClickState) {
        _errorServiceMessage = "This field is required";
      } else if (state is OnNeedPaymentProblemValidState) {
        _errorProblemMessage = null;
      } else if (state is OnNeedPaymentProblemNotValidState) {
        _errorProblemMessage = state.massage;
      } else if (state is OnNeedPaymentProblemEmptyState) {
        _errorProblemMessage = state.massage;
      } else if (state is OnNeedPaymentAddMediaState) {
        _showBottomSheetMedia(context, "image", widget.maxlengthOfImages);
      } else if (state is OnNeedPaymentDeleteMediaState) {
        _images.removeAt(state.index);
        //_bloc.add(OnNeedPaymentAddGalleryEvent(_images));
      } else if (state is OnNeedPaymentClearDataState) {
        _images.clear();
        // _jobDetailsController = JobDetailsController(
        //   problemTextEditingController: TextEditingController(),
        //   serviceTextEditingController: TextEditingController(),
        // );
        _bloc.add(OnGetAudioPathEvent(""));
        _bloc.add(OnGetVideoPathEvent(""));
      } else if (state is OnGetAudioPathState) {
        _audioPath = state.path;
        _errorProblemMessage = null;
      } else if (state is OnGetVideoPathState) {
        _videoPath = state.path;
        _errorProblemMessage = null;
      } else if (state is OnNeedPaymentClearVideoState) {
        _bloc.add(OnGetVideoPathEvent(""));
      } else if (state is OnNeedPaymentClearAudioState) {
        _bloc.add(OnGetAudioPathEvent(""));
      } else if (state is OnNeedPaymentSubmitMediaState) {
        _showDialog(context, state.massage);
      } else if (state is ShowLoadingState) {
        showLoading();
      } else if (state is HideLoadingState) {
        hideLoading();
      } else if (state is OnNeedPaymentSubmitSuccessMediaState) {
        _showDialog(context, state.massage);
      } else if (state is OnNeedPaymentSubmitFailedMediaState) {
        _showDialog(context, state.massage);
      }
    }, builder: (context, state) {
      return Column(
        children: [
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: InkWell(
              onTap: () {
                _onClose(
                  context,
                  _audioPath,
                  _videoPath,
                  _images,
                  //   _jobDetailsController,
                );
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.10, 16.0, 16.0, 10.0),
                child: SvgPicture.asset(
                  ImagePaths.close,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFieldProblemWidget(
                        textEditingController: TextEditingController(),
                        //  _jobDetailsController.problemTextEditingController,
                        maxLengthOfVocie: widget.maxLengthOfVoice,
                        minLinesOfProblem: widget.minLengthOfProblem,
                        onChangeTextEditingController: (value) {
                          _bloc.add(
                            OnNeedPaymentProblemValidateEvent(
                              widget.minLengthOfProblem,
                              value.toString(),
                            ),
                          );
                        },
                        onGalleyTap: () {
                          _showBottomSheetMedia(
                              context, "image", widget.maxlengthOfImages);
                        },
                        onVideoTap: () {
                          _showBottomSheetMedia(
                              context, "video", widget.maxLengthOfVideo);
                        },
                        errorMessage: _errorProblemMessage,
                        title: "Brief Description",
                        maxLinesOfProblem: widget.maxLengthOfProblem,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BottomSheetImagesWidget(
                        max: widget.maxlengthOfImages,
                        min: widget.minLengthOfImages,
                      ),
                      if (_audioPath != "")
                        ShowMicrophoneWidget(
                          audioPath: _audioPath,
                          maxRecordingDuration: widget.maxLengthOfVoice,
                          onClosed: () {
                            _bloc.add(OnNeedPaymentClearAudioEvent());
                          },
                        ),
                      if (_audioPath != "")
                        const SizedBox(
                          height: 10,
                        ),
                      if (_videoPath != "")
                        SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: CustomVideoWidget(
                            videoController:
                                VideoPlayerController.file(File(_videoPath))
                                  ..initialize().then(
                                    (value) {},
                                  ),
                            onClosed: () {
                              _bloc.add(OnNeedPaymentClearVideoEvent());
                            },
                          ),
                        ),
                      if (_videoPath != "")
                        const SizedBox(
                          height: 10,
                        ),
                      CustomTextFiledServiceWidget(
                        textEditingController: TextEditingController(),
                        //  _jobDetailsController.serviceTextEditingController,
                        serviceTitle: "serviceAmount",
                        errorMessage: _errorServiceMessage,
                        onChanged: (value) {
                          _bloc.add(
                            OnNeedPaymentServiceValidateEvent(
                              value.toString(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Align(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: CustomButtonInternetWidget(
                          onTap: () {
                            //_bloc.add(
                            // OnNeedPaymentSubmitMediaEvent(
                            //   images: _images,
                            //   audioPath: _audioPath,
                            //   videoPath: _videoPath,
                            //   jobDetailsController: _jobDetailsController,
                            //   min: widget.minLengthOfProblem,
                            //   changeSupportRequest: ChangeSupportRequest(
                            //     requestId: widget.requestId,
                            //     statusCode: "needPayment",
                            //     description: _jobDetailsController
                            //         .problemTextEditingController.text,
                            //     totalAmount: _jobDetailsController
                            //                 .serviceTextEditingController
                            //                 .text ==
                            //             ""
                            //         ? 0
                            //         : double.parse(
                            //             _jobDetailsController
                            //                 .serviceTextEditingController
                            //                 .text,
                            //           ),
                            //   ),
                            // ),
                            //);
                          },
                          text: "submit",
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      );
    });
  }

  void _onClose(
    BuildContext context,
    String audioPath,
    String videoPath,
    List<XFile> images,
    //JobDetailsController jobDetailsController,
  ) {
    // if (jobDetailsController.problemTextEditingController.text.isNotEmpty ||
    //     jobDetailsController.serviceTextEditingController.text.isNotEmpty ||
    if (images.isNotEmpty || audioPath.isNotEmpty || videoPath.isNotEmpty) {
      showActionDialogWidget(
        context: context,
        text: "areYouSureYouWantToClose",
        icon: ImagePaths.face,
        primaryAction: () {
          Navigator.pop(context);
          Navigator.pop(context);
          _bloc.add(OnNeedPaymentClearDataEvent());
        },
        secondaryAction: () {
          Navigator.pop(context);
        },
        primaryText: "S.current.yes",
        secondaryText: "S.current.no",
      );
    } else {
      Navigator.pop(context);
    }
  }

  void _showBottomSheetMedia(
      BuildContext context, String type, int maxDuration) async {
    showBottomSheetUploadMedia(
      context: context,
      onTapCamera: () async {
        if (await PermissionServiceHandler().handleServicePermission(
          setting: Permission.camera,
        )) {
          Navigator.pop(context);
          if (type == "image") {
            _pickImage(context);
          } else {
            _pickVideo(context, maxDuration);
          }
        } else if (!await PermissionServiceHandler()
            .handleServicePermission(setting: Permission.camera)) {
          showActionDialogWidget(
              context: context,
              text: "youShouldHaveCameraPermission",
              icon: ImagePaths.cameraTwo,
              primaryText: "ok",
              secondaryText: "cancel",
              primaryAction: () async {
                openAppSettings().then((value) => Navigator.pop(context));
              },
              secondaryAction: () {
                Navigator.of(context).pop();
              });
        }
      },
      onTapGallery: () async {
        if (await PermissionServiceHandler().handleServicePermission(
          setting: Permission.storage,
        )) {
          Navigator.pop(context);
          if (type == "image") {
            _getImageFromGallery(context);
          } else {
            _getVideoFromGallery(context);
          }
        } else if (!await PermissionServiceHandler()
            .handleServicePermission(setting: Permission.storage)) {
          showActionDialogWidget(
            context: context,
            text: "S.of(context).youShouldHaveStoragePermission",
            icon: ImagePaths.gallery,
            primaryText: "S.of(context).ok",
            secondaryText: "S.of(context).cancel",
            primaryAction: () async {
              openAppSettings().then(
                (value) async {
                  Navigator.pop(context);
                },
              );
            },
            secondaryAction: () {
              Navigator.of(context).pop();
            },
          );
        }
      },
    );
  }

  void _pickImage(BuildContext context) async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedImage != null) {
      _images.add(pickedImage);
      _errorProblemMessage = null;
      // _bloc.add(OnNeedPaymentAddGalleryEvent(_images));
    }
  }

  void _getImageFromGallery(BuildContext context) async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      _images.add(pickedImage);
      _errorProblemMessage = null;
      //_bloc.add(OnNeedPaymentAddGalleryEvent(_images));
    }
  }

  void _pickVideo(BuildContext context, int maxDuration) async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.camera,
      maxDuration: Duration(seconds: maxDuration),
    );
    if (video != null) {
      _errorProblemMessage = null;
      _bloc.add(OnGetVideoPathEvent(video.path));
    }
  }

  void _getVideoFromGallery(BuildContext context) async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );
    if (video != null) {
      _errorProblemMessage = null;
      _bloc.add(OnGetVideoPathEvent(video.path));
    }
  }

  void _showDialog(BuildContext context, String massage) {
    showMessageDialogWidget(
      context: context,
      text: massage,
      icon: ImagePaths.logo,
      buttonText: "S.current.ok",
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }
}
