import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
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
  const MultiImageScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MultiImageScreen> createState() => _MultiImageScreenState();
}

class _MultiImageScreenState extends State<MultiImageScreen> {
  final int _maxMultipleImages = 3;
  final int _minMultipleImages = 1;
  int selectedMultiImagesCameraCount = 0;
  List<AssetEntity> imagesAssets = [];
  List<File> cameraImages = [];

  List<File> allImages = [];

  MultiImageBloc get _bloc => BlocProvider.of<MultiImageBloc>(context);
  bool _isImagesRequired = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MultiImageBloc, MultiImageState>(
        listener: (context, state) {
      if (state is AddMultipleImageState) {
        allImages = state.imagesList;
        _isImagesRequired = true;
      } else if (state is DeleteMultipleImageState) {
        allImages = state.imagesList;
        if (state.isMultiImage && state.index != -1) {
          print(state.index);
          print(imagesAssets.length);
          print(cameraImages.length);
          if (state.index < imagesAssets.length) {
            imagesAssets.removeAt(state.index);
          } else {
            cameraImages.removeAt(state.index - imagesAssets.length);
            selectedMultiImagesCameraCount--;
          }
        }
        _isImagesRequired = true;
      } else if (state is SelectMultipleImageState) {
        allImages = state.imagesList;
        _isImagesRequired = true;
      }
    }, builder: (context, state) {
      return Scaffold(
          body: Center(
        child: ImageWidgets(
          images: allImages,
          imagesMaxNumber: _maxMultipleImages,
          imagesMinNumber: _minMultipleImages,
          isRequired: _isImagesRequired,
          title: "Document Label",
          errorMessages: "",
          onClearImageTap: (int mIndex) {
            _dialogMessage(
                icon: ImagePaths.warning,
                message: "are You Sure You Want To Delete This Image",
                primaryAction: () {
                  Navigator.pop(context);
                  _bloc.add(DeleteMultipleImageEvent(
                      imageList: allImages, index: mIndex));
                });
          },
          onAddImageTap: () {
            _onOpenMediaBottomSheet(allImages, true);
          },
          onTapImage: (index) {
            List<GalleryAttachment> galleryImages = [];
            for (var image in allImages) {
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
        primaryText: "Yes",
        secondaryText: "No",
        primaryAction: () async {
          primaryAction();
        },
        secondaryAction: () {
          secondaryAction ?? Navigator.pop(context);
        });
  }

  void _onOpenMediaBottomSheet(List<File> allImages,
      [bool isMultiple = false]) {
    showBottomSheetUploadMedia(
      context: context,
      onTapCamera: () async {
        Navigator.pop(context);
        if (await PermissionServiceHandler().handleServicePermission(
          setting: PermissionServiceHandler.getCameraPermission(),
        )) {
          _getImage(allImages, ImageSource.camera);
        } else {
          _showActionDialog(
            icon: ImagePaths.warning,
            onPrimaryAction: () {
              Navigator.pop(context);
              openAppSettings().then((value) async {});
            },
            onSecondaryAction: () {
              Navigator.pop(context);
            },
            primaryText: "Ok",
            secondaryText: "Cancel",
            text: "you Should Have Camera Permission",
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
          _getImage(allImages, ImageSource.gallery, isMultiple);
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
    List<File> allImages,
    ImageSource img, [
    bool isMultiple = false,
  ]) async {
    final ImagePicker picker = ImagePicker();
    if (isMultiple && img == ImageSource.gallery) {
      List<AssetEntity>? images = [];

      images = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          selectedAssets: imagesAssets,
          maxAssets: _maxMultipleImages - selectedMultiImagesCameraCount,
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
      allImages.addAll(imagesList);

      // if (allImages.isEmpty) {
      // } else {
      //   allImages = [];
      //   allImages = [...allImages, ...imagesList];
      //   // document = document.copyWith(
      //   //   imagesList: [],
      //   // );
      //   // document =
      //   //     document.copyWith(imagesList: document.imagesList + imagesList);
      // }
      _bloc.add(SelectMultipleImageEvent(images: imagesList));
    } else {
      final pickedFile = await picker.pickImage(
        source: img,
      );
      if (pickedFile != null) {
        XFile? imageFile = await compressFile(File(pickedFile.path));
        cameraImages.add(File(imageFile!.path));
        selectedMultiImagesCameraCount++;
        _bloc.add(AddMultipleImageEvent(
          imageList: allImages,
          image: imageFile,
        ));
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
}
