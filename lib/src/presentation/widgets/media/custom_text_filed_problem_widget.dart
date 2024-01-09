import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/new/constants.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/voice_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextFieldProblemWidget extends StatefulWidget {
  final TextEditingController textEditingController;
  final void Function(String value) onChangeTextEditingController;
  String? errorMessage;
  final void Function() onVideoTap;
  final void Function() onGalleyTap;
  final int maxLengthOfVocie;
  final String title;
  final int maxLinesOfProblem;
  final int minLinesOfProblem;

  CustomTextFieldProblemWidget({
    super.key,
    required this.textEditingController,
    this.errorMessage,
    required this.maxLengthOfVocie,
    required this.maxLinesOfProblem,
    required this.onChangeTextEditingController,
    required this.onGalleyTap,
    required this.onVideoTap,
    required this.title,
    required this.minLinesOfProblem,
  });

  @override
  State<CustomTextFieldProblemWidget> createState() =>
      _CustomTextFieldProblemWidgetState();
}

class _CustomTextFieldProblemWidgetState
    extends State<CustomTextFieldProblemWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: ColorSchemes.black,
                fontSize: 14,
                fontFamily: "Montserrat",
                fontWeight: Constants.fontWeightBold,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 160,
          color: ColorSchemes.white,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: widget.textEditingController,
                  onChanged: widget.onChangeTextEditingController,
                  expands: true,
                  maxLines: null,
                  maxLength: widget.maxLinesOfProblem,
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: _getBorderColor()),
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: _getBorderColor()),
                        borderRadius: BorderRadius.circular(12)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: _getBorderColor()),
                        borderRadius: BorderRadius.circular(12)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: _getBorderColor()),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    counterText: "",
                    hintText: " S.current.briefDescription",
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF989898),
                          fontSize: 12,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w400,
                        ),
                    errorMaxLines: 2,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                    vertical: widget.errorMessage != null ? 10 : 10,
                  ),
                  child: SizedBox(
                    // width: 100,
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: widget.onVideoTap,
                          child: SvgPicture.asset(
                            ImagePaths.video,
                            fit: BoxFit.scaleDown,
                            width: 20,
                            height: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: widget.onGalleyTap,
                          child: SvgPicture.asset(
                            ImagePaths.newGallery,
                            fit: BoxFit.scaleDown,
                            width: 20,
                            height: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        RecordVoiceWidget(
                          maxRecordingDuration: widget.maxLengthOfVocie,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const Expanded(child: SizedBox()),
            Text(
              "  S.of(context).minimum",
              style: _getTextStyleColor(),
            ),
            Text(
              " ${widget.minLinesOfProblem} ",
              style: _getTextStyleColor().copyWith(
                color: widget.errorMessage != null
                    ? ColorSchemes.redError
                    : ColorSchemes.black,
              ),
            ),
            Text(
              ", ${"S.of(context).maximum"}",
              style: _getTextStyleColor(),
            ),
            Text(
              " ${widget.maxLinesOfProblem} ",
              style: _getTextStyleColor().copyWith(
                color: widget.errorMessage != null
                    ? ColorSchemes.redError
                    : ColorSchemes.black,
              ),
            ),
            Text(
              " S.of(context).characters",
              style: _getTextStyleColor(),
            ),
          ],
        ),
      ],
    );
  }

  Color _getBorderColor() {
    return widget.errorMessage != null
        ? ColorSchemes.redError
        : ColorSchemes.border;
  }

  TextStyle _getTextStyleColor() {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
          color: widget.errorMessage != null
              ? ColorSchemes.redError
              : ColorSchemes.gray,
          fontSize: 12,
        );
  }
}
