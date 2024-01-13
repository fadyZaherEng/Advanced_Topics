import 'package:file_picker/file_picker.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/new/permission_service_handler.dart';
import 'package:flutter_advanced_topics/src/core/utils/show_action_dialog_widget.dart';
import 'package:permission_handler/permission_handler.dart';

void openFile(bool isMandatory, context) async {
  if (await PermissionServiceHandler().handleServicePermission(
    setting: Permission.storage,
  )) {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      // _bloc.add(LoansBackEvent());
      // _bloc.add(LoansSelectFileEvent(
      //     filePath: result.files.single.path!, isMandatory: isMandatory));
    }
  } else {
    showActionDialogWidget(
      context: context,
      icon: ImagePaths.filePdf,
      primaryAction: () {
        openAppSettings().then((value) async {
          if (await PermissionServiceHandler()
              .handleServicePermission(setting: Permission.storage)) {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['pdf'],
            );
            if (result != null) {
              // _bloc.add(LoansBackEvent());
              // _bloc.add(LoansSelectFileEvent(
              //     filePath: result.files.single.path!,
              //     isMandatory: isMandatory));
            }
          }
        });
      },
      secondaryAction: () {
        //_bloc.add(LoansBackEvent());
      },
      primaryText: "ok",
      secondaryText: "cancel",
      text: "youShouldHaveStoragePermission",
    );
  }
}
