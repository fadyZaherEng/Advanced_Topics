// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';
import 'dart:typed_data';

import 'package:flutter_advanced_topics/src/presentation/widgets/button/custom_button_internet_widget.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/route/routes_manager.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/base/widget/base_stateful_widget.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/new/permission_service_handler.dart';
import 'package:flutter_advanced_topics/src/core/utils/new/show_action_dialog_widget.dart';
import 'package:flutter_advanced_topics/src/core/utils/show_bottom_sheet_upload_media.dart';
import 'package:flutter_advanced_topics/src/core/utils/show_massage_dialog_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/bottom_sheet_images_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/custom_text_filed_problem_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/custom_text_filed_service_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/custom_video_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/need_payment/need_payment_bloc.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/show_voice_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/new_media/utils/compress_video.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/new_media/utils/convert_asset_entities_to_files.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/new_media/utils/formate_time.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skeletons/skeletons.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

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
                      _audioWidget(),
                      // ShowMicrophoneWidget(
                      //   audioPath: _audioPath,
                      //   maxRecordingDuration: widget.maxLengthOfVoice,
                      //   onClosed: () {
                      //     _bloc.add(OnNeedPaymentClearAudioEvent());
                      //   },
                      // ),

                      if (_audioPath != "")
                        const SizedBox(
                          height: 10,
                        ),
                      state is ShowVideoSkeletonState
                          ? _buildVideoSkeleton()
                          : const SizedBox.shrink(),
                      if (_videoPath != "")
                        // SizedBox(
                        //   height: 150,
                        //   width: double.infinity,
                        //   child: CustomVideoWidget(
                        //     videoController:
                        //         VideoPlayerController.file(File(_videoPath))
                        //           ..initialize().then(
                        //             (value) {},
                        //           ),
                        //     onClosed: () {
                        //       _bloc.add(OnNeedPaymentClearVideoEvent());
                        //     },
                        //   ),
                        // ),

                        _videoWidget(),
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

  VideoPlayerController? videoPlayerController;

  Widget _buildVideoSkeleton() => Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          height: 150,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.grey),
          child: const SkeletonLine(
            style: SkeletonLineStyle(
              width: double.infinity,
              height: 150,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
      );

  void _onNavigateToTrimmerScreenState({
    required File video,
    required int maxDuration,
  }) {
    Navigator.pushNamed(
      context,
      AppRoutes.videoTrimmer,
      arguments: {
        "video": video,
        "maxDuration": maxDuration,
      },
    ).then((value) {
      if (value != null) {
        _videoPath = value.toString();
        videoPlayerController = VideoPlayerController.file(
          File(_videoPath),
        )..initialize().then((_) {
            setState(() {});
            FocusScope.of(context).unfocus();
          });
      }
    });
  }

  Widget _videoWidget() {
    videoPlayerController = VideoPlayerController.file(
      File(_videoPath),
    )..initialize().then((_) {
        if (videoPlayerController!.value.duration.inSeconds >
            widget.maxLengthOfVideo) {
          // _bloc.add(NavigateToVideoTrimmerScreenEvent(
          //   video: selectedVideo!,
          //   maxDuration: _maxVideoDuration,
          // ));
          // Navigator.pushNamed(context, AppRoutes.videoTrimmer, arguments: {
          //   "video": File(_videoPath),
          //   "maxDuration": widget.maxLengthOfVideo,
          // });
          _onNavigateToTrimmerScreenState(
            video: File(_videoPath),
            maxDuration: widget.maxLengthOfVideo,
          );
          _videoPath = "";
          videoPlayerController = null;
        } else {
          // _widgets.removeWhere(
          //       (element) => element.id == WidgetId.video,
          // );
          // setState(() {});
          // _widgets.add(WidgetModel(
          //   widget: _videoWidget(),
          //   id: WidgetId.video,
          // ));
          FocusScope.of(context).unfocus();
        }
      });

    return videoPlayerController == null
        ? const SizedBox.shrink()
        : videoPlayerController!.value.isInitialized
            ? Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 150,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey),
                          child: InkWell(
                            onTap: () {
                              // _navigateToPlayVideoScreenEvent(
                              //     selectedVideo, videoPlayerController!);
                              Navigator.pushNamed(
                                  context, AppRoutes.playVideoScreen,
                                  arguments: {
                                    "video": File(_videoPath),
                                    "videoPlayerController":
                                        videoPlayerController
                                  });
                            },
                            child: SizedBox(
                              height: 150,
                              child: FutureBuilder<Uint8List?>(
                                future: generateThumbnail(_videoPath),
                                builder: (BuildContext context,
                                    AsyncSnapshot<Uint8List?> snapshot) {
                                  if (snapshot.connectionState ==
                                          ConnectionState.done &&
                                      snapshot.data != null) {
                                    return Image.memory(
                                      snapshot.data!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    );
                                  } else if (snapshot.error != null) {
                                    return Image.asset(
                                      ImagePaths.imagePlaceHolder,
                                      fit: BoxFit.fill,
                                    );
                                  } else {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        Positioned.directional(
                          textDirection: Directionality.of(context),
                          start: 6,
                          top: -10,
                          child: InkWell(
                            onTap: () {
                              showActionDialogWidget(
                                context: context,
                                icon: ImagePaths.warning,
                                secondaryAction: () {
                                  Navigator.pop(context);
                                  _videoPath = "";
                                  //_navigateBackEvent();
                                  //_bloc.add(RemoveVideoEvent());
                                },
                                primaryAction: () {
                                  Navigator.pop(context);
                                  //_navigateBackEvent();
                                },
                                secondaryText: "Yes",
                                primaryText: "No",
                                text: "areYouSureYouWantToDeleteThisVideo",
                              );
                            },
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: const BoxDecoration(
                                color: ColorSchemes.white,
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                ImagePaths.close,
                                fit: BoxFit.scaleDown,
                                color: ColorSchemes.gray,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // _navigateToPlayVideoScreenEvent(
                      //     selectedVideo, videoPlayerController!);
                      Navigator.pushNamed(context, AppRoutes.playVideoScreen,
                          arguments: {
                            "video": File(_videoPath),
                            "videoPlayerController": videoPlayerController
                          });
                    },
                    child: SvgPicture.asset(
                      fit: BoxFit.scaleDown,
                      ImagePaths.play,
                      color: Colors.white,
                      width: 45,
                      height: 45,
                    ),
                  ),
                  Positioned.directional(
                    end: 18,
                    bottom: 18,
                    textDirection: Directionality.of(context),
                    child: Text(
                      formatTime(videoPlayerController!.value.duration),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorSchemes.white,
                          ),
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink();
  }

  Widget _audioWidget() {
    return _audioPath.isEmpty
        ? const SizedBox.shrink()
        : AudioWidget(
            audioPath: _audioPath,
            onClearAudioTap: () {
              showActionDialogWidget(
                context: context,
                icon: ImagePaths.warning,
                secondaryAction: () {
                  Navigator.pop(context);
                  _audioPath = "";
                  setState(() {});
                  // _removeAudioFileEvent();
                },
                primaryAction: () {
                  Navigator.pop(context);
                },
                secondaryText: "yes",
                primaryText: "no",
                text: "areYouSureYouWantToDeleteThisAudio",
              );
            },
          );
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
    FocusScope.of(context).unfocus();
    if (_images.length == widget.maxlengthOfImages && type == "image") {
      showMessageDialogWidget(
        context: context,
        text: "youHaveReachedTheMaximumImageLimit",
        icon: ImagePaths.info,
        buttonText: "ok",
        onTap: () {
          Navigator.pop(context);
        },
      );
    } else {
      showBottomSheetUploadMedia(
        context: context,
        onTapCamera: () async {
          if (await PermissionServiceHandler().handleServicePermission(
            setting: PermissionServiceHandler.getCameraPermission(),
          )) {
            Navigator.pop(context);
            if (type == "image") {
              _pickImage(context);
            } else {
              _pickVideo(context, maxDuration);
            }
          } else if (!await PermissionServiceHandler().handleServicePermission(
            setting: PermissionServiceHandler.getCameraPermission(),
          )) {
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
          Permission permission = type == "image"
              ? PermissionServiceHandler.getGalleryPermission(
                  true,
                  androidDeviceInfo: Platform.isAndroid
                      ? await DeviceInfoPlugin().androidInfo
                      : null,
                )
              : PermissionServiceHandler.getSingleVideoGalleryPermission(
                  androidDeviceInfo: Platform.isAndroid
                      ? await DeviceInfoPlugin().androidInfo
                      : null,
                );
          if (await PermissionServiceHandler().handleServicePermission(
            setting: permission,
          )) {
            Navigator.pop(context);
            if (type == "image") {
              _getImageFromGallery(context);
            } else {
              _getVideoFromGallery(context);
            }
          } else if (!await PermissionServiceHandler()
              .handleServicePermission(setting: permission)) {
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
  }

  void _pickImage(BuildContext context) async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedImage != null) {
      _images.add(pickedImage);
      _errorProblemMessage = null;
      _bloc.add(OnNeedPaymentAddGalleryEvent(_images));
    }
  }

  List<AssetEntity> imagesAssets = [];

  void _getImageFromGallery(BuildContext context) async {
    List<AssetEntity>? images = [];
    //to pick multiple images or single image
    //to pick multiple video or single video
    //to pick multiple audio or single audio
    images = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        selectedAssets: imagesAssets, //list select before add images
        maxAssets: widget.maxlengthOfImages - _images.length,
        requestType: RequestType.image, //type of media
      ),
    );

    if (images != null) {
      imagesAssets = images;
    }
    List<File> imagesList = [];

    await convertAssetEntitiesToFiles(images).then((value) {
      imagesList = value;
    });
    for (int i = 0; i < imagesList.length; i++) {
      if (!_images.contains(XFile(imagesList[i].path))) {
        _images.add(XFile(imagesList[i].path));
      }
    }
    _errorProblemMessage = null;
    _bloc.add(OnNeedPaymentAddGalleryEvent(_images));
    //_bloc.add(AddMultipleImagesEvent(images: imagesList));
    // final pickedImage = await ImagePicker().pickImage(
    //   source: ImageSource.gallery,
    // );
    // if (pickedImage != null) {
    //   _images.add(pickedImage);
    //   _errorProblemMessage = null;
    //   //_bloc.add(OnNeedPaymentAddGalleryEvent(_images));
    // }
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

  Future<Uint8List?> generateThumbnail(String videoPath) async {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: videoPath,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128,
      quality: 100,
    );
    return uint8list;
  }
}
