import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/generated/l10n.dart';
import 'package:flutter_advanced_topics/src/config/route/routes_manager.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/new_utils/permission_service_handler.dart';
import 'package:flutter_advanced_topics/src/core/utils/new_utils/show_action_dialog_widget.dart';
import 'package:flutter_advanced_topics/src/core/utils/show_bottom_sheet_upload_media.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/add_multi_image_with_max_count/bloc/multi_image_bloc.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/add_multi_image_with_max_count/images_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/new_media/utils/compress_file.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/new_media/utils/convert_asset_entities_to_files.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/tow_way_gallerys/gallery_screen/widgets/gallery_content_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/tow_way_gallerys/gallery_screen/widgets/gallery_images_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class MultiImageScreen extends StatefulWidget {
  // final Function(PageField document, int min, int max) onAddMultipleImageTap;
  // final Function(PageField document, int index) onDeleteMultipleImageTap;
  // int maxMultipleImages;
  // int minMultipleImages;

  const MultiImageScreen({
    Key? key,
    // required this.onAddMultipleImageTap,
    // required this.onDeleteMultipleImageTap,
    // this.maxMultipleImages = 1,
    // this.minMultipleImages = 1,
  }) : super(key: key);

  @override
  State<MultiImageScreen> createState() => _MultiImageScreenState();
}

class _MultiImageScreenState extends State<MultiImageScreen> {
  int _maxMultipleImages = 3;
  int selectedMultiImagesCount = 0;
  List<AssetEntity> imagesAssets = [];
  List<File> cameraImages = [];
  PageField document = const PageField();
  bool _isImagesRequired = false;

  MultiImageBloc get _bloc => BlocProvider.of<MultiImageBloc>(context);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MultiImageBloc, MultiImageState>(
        listener: (context, state) {
      if (state is AddMultipleImageState) {
        document = state.document;
        _isImagesRequired = true;
      } else if (state is DeleteMultipleImageState) {
        document = state.document;
        _isImagesRequired = true;

        if (state.isMultiImage && state.index != -1) {
          if (state.index < imagesAssets.length) {
            imagesAssets.removeAt(state.index);
          } else {
            cameraImages.removeAt(state.index - imagesAssets.length);
            selectedMultiImagesCount--;
          }
        }
      } else if (state is SelectMultipleImageState) {
        document = state.document;
        _isImagesRequired = true;
      }
    }, builder: (context, state) {
      return Scaffold(
          body: Center(
        child: ImageWidgets(
          globalKey: document.key,
          images: document.imagesList,
          imagesMaxNumber: _getMaxImagesCount(document),
          imagesMinNumber: _getMinImagesCount(document),
          isRequired: _isImagesRequired,
          title: document.label,
          errorMessages: _getErrorMessage(document),
          onClearImageTap: (int mIndex) {
            _dialogMessage(
                icon: ImagePaths.warning,
                message: "areYouSureYouWantToDeleteThisImage",
                primaryAction: () {
                  Navigator.pop(context);
                  _bloc.add(DeleteMultipleImageEvent(
                      document: document, index: mIndex));
                });
            // widget.onDeleteMultipleImageTap(document, mIndex);
          },
          onAddImageTap: () {
            _maxMultipleImages = _getMaxImagesCount(document);
            _onOpenMediaBottomSheet(document, true);
          },
          onTapImage: (index) {
            List<GalleryAttachment> galleryImages = [];
            for (var image in document.imagesList) {
              galleryImages.add(GalleryAttachment(attachment: image.path));
            }
            Navigator.pushNamed(context, AppRoutes.galleryImagesScreen,
                arguments: GalleryImages(
                  initialIndex: index,
                  images: galleryImages,
                ));
          },
          isNeverHide: true,
        ),
      ));
    });
  }

  void _dialogMessage({
    required String message,
    required String icon,
    required Function() primaryAction,
    Function()? secondaryAction,
  }) {
    showActionDialogWidget(
        context: context,
        text: message,
        icon: icon,
        primaryText: "yes",
        secondaryText: "no",
        primaryAction: () async {
          primaryAction();
        },
        secondaryAction: () {
          secondaryAction ?? Navigator.pop(context);
        });
  }

  void _onOpenMediaBottomSheet(PageField document, [bool isMultiple = false]) {
    showBottomSheetUploadMedia(
      context: context,
      onTapCamera: () async {
        Navigator.pop(context);
        if (await PermissionServiceHandler().handleServicePermission(
          setting: PermissionServiceHandler.getCameraPermission(),
        )) {
          _getImage(document, ImageSource.camera);
        } else {
          _showActionDialog(
            icon: ImagePaths.warning,
            onPrimaryAction: () {
              Navigator.pop(context);
              openAppSettings().then((value) async {
                // if (await PermissionServiceHandler()
                //     .handleServicePermission(setting: Permission.camera)) {}
              });
            },
            onSecondaryAction: () {
              Navigator.pop(context);
            },
            primaryText: "ok",
            secondaryText: "cancel",
            text: "youShouldHaveCameraPermission",
          );
        }
      },
      onTapGallery: () async {
        Navigator.pop(context);
        if (await PermissionServiceHandler().handleServicePermission(
            setting: PermissionServiceHandler.getGalleryPermission(
          isMultiple,
          androidDeviceInfo:
              Platform.isAndroid ? await DeviceInfoPlugin().androidInfo : null,
        ))) {
          _getImage(document, ImageSource.gallery, isMultiple);
        } else {
          _showActionDialog(
            icon: ImagePaths.warning,
            onPrimaryAction: () {
              Navigator.pop(context);
              openAppSettings().then((value) async {
                // if (await PermissionServiceHandler().handleServicePermission(
                //   setting: Permission.storage,
                // )) {}
              });
            },
            onSecondaryAction: () {
              Navigator.pop(context);
            },
            primaryText: "ok",
            secondaryText: "cancel",
            text: "youShouldHaveStoragePermission",
          );
        }
      },
    );
  }

  Future<void> _getImage(
    PageField document,
    ImageSource img, [
    bool isMultiple = false,
  ]) async {
    final ImagePicker picker = ImagePicker();
    if (isMultiple) {
      List<AssetEntity>? images = [];

      images = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          selectedAssets: imagesAssets,
          maxAssets: _maxMultipleImages - selectedMultiImagesCount,
          requestType: RequestType.image,
          specialPickerType: SpecialPickerType.noPreview,
        ),
      );

      if (images != null) {
        imagesAssets = images;
      }
      List<File> imagesList = [];

      await convertAssetEntitiesToFiles(imagesAssets).then((value) {
        imagesList = value;
      });

      for (int i = 0; i < cameraImages.length; i++) {
        if (!imagesList.contains(cameraImages[i])) {
          imagesList.add(cameraImages[i]);
        }
      }

      if (document.imagesList.isEmpty) {
        document = document.copyWith(imagesList: imagesList);
      } else {
        document = document.copyWith(
          imagesList: [],
        );
        document =
            document.copyWith(imagesList: document.imagesList + imagesList);
      }
      _bloc.add(
          SelectMultipleImageEvent(document: document, images: imagesList));
    } else {
      final pickedFile = await picker.pickImage(
        source: img,
      );
      if (pickedFile != null) {
        XFile? imageFile = await compressFile(File(pickedFile.path));
        cameraImages.add(File(imageFile!.path));
        selectedMultiImagesCount++;
        document.imagesList.add(File(imageFile.path));
        setState(() {});
        // _bloc.add(AddMultipleImageEvent(document: document, image: imageFile));
      }
    }
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

  int _getMinImagesCount(PageField document) {
    for (var validation in document.validations) {
      if (validation.validationRule.code == ">") {
        return int.parse(validation.valueOne);
      }
    }
    return 1;
  }

  int _getMaxImagesCount(PageField document) {
    for (var validation in document.validations) {
      if (validation.validationRule.code == "<") {
        return int.parse(validation.valueOne);
      }
    }
    return 1;
  }

  String _getErrorMessage(PageField document) {
    for (var validation in document.validations) {
      if (validation.validationRule.code == ">") {
        return validation.validationMessage;
      }
    }
    return "";
  }
}

class PageField extends Equatable {
  final int id;
  final int typeId;
  final int eventOptionId;
  final int maxCount;
  final int minCount;
  final String code;
  final String label;
  final String description;
  final bool isRequired;
  final String value;
  final String answerId;
  final List<Choice> choices;
  final List<File> imagesList;
  final String errorMessage;
  final bool fileValid;
  final GlobalKey? key;
  final int? index;
  final bool notAnswered;
  final String expireDate;
  final bool isEditable;
  final bool isDeletable;
  final String canNotDeleteReason;
  final String canNotEditReason;
  final bool isFromServer;
  final bool isHasRelatedQuestion;
  final List<Validation> validations;
  final bool isValid;
  final String validationMessage;

  const PageField({
    this.id = 0,
    this.typeId = 0,
    this.eventOptionId = 0,
    this.maxCount = 3,
    this.minCount = 1,
    this.code = "",
    this.label = "",
    this.description = "",
    this.isRequired = false,
    this.value = "",
    this.answerId = "",
    this.choices = const [],
    this.validations = const [],
    this.imagesList = const [],
    this.errorMessage = "",
    this.fileValid = false,
    this.index = 0,
    this.key,
    this.notAnswered = false,
    this.expireDate = "",
    this.isEditable = false,
    this.isDeletable = false,
    this.canNotDeleteReason = "",
    this.canNotEditReason = "",
    this.isFromServer = false,
    this.isHasRelatedQuestion = false,
    this.isValid = true,
    this.validationMessage = "",
  });

  PageField copyWith({
    int? id,
    int? typeId,
    int? eventOptionId,
    int? maxCount,
    int? minCount,
    String? code,
    String? label,
    String? description,
    bool? isRequired,
    String? value,
    String? answerId,
    List<Choice>? choices,
    List<File>? imagesList,
    String? errorMessage,
    bool? fileValid,
    int? index,
    GlobalKey? key,
    bool? notAnswered,
    String? expireDate,
    bool? isEditable,
    bool? isDeletable,
    String? canNotDeleteReason,
    String? canNotEditReason,
    bool? isFromServer,
    bool? isHasRelatedQuestion,
    List<Validation>? validations,
    bool? isValid,
    String? validationMessage,
  }) {
    return PageField(
      id: id ?? this.id,
      typeId: typeId ?? this.typeId,
      maxCount: maxCount ?? this.maxCount,
      minCount: minCount ?? this.minCount,
      code: code ?? this.code,
      label: label ?? this.label,
      description: description ?? this.description,
      isRequired: isRequired ?? this.isRequired,
      value: value ?? this.value,
      answerId: answerId ?? this.answerId,
      choices: choices ?? this.choices,
      imagesList: imagesList ?? this.imagesList,
      errorMessage: errorMessage ?? this.errorMessage,
      fileValid: fileValid ?? this.fileValid,
      index: index ?? this.index,
      key: key ?? this.key,
      notAnswered: notAnswered ?? this.notAnswered,
      expireDate: expireDate ?? this.expireDate,
      isEditable: notAnswered ?? this.isEditable,
      isDeletable: isDeletable ?? this.isDeletable,
      canNotDeleteReason: canNotDeleteReason ?? this.canNotDeleteReason,
      canNotEditReason: canNotEditReason ?? this.canNotEditReason,
      isFromServer: isFromServer ?? this.isFromServer,
      isHasRelatedQuestion: isHasRelatedQuestion ?? this.isHasRelatedQuestion,
      validations: validations ?? this.validations,
      isValid: isValid ?? this.isValid,
      validationMessage: validationMessage ?? this.validationMessage,
      eventOptionId: eventOptionId ?? this.eventOptionId,
      //write the rest of the fields
    );
  }

  @override
  List<Object?> get props => [
        id,
        typeId,
        eventOptionId,
        maxCount,
        minCount,
        code,
        label,
        description,
        isRequired,
        value,
        answerId,
        choices,
        imagesList,
        errorMessage,
        fileValid,
        index,
        key,
        notAnswered,
        expireDate,
        isEditable,
        isDeletable,
        canNotDeleteReason,
        isFromServer,
        canNotEditReason,
        validations,
        eventOptionId,
        isHasRelatedQuestion,
        isValid,
        validationMessage
      ];

  PageField deepClone() {
    return PageField(
      id: id,
      typeId: typeId,
      eventOptionId: eventOptionId,
      maxCount: maxCount,
      minCount: minCount,
      code: code,
      label: label,
      description: description,
      isRequired: isRequired,
      value: value,
      answerId: answerId,
      choices: choices.map((choice) => choice.deepClone()).toList(),
      imagesList: imagesList.map((image) => File(image.path)).toList(),
      errorMessage: errorMessage,
      fileValid: fileValid,
      key: key,
      // Note: This will still reference the same GlobalKey
      index: index,
      notAnswered: notAnswered,
      expireDate: expireDate,
      isEditable: isEditable,
      isDeletable: isDeletable,
      canNotDeleteReason: canNotDeleteReason,
      canNotEditReason: canNotEditReason,
      isFromServer: isFromServer,
      validations: validations,
      isValid: isValid,
      validationMessage: validationMessage,
    );
  }

  @override
  String toString() {
    return 'PageField{id: $id, typeId: $typeId, eventOptionId: $eventOptionId, code: $code, label: $label, description: $description, isRequired: $isRequired, value: $value, answerId: $answerId, choices: $choices, imagesList: $imagesList, errorMessage: $errorMessage, fileValid: $fileValid, key: $key, index: $index, notAnswered: $notAnswered, expireDate: $expireDate, isEditable: $isEditable, isDeletable: $isDeletable, canNotDeleteReason: $canNotDeleteReason, canNotEditReason: $canNotEditReason, isFromServer: $isFromServer, validations: $validations isValid: $isValid}';
  }
}

class Choice extends Equatable {
  final int id;
  final String value;
  bool isSelected;
  bool isNeedMoreInformation;
  final double percentage;
  bool showPercentage;
  final int total;

  Choice({
    this.id = 0,
    this.value = "",
    this.isSelected = false,
    this.isNeedMoreInformation = false,
    this.percentage = 0,
    this.showPercentage = false,
    this.total = 0,
  });

  Choice copyWith({
    int? id,
    String? value,
    bool? isSelected,
  }) {
    return Choice(
      id: id ?? this.id,
      value: value ?? this.value,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [
        id,
        value,
        isSelected,
      ];

  Choice deepClone() {
    return Choice(
      id: this.id,
      value: this.value,
      isSelected: this.isSelected,
      isNeedMoreInformation: this.isNeedMoreInformation,
      percentage: this.percentage,
      showPercentage: this.showPercentage,
      total: this.total,
    );
  }
}

class Validation extends Equatable {
  final int id;
  final ValidationRule validationRule;
  final String valueOne;
  final String valueTwo;
  final String validationMessage;

  const Validation({
    this.id = 0,
    this.validationRule = const ValidationRule(),
    this.valueOne = "",
    this.valueTwo = "",
    this.validationMessage = "",
  });

  @override
  List<Object?> get props => [
        id,
        validationRule,
        valueOne,
        valueTwo,
        valueTwo,
        validationMessage,
      ];
}

class ValidationRule extends Equatable {
  final int id;
  final String code;

  const ValidationRule({
    this.id = 0,
    this.code = ">",
  });

  @override
  List<Object?> get props => [
        id,
        code,
      ];
}
