import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/bottom_sheet_upload_file_style_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/file_content_bottom_sheet_widget.dart';

Future showBottomSheetUploadFile({
  required BuildContext context,
  required Function() onTapCamera,
  required Function() onTapGallery,
  required Function() onTapFile,
}) async {
  return await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    enableDrag: false,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: BottomSheetFileStyleOfContentWidget(
        content: FileContentBottomSheetWidget(
          onTapCamera: onTapCamera,
          onTapGallery: onTapGallery,
          onTapFile: onTapFile,
        ),
        titleLabel: "Upload File",
      ),
    ),
  );
}
