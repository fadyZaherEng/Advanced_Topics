// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:audio_session/audio_session.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_topics/src/config/route/routes_manager.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/base/widget/base_stateful_widget.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/new/permission_service_handler.dart';
import 'package:flutter_advanced_topics/src/core/utils/new/show_action_dialog_widget.dart';
import 'package:flutter_advanced_topics/src/core/utils/show_bottom_sheet_upload_media.dart';
import 'package:flutter_advanced_topics/src/core/utils/show_massage_dialog_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/button/custom_button_internet_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/new_media/add_payment/add_payment_bloc.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/new_media/audio_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/new_media/custom_text_filed_service_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/new_media/describe_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/new_media/images_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/new_media/models.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/new_media/utils/convert_asset_entities_to_files.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/new_media/utils/formate_time.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skeletons/skeletons.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class AddPaymentBottomSheet extends BaseStatefulWidget {
  final int id;
  final Function(bool)? onClose;

  const AddPaymentBottomSheet({
    super.key,
    required this.id,
    this.onClose,
  });

  @override
  BaseState<AddPaymentBottomSheet> baseCreateState() =>
      _AddPaymentBottomSheetState();
}

class _AddPaymentBottomSheetState extends BaseState<AddPaymentBottomSheet> {
  AddPaymentBloc get _bloc => BlocProvider.of<AddPaymentBloc>(context);

  final TextEditingController _describeYourProblemController =
      TextEditingController();
  final TextEditingController _serviceAmountController =
      TextEditingController();

  final GlobalKey _descriptionKey = GlobalKey();
  final int _maxVideoDuration = 30;
  final int _maxCharacter = 150;
  final int _minCharacter = 20;
  final int _maxImageCount = 3;
  final int _miniImageCount = 1;
  final int _maxAudioDuration = 30;
  File? selectedVideo;
  bool _isDescribeYourProblemValid = true;
  List<File> images = [];
  VideoPlayerController? videoPlayerController;

  final bool _isAudioIconVisible = true;
  final bool _isImageIconVisible = true;
  final bool _isVideoIconVisible = true;

  var describeWidgetKey = GlobalKey();

  int selectedCameraImages = 0;
  List<AssetEntity> imagesAssets = [];
  List<File> cameraImages = [];

  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  String _audioPath = "";
  bool _isReachedMax = false;

  final List<WidgetModel> _widgets = [];
  String? _serviceAmountErrorMessage;

  @override
  void didUpdateWidget(covariant AddPaymentBottomSheet oldWidget) {
    //callback for update widget after set state called or emit for bloc to rebuild widget
    widget.onClose?.call(_isCanClose());
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<AddPaymentBloc, AddPaymentState>(
      listener: (context, state) async {
        if (state is ShowLoadingState) {
          showLoading();
        } else if (state is HideLoadingState) {
          hideLoading();
        } else if (state is ShowVideoSkeletonState) {
          _widgets.removeWhere(
            (element) => element.id == WidgetId.video,
          );
        } else if (state is DescribeProblemValidState) {
          _isDescribeYourProblemValid = true;
        } else if (state is DescribeProblemInvalidState) {
          _isDescribeYourProblemValid = false;
        } else if (state is NavigateBackState) {
          Navigator.pop(context);
        } else if (state is OpenMediaBottomSheetState) {
          _onOpenMediaBottomSheetState(
            mediaType: state.mediaType,
          );
        } else if (state is AddImageState) {
          selectedCameraImages++;
          cameraImages.add(state.image);
          await convertAssetEntitiesToFiles(imagesAssets).then((value) {
            _addImages(cameraImages, value, true);
          });
        } else if (state is AddMultipleImageState) {
          _addImages(cameraImages, state.images, false);
        } else if (state is NoImageSelectedState) {
        } else if (state is AddVideoState) {
          _onAddVideoState(
            video: state.video,
            imageSource: state.imageSource,
          );
        } else if (state is NoVideoSelectedState) {
        } else if (state is NavigateToVideoTrimmerScreenState) {
          _onNavigateToTrimmerScreenState(
            video: state.video,
            maxDuration: state.maxDuration,
          );
        } else if (state is RemoveVideoState) {
          videoPlayerController!.pause();
          videoPlayerController!.dispose();
          videoPlayerController = null;
          selectedVideo = null;
          _widgets.removeWhere(
            (element) => element.id == WidgetId.video,
          );
        } else if (state is RemoveImageState) {
          images = state.images;
          _widgets.removeWhere(
            (element) => element.id == WidgetId.image,
          );
          _widgets.add(WidgetModel(
            widget: _imagesWidget(),
            id: WidgetId.image,
          ));
          if (state.index < imagesAssets.length) {
            imagesAssets.removeAt(state.index);
          } else {
            cameraImages.removeAt(state.index - imagesAssets.length);
            selectedCameraImages--;
          }
          FocusScope.of(context).unfocus();
        } else if (state is InitializeRecorderState) {
          if (Platform.isIOS) {
            await _handleIOSAudio();
          }
          _isReachedMax = false;
          await _recorder.openRecorder();
          if (_recorder.isRecording) {
            _stopRecorderEvent();
          } else {
            _startRecorderEvent();
          }
        } else if (state is StartRecordingState) {
          _startRecording();
        } else if (state is StopRecordingState) {
          _stopRecording();
        } else if (state is SaveAudioPathState) {
          _audioPath = state.audioPath;
          _widgets.removeWhere(
            (element) => element.id == WidgetId.audio,
          );
          _widgets.add(WidgetModel(
            widget: _audioWidget(),
            id: WidgetId.audio,
          ));
          FocusScope.of(context).unfocus();
        } else if (state is RemoveAudioFileState) {
          _audioPath = "";
          _widgets.removeWhere(
            (element) => element.id == WidgetId.audio,
          );
          if (state.isReplace) {
            setState(() {});
            await Future.delayed(const Duration(seconds: 1));
            _bloc.add(SaveAudioPathEvent(audioPath: state.audioPath));
          }
        } else if (state is AudioStatusChangeState) {
          if (state.duration == _maxAudioDuration && _isReachedMax == false) {
            _isReachedMax = true;
            _stopRecorderEvent();
          }
        } else if (state is SubmitPaymentSuccessState) {
          showMessageDialogWidget(
            context: context,
            text: state.message,
            icon: ImagePaths.success,
            buttonText: "ok",
            onTap: () {
              _navigateBackEvent();
              _navigateBackEvent();
              _navigateBackEvent();
            },
          );
        } else if (state is SubmitPaymentErrorState) {
          showMessageDialogWidget(
            context: context,
            text: state.message,
            icon: ImagePaths.error,
            buttonText: "ok",
            onTap: () {
              _navigateBackEvent();
            },
          );
        } else if (state is ServiceAmountValidState) {
          _serviceAmountErrorMessage = null;
        } else if (state is ServiceAmountInvalidState) {
          _serviceAmountErrorMessage = " thisFieldIsRequired";
        } else if (state is OneAttachmentRequiredState) {
          Fluttertoast.showToast(
            msg: "toastMessage",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorSchemes.redError,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
        widget.onClose?.call(_isCanClose());
      },
      builder: (context, state) {
        return WillPopScope(
            //call when you press back button
            //to close bottom sheet and go back to previous screen
            // and in on will pop implementation of condition of back button
            onWillPop: () async {
              if (_describeYourProblemController.text.isNotEmpty ||
                  _serviceAmountController.text.isNotEmpty ||
                  images.isNotEmpty ||
                  _audioPath.isNotEmpty ||
                  selectedVideo != null) {
                showActionDialogWidget(
                  context: context,
                  text: "allChangesWillBeLostIfYouLeaveThisPage",
                  icon: ImagePaths.warning,
                  primaryAction: () {
                    Navigator.pop(context);
                  },
                  secondaryAction: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  primaryText: "keep",
                  secondaryText: "discard",
                );
              } else {
                Navigator.pop(context);
              }
              return true;
            },
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    key: describeWidgetKey,
                    children: [
                      DescribeWidget(
                        maxLength: _maxCharacter,
                        minLength: _minCharacter,
                        maxAudioLength: _maxAudioDuration,
                        describeText: "describeYourProblem",
                        key: _descriptionKey,
                        isRecording: _recorder.isRecording,
                        onProgress: _recorder.onProgress,
                        remainingCharacter: _maxCharacter -
                            _describeYourProblemController.value.text
                                .toString()
                                .length,
                        onVideoTap: () => _onTapVideo(),
                        onGalleryTap: () => _onTapGallery(),
                        onMicrophoneTap: () {
                          _onTapMicrophone();
                        },
                        describeController: _describeYourProblemController,
                        onDescribeChanged: (value) {
                          _bloc.add(DescribeProblemValidationEvent(
                            value: value,
                            max: _maxCharacter,
                            min: _minCharacter,
                          ));
                        },
                        isDescribeValid: _isDescribeYourProblemValid,
                        isVideoIconVisible: _isVideoIconVisible,
                        isImageIconVisible: _isImageIconVisible,
                        isAudioIconVisible: _isAudioIconVisible,
                      ),
                      Column(
                        children: _widgets.map((e) => e.widget).toList(),
                      ),
                      state is ShowVideoSkeletonState
                          ? _buildVideoSkeleton()
                          : const SizedBox.shrink(),
                      const SizedBox(
                        height: 16,
                      ),
                      _buildAmountField(),
                      const SizedBox(
                        height: 16,
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16, right: 16, left: 16),
                        child: CustomButtonInternetWidget(
                          onTap: () {
                            _bloc.add(SubmitPaymentEvent(
                              requestId: widget.id,
                              description: _describeYourProblemController.text
                                  .trim()
                                  .toString(),
                              images: images,
                              audioPath: _audioPath,
                              videoFile: selectedVideo != null
                                  ? selectedVideo!.path
                                  : "",
                              min: _minCharacter,
                              amount: _serviceAmountController.text.trim(),
                            ));
                          },
                          text: "submit",
                          width: double.infinity,
                          height: 50,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }

  Widget _videoWidget() {
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
                              _navigateToPlayVideoScreenEvent(
                                  selectedVideo, videoPlayerController!);
                            },
                            child: SizedBox(
                              height: 150,
                              child: FutureBuilder<Uint8List?>(
                                future: generateThumbnail(selectedVideo!.path),
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
                                    return _buildPlaceHolderImage();
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
                              _showActionDialog(
                                icon: ImagePaths.warning,
                                onSecondaryAction: () {
                                  _navigateBackEvent();
                                  _bloc.add(RemoveVideoEvent());
                                },
                                onPrimaryAction: () {
                                  _navigateBackEvent();
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
                      _navigateToPlayVideoScreenEvent(
                          selectedVideo, videoPlayerController!);
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

  Widget _imagesWidget() {
    return ImageWidgets(
      images: images,
      imagesMaxNumber: _maxImageCount,
      imagesMinNumber: _miniImageCount,
      onAddImageTap: () {
        _openMediaBottomSheetEvent(
          mediaType: MediaType.image,
        );
      },
      onClearImageTap: (index) {
        _showActionDialog(
          icon: ImagePaths.warning,
          text: "areYouSureYouWantToDeleteThisImage",
          primaryText: "No",
          onPrimaryAction: () {
            _navigateBackEvent();
          },
          secondaryText: "Yes",
          onSecondaryAction: () {
            _navigateBackEvent();
            _removeImageEvent(
              images,
              index,
            );
          },
        );
      },
    );
  }

  Widget _audioWidget() {
    return _audioPath.isEmpty
        ? const SizedBox.shrink()
        : AudioWidget(
            audioPath: _audioPath,
            onClearAudioTap: () {
              _showActionDialog(
                icon: ImagePaths.warning,
                onSecondaryAction: () {
                  _navigateBackEvent();
                  _removeAudioFileEvent();
                },
                onPrimaryAction: () {
                  _navigateBackEvent();
                },
                secondaryText: "yes",
                primaryText: "no",
                text: "areYouSureYouWantToDeleteThisAudio",
              );
            },
          );
  }

  Widget _buildPlaceHolderImage() {
    return Image.asset(
      ImagePaths.imagePlaceHolder,
      fit: BoxFit.fill,
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

  Widget _buildAmountField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomTextFiledServiceWidget(
        textEditingController: _serviceAmountController,
        errorMessage: _serviceAmountErrorMessage,
        onChanged: (value) {
          _bloc.add(ValidateServiceAmountEvent(value: value ?? ""));
        },
      ),
    );
  }

  void _onTapVideo() {
    FocusScope.of(context).unfocus();
    if (selectedVideo != null) {
      _showActionDialog(
        icon: ImagePaths.warning,
        onPrimaryAction: () {
          _navigateBackEvent();
        },
        primaryText: "no",
        onSecondaryAction: () {
          _navigateBackEvent();
          _openMediaBottomSheetEvent(
            mediaType: MediaType.video,
          );
        },
        secondaryText: "yes",
        text: "areYouWantToChooseAnotherVideo",
      );
    } else {
      _openMediaBottomSheetEvent(
        mediaType: MediaType.video,
      );
    }
  }

  void _onTapGallery() {
    FocusScope.of(context).unfocus();
    if (images.length == _maxImageCount) {
      showMessageDialogWidget(
        context: context,
        text: "youHaveReachedTheMaximumImageLimit",
        icon: ImagePaths.info,
        buttonText: "ok",
        onTap: () {
          _navigateBackEvent();
        },
      );
    } else {
      _openMediaBottomSheetEvent(
        mediaType: MediaType.image,
      );
    }
  }

  Future<void> _onTapMicrophone() async {
    FocusScope.of(context).unfocus();
    if (_audioPath.isNotEmpty && !_recorder.isRecording) {
      _showActionDialog(
        icon: ImagePaths.warning,
        onPrimaryAction: () {
          _navigateBackEvent();
        },
        primaryText: "no",
        onSecondaryAction: () async {
          _navigateBackEvent();
          //init Recording with replace
          if (await _requestMicrophonePermission()) {
            _initializeRecorderEvent();
          }
        },
        secondaryText: "yes",
        text: "areYouWantToChooseAnotherAudio",
      );
    } else {
      //init Recording
      if (await _requestMicrophonePermission()) {
        _initializeRecorderEvent();
      }
    }
  }

  //some configuration for start record in ios
  Future<void> _handleIOSAudio() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));
  }

  Future<bool> _requestMicrophonePermission() async {
    bool isGranted = false;

    isGranted = await PermissionServiceHandler().handleServicePermission(
        setting: PermissionServiceHandler.getMicrophonePermission());

    if (isGranted) return true;

    _showActionDialog(
      icon: ImagePaths.warning,
      onPrimaryAction: () {
        _navigateBackEvent();
        openAppSettings().then((value) async {
          isGranted = await PermissionServiceHandler().handleServicePermission(
              setting: PermissionServiceHandler.getMicrophonePermission());
          return isGranted;
        });
      },
      onSecondaryAction: () {
        _navigateBackEvent();
      },
      primaryText: "ok",
      secondaryText: "cancel",
      text: "youShouldHaveMicroPhonePermission",
    );

    return isGranted;
  }

  Future<void> _initializeRecorderEvent() async {
    _bloc.add(InitializeRecorderEvent());
  }

  Future<void> _startRecorderEvent() async {
    _bloc.add(StartRecordingEvent());
  }

  Future<void> _stopRecorderEvent() async {
    _bloc.add(StopRecordingEvent());
  }

  Future<void> _removeAudioFileEvent({
    String audioPath = "",
    bool isReplace = false,
  }) async {
    _bloc.add(RemoveAudioFileEvent(
      isReplace: isReplace,
      audioPath: audioPath,
    ));
  }

  Future<void> _startRecording() async {
    Directory? dir;
    if (Platform.isIOS) {
      dir = await getApplicationDocumentsDirectory();
    } else {
      dir = await getApplicationDocumentsDirectory();
    }
    await _recorder.setSubscriptionDuration(const Duration(
      milliseconds: 500,
    ));
    await _recorder.startRecorder(toFile: "${dir.path}/audio.aac");
    _recorder.onProgress!.listen((time) async {
      _bloc.add(AudioStatusChangeEvent(
        isRecording: true,
        duration: time.duration.inSeconds,
      ));
    });
  }

  Future<void> _stopRecording() async {
    String audioPath = await _recorder.stopRecorder() ?? "";
    if (_audioPath.isEmpty) {
      _bloc.add(const AudioStatusChangeEvent(
        isRecording: false,
        duration: 0,
      ));
      _bloc.add(SaveAudioPathEvent(audioPath: audioPath));
    } else {
      _removeAudioFileEvent(
        isReplace: true,
        audioPath: audioPath,
      );
    }
  }

  void _onOpenMediaBottomSheetState({
    required MediaType mediaType,
  }) {
    showBottomSheetUploadMedia(
      context: context,
      onTapCamera: () async {
        _navigateBackEvent();
        if (await PermissionServiceHandler().handleServicePermission(
          setting: PermissionServiceHandler.getCameraPermission(),
        )) {
          if (mediaType == MediaType.image) {
            _getImage(ImageSource.camera);
          } else {
            _getVideo(ImageSource.camera);
          }
        } else {
          _showActionDialog(
            icon: ImagePaths.warning,
            onPrimaryAction: () {
              _navigateBackEvent();
              openAppSettings().then((value) async {
                if (await PermissionServiceHandler().handleServicePermission(
                    setting: PermissionServiceHandler.getCameraPermission())) {}
              });
            },
            onSecondaryAction: () {
              _navigateBackEvent();
            },
            primaryText: "ok",
            secondaryText: "cancel",
            text: "youShouldHaveCameraPermission",
          );
        }
      },
      onTapGallery: () async {
        _navigateBackEvent();
        Permission permission = mediaType == MediaType.image
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
          if (mediaType == MediaType.image) {
            _getImage(ImageSource.gallery);
          } else {
            _getVideo(ImageSource.gallery);
          }
        } else {
          _showActionDialog(
            icon: ImagePaths.warning,
            onPrimaryAction: () {
              _navigateBackEvent();
              openAppSettings().then((value) async {
                if (await PermissionServiceHandler().handleServicePermission(
                  setting: permission,
                )) {}
              });
            },
            onSecondaryAction: () {
              _navigateBackEvent();
            },
            primaryText: "ok",
            secondaryText: "cancel",
            text: "youShouldHaveCameraPermission",
          );
        }
      },
    );
  }

  Future<void> _getImage(
    ImageSource img,
  ) async {
    if (img == ImageSource.gallery) {
      List<AssetEntity>? images = [];

      images = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          selectedAssets: imagesAssets,
          maxAssets: _maxImageCount - selectedCameraImages,
          requestType: RequestType.image,
        ),
      );

      if (images != null) {
        imagesAssets = images;
      }
      List<File> imagesList = [];

      await convertAssetEntitiesToFiles(images).then((value) {
        imagesList = value;
      });

      for (int i = 0; i < cameraImages.length; i++) {
        if (!imagesList.contains(cameraImages[i])) {
          imagesList.add(cameraImages[i]);
        }
      }
      _bloc.add(AddMultipleImagesEvent(images: imagesList));
    } else {
      final ImagePicker picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: img,
      );
      XFile? imageFile = pickedFile;
      _bloc.add(AddImageEvent(image: imageFile));
    }
  }

  Future<void> _getVideo(
    ImageSource img,
  ) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickVideo(
        source: img,
        maxDuration: Duration(
          seconds: _maxVideoDuration,
        ));
    XFile? videoFile = pickedFile;
    _bloc.add(AddVideoEvent(
      video: videoFile,
      imageSource: img,
    ));
  }

  Future _showActionDialog({
    required Function() onPrimaryAction,
    required Function() onSecondaryAction,
    required String primaryText,
    required String secondaryText,
    required String text,
    required String icon,
  }) {
    return showActionDialogWidget(
      context: context,
      text: text,
      primaryText: primaryText,
      primaryAction: () {
        onPrimaryAction();
      },
      secondaryText: secondaryText,
      secondaryAction: () {
        onSecondaryAction();
      },
      icon: icon,
    );
  }

  void _openMediaBottomSheetEvent({
    required MediaType mediaType,
  }) {
    _bloc.add(OpenMediaBottomSheetEvent(
      mediaType: mediaType,
    ));
  }

  void _removeImageEvent(
    List<File> images,
    int index,
  ) {
    return _bloc.add(RemoveImageEvent(
      images: images,
      index: index,
    ));
  }

  void _navigateBackEvent() => _bloc.add(NavigateBackEvent());

  void _addImages(
      List<File> cameraImages, List<File> galleryImages, bool isFromCamera) {
    images.clear();
    if (galleryImages.isNotEmpty) {
      images.addAll(galleryImages);
    }
    if (cameraImages.isNotEmpty && isFromCamera) {
      images.addAll(cameraImages);
    }
    _widgets.removeWhere(
      (element) => element.id == WidgetId.image,
    );
    _widgets.add(WidgetModel(
      widget: _imagesWidget(),
      id: WidgetId.image,
    ));
    FocusScope.of(context).unfocus();
    setState(() {});
  }

  void _onAddVideoState({
    required File video,
    required ImageSource imageSource,
  }) {
    selectedVideo = video;
    videoPlayerController = VideoPlayerController.file(
      selectedVideo!,
    )..initialize().then((_) {
        if (videoPlayerController!.value.duration.inSeconds >
            _maxVideoDuration) {
          _bloc.add(NavigateToVideoTrimmerScreenEvent(
            video: selectedVideo!,
            maxDuration: _maxVideoDuration,
          ));
          selectedVideo = null;
          videoPlayerController = null;
        } else {
          _widgets.removeWhere(
            (element) => element.id == WidgetId.video,
          );
          setState(() {});
          _widgets.add(WidgetModel(
            widget: _videoWidget(),
            id: WidgetId.video,
          ));
          FocusScope.of(context).unfocus();
        }
      });
  }

  void _navigateToPlayVideoScreenEvent(
      File? selectedVideo, VideoPlayerController videoPlayerController) {
    Navigator.pushNamed(
      context,
      AppRoutes.playVideoScreen,
      arguments: {
        "video": selectedVideo ?? File(""),
        "videoPlayerController": videoPlayerController,
      },
    );
  }

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
        selectedVideo = File(value as String);
        videoPlayerController = VideoPlayerController.file(
          selectedVideo!,
        )..initialize().then((_) {
            _widgets.removeWhere(
              (element) => element.id == WidgetId.video,
            );
            setState(() {});
            _widgets.add(WidgetModel(
              widget: _videoWidget(),
              id: WidgetId.video,
            ));
            FocusScope.of(context).unfocus();
          });
      }
    });
  }

  bool _isCanClose() {
    if (_describeYourProblemController.text.isNotEmpty ||
        _serviceAmountController.text.isNotEmpty ||
        images.isNotEmpty ||
        _audioPath.isNotEmpty ||
        selectedVideo != null) {
      return false;
    } else {
      return true;
    }
  }
}

enum MediaType {
  video,
  image,
}
