import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/flavors.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/base/widget/base_stateful_widget.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/new_utils/permission_service_handler.dart';
import 'package:flutter_advanced_topics/src/core/utils/new_utils/show_action_dialog_widget.dart';
import 'package:flutter_advanced_topics/src/core/utils/show_bottom_sheet_upload_media.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/button/custom_button_internet_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/dynamic_questions/bloc_dynamic_questions/dynamic_questions_bloc.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/dynamic_questions/bloc_dynamic_questions/dynamic_questions_event.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/dynamic_questions/bloc_dynamic_questions/dynamic_questions_state.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/dynamic_questions/questions_code.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/extra_fields/date_text_field_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/extra_fields/extra_text_field_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/extra_fields/multi_selection_field_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/extra_fields/numaric_text_field_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/extra_fields/signle_selection_field_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/extra_fields/upload_image_field_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/new_media/utils/compress_file.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class DynamicQuestionsBottomSheetWidget extends BaseStatefulWidget {
  final List<PageField> questions;
  final Function(List<PageField>) onOkPressed;

  const DynamicQuestionsBottomSheetWidget({
    Key? key,
    required this.questions,
    required this.onOkPressed,
  }) : super(key: key);

  @override
  BaseState<DynamicQuestionsBottomSheetWidget> baseCreateState() =>
      _DynamicQuestionsBottomSheetWidgetState();
}

class _DynamicQuestionsBottomSheetWidgetState
    extends BaseState<DynamicQuestionsBottomSheetWidget> {
  DynamicQuestionsBloc get _bloc =>
      BlocProvider.of<DynamicQuestionsBloc>(context);

  List<PageField> _questions = [];

  @override
  void initState() {
    super.initState();
    _questions = widget.questions;
    for (int i = 0; i < _questions.length; i++) {
      _questions[i] = _questions[i].copyWith(
        notAnswered: false,
      );
    }
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<DynamicQuestionsBloc, DynamicQuestionsState>(
      listener: (context, state) {
        if (state is UpdateDynamicQuestionState) {
          _questions = state.questions;
        } else if (state is AskForCameraPermissionState) {
          _askForCameraPermission(state.onTab, state.isGallery);
        } else if (state is OpenMediaBottomSheetState) {
          showBottomSheetUploadMedia(
            context: context,
            onTapGallery: () {
              _navigateBackEvent();
              _askForCameraPermissionEvent(
                () {
                  _galleryPressedEvent(
                    questions: state.questions,
                    question: state.question,
                  );
                },
                true,
              );
            },
            onTapCamera: () {
              _navigateBackEvent();
              _askForCameraPermissionEvent(() {
                _cameraPressedEvent(
                  questions: state.questions,
                  question: state.question,
                );
              }, false);
            },
          );
        } else if (state is OpenCameraState) {
          _getImage(
            ImageSource.camera,
            questions: state.questions,
            question: state.question,
          );
        } else if (state is OpenGalleryState) {
          _getImage(
            ImageSource.gallery,
            questions: state.questions,
            question: state.question,
          );
        } else if (state is NavigateBackState) {
          _navigateBack();
        } else if (state is AllQuestionAnsweredState) {
          widget.onOkPressed(state.questions);
        } else if (state is ScrollToUnAnsweredMandatoryQuestionState) {
          Scrollable.ensureVisible(state.key.currentContext!);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              ...createDynamicQuestions(),
              const SizedBox(
                height: 32,
              ),
              CustomButtonInternetWidget(
                width: double.infinity,
                onTap: () {
                  _bloc.add(
                    CheckValidationForAllQuestionEvent(questions: _questions),
                  );
                },
                text: "ok",
                backgroundColor: F.appFlavor == Flavor.staging
                    ? ColorSchemes.backButtonBorderGray
                    : ColorSchemes.primary,
              ),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> createDynamicQuestions() {
    List<Widget> list = [];
    for (var question in _questions) {
      if (question.code == QuestionsCode.singleChoice) {
        list.add(SingleSelectionFieldWidget(
          horizontalPadding: 0,
          verticalPadding: 16,
          pageField: question,
          selectAnswer: (answerId) {
            _bloc.add(SelectSingleSelectionAnswerEvent(
              questions: _questions,
              question: question,
              answerId: answerId,
            ));
          },
        ));
      } else if (question.code == QuestionsCode.multiChoice) {
        list.add(MultiSelectionFieldWidget(
          horizontalPadding: 0,
          verticalPadding: 16,
          pageField: question,
          selectAnswer: (answerId) {
            _bloc.add(SelectMultiSelectionAnswerEvent(
              questions: _questions,
              answerId: answerId,
              question: question,
            ));
          },
        ));
      } else if (question.code == QuestionsCode.date) {
        list.add(DateTextFieldWidget(
          horizontalPadding: 0,
          verticalPadding: 16,
          pageField: question,
          deleteDate: () {
            _bloc.add(DeleteQuestionAnswerEvent(
              questions: _questions,
              question: question,
            ));
          },
          pickDate: (answer) {
            _bloc.add(AddAnswerToQuestionEvent(
              questions: _questions,
              answer: answer,
              question: question,
            ));
          },
        ));
      } else if (question.code == QuestionsCode.text) {
        list.add(ExtraTextFieldWidget(
          horizontalPadding: 0,
          verticalPadding: 16,
          pageField: question,
          updateAnswer: false,
          addAnswer: (answer) {
            _bloc.add(AddAnswerToQuestionEvent(
              questions: _questions,
              answer: answer,
              question: question,
            ));
          },
        ));
      } else if (question.code == QuestionsCode.number) {
        list.add(NumericTextFieldWidget(
            horizontalPadding: 0,
            verticalPadding: 16,
            pageField: question,
            updateAnswer: false,
            addAnswer: (answer) {
              _bloc.add(AddAnswerToQuestionEvent(
                questions: _questions,
                answer: answer,
                question: question,
              ));
            }));
      } else if (question.code == QuestionsCode.image) {
        list.add(UploadImageFieldWidget(
          horizontalPadding: 0,
          verticalPadding: 16,
          pageField: question,
          showUploadImageBottomSheet: () {
            _bloc.add(OpenMediaBottomSheetEvent(
              questions: _questions,
              question: question,
            ));
          },
          showDialogToDeleteImage: () {
            _showActionDialog(
              icon: ImagePaths.warning,
              text: "areYouSureYouWantToDeleteThisImage",
              primaryText: "no",
              onPrimaryAction: () {
                _navigateBackEvent();
              },
              secondaryText: "yes",
              onSecondaryAction: () {
                _bloc.add(DeleteQuestionImageEvent(
                  questions: _questions,
                  question: question,
                ));
                _navigateBackEvent();
              },
            );
          },
        ));
      }
    }
    return list;
  }

  void _cameraPressedEvent({
    List<PageField>? questions,
    PageField? question,
  }) {
    _bloc.add(CameraPressedEvent(
      questions: questions,
      question: question,
    ));
  }

  void _galleryPressedEvent({
    List<PageField>? questions,
    PageField? question,
  }) {
    _bloc.add(GalleryPressedEvent(
      questions: questions,
      question: question,
    ));
  }

  void _askForCameraPermissionEvent(Function() onTab, bool isGallery) {
    _bloc.add(AskForCameraPermissionEvent(
        onTab: () {
          onTab();
        },
        isGallery: isGallery));
  }

  void _askForCameraPermission(
    Function() onTab,
    bool isGallery,
  ) async {
    bool cameraPermission = await PermissionServiceHandler()
        .handleServicePermission(
            setting: isGallery
                ? PermissionServiceHandler.getSingleImageGalleryPermission()
                : PermissionServiceHandler.getCameraPermission());
    if (cameraPermission) {
      onTab();
    } else {
      _showActionDialog(
        icon: ImagePaths.warning,
        onPrimaryAction: () async {
          _navigateBackEvent();
          openAppSettings().then((value) {
            if (value == true) {
              onTab();
            }
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
  }

  Future<void> _getImage(
    ImageSource imageSource, {
    List<PageField>? questions,
    PageField? question,
  }) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: imageSource);
    XFile? imageFile = pickedFile;
    if (imageFile == null) {
      return;
    }
    XFile? compressedImage = await compressFile(File(imageFile.path));
    if (compressedImage == null) {
      return;
    }
    if (questions != null && question != null) {
      _bloc.add(SelectQuestionImageEvent(
        questions: questions,
        question: question,
        imagePath: compressedImage.path,
      ));
    }
  }

  void _showActionDialog({
    required Function() onPrimaryAction,
    required Function() onSecondaryAction,
    required String primaryText,
    required String secondaryText,
    required String text,
    required String icon,
  }) {
    showActionDialogWidget(
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

  void _navigateBackEvent() {
    _bloc.add(NavigateBackEvent());
  }

  void _navigateBack() {
    Navigator.pop(context);
  }
}
