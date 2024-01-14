import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/utils/show_bottom_sheet.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/bottom_sheet_content_widget.dart';

Future showNeedPaymentBottomSheet({
  required BuildContext context,
  required int maxLengthOfVoice,
  required int maxLengthOfVideo,
  required int maxlengthOfImages,
  required int minLengthOfImages,
  required int maxLengthOfProblem,
  required int minLengthOfProblem,
  required int requestId,
  required bool isPadding,
}) async {
  return showBottomSheetWidget(
      context: context,
      height: MediaQuery.of(context).size.height * 0.6,
      isClosed: true,
      content: BottomSheetContentWidget(
        maxLengthOfVoice: maxLengthOfVoice,
        maxLengthOfVideo: maxLengthOfVideo,
        maxlengthOfImages: maxlengthOfImages,
        minLengthOfImages: minLengthOfImages,
        maxLengthOfProblem: maxLengthOfProblem,
        minLengthOfProblem: minLengthOfProblem,
        requestId: requestId,
      ),
      titleLabel: "");
}
