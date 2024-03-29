import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/new/constants.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DescribeWidget extends StatefulWidget {
  final TextEditingController describeController;
  final Function(String) onDescribeChanged;
  final bool isDescribeValid;
  final bool isImageIconVisible;
  final bool isAudioIconVisible;
  final bool isVideoIconVisible;
  final Function() onVideoTap;
  final Function() onGalleryTap;
  final Function() onMicrophoneTap;
  final bool isRecording;
  final int remainingCharacter;
  final Stream<RecordingDisposition>? onProgress;
  final String describeText;
  final int maxLength;
  final int minLength;
  final int maxAudioLength;

  const DescribeWidget({
    Key? key,
    required this.describeController,
    required this.onDescribeChanged,
    required this.isDescribeValid,
    required this.onVideoTap,
    required this.onGalleryTap,
    required this.onMicrophoneTap,
    required this.isRecording,
    required this.remainingCharacter,
    required this.onProgress,
    required this.describeText,
    required this.maxLength,
    required this.minLength,
    required this.maxAudioLength,
    this.isImageIconVisible = true,
    this.isAudioIconVisible = true,
    this.isVideoIconVisible = true,
  }) : super(key: key);

  @override
  State<DescribeWidget> createState() => _DescribeWidgetState();
}

class _DescribeWidgetState extends State<DescribeWidget> {
  final FocusNode _focus = FocusNode();
  bool _textFieldHasFocus = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(() {
      setState(() {
        _textFieldHasFocus = _focus.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "describeYourRequest",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorSchemes.black,
                  letterSpacing: -0.13,
                ),
          ),
        ),
        const SizedBox(height: 16),
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 150,
              child: TextField(
                focusNode: _focus,
                keyboardType: TextInputType.text,
                controller: widget.describeController,
                onChanged: (value) {
                  widget.onDescribeChanged(value);
                },
                expands: true,
                maxLines: null,
                maxLength: widget.maxLength,
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  counterText: '',
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
                      borderRadius: BorderRadius.circular(12)),
                  errorText: null,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  labelText: widget.describeText,
                  labelStyle: _labelStyle(
                    context,
                    _textFieldHasFocus,
                  ),
                  errorMaxLines: 2,
                ),
              ),
            ),
            Positioned.directional(
              textDirection: Directionality.of(context),
              end: 24,
              bottom: 12,
              child: Row(
                children: [
                  _buildIcon(
                    path: ImagePaths.video,
                    onTap: widget.onVideoTap,
                    isVisible: widget.isVideoIconVisible,
                  ),
                  _buildIcon(
                    path: ImagePaths.gallery,
                    onTap: widget.onGalleryTap,
                    isVisible: widget.isImageIconVisible,
                  ),
                  _buildIcon(
                    path: widget.isRecording
                        ? ImagePaths.stopRecord
                        : ImagePaths.microphone,
                    isVisible: widget.isAudioIconVisible,
                    onTap: widget.onMicrophoneTap,
                    isLastIcon: true,
                  ),
                  Visibility(
                    visible: widget.isRecording,
                    child: StreamBuilder<RecordingDisposition>(
                        stream: widget.onProgress,
                        builder: (context, snapshot) {
                          final duration = snapshot.hasData
                              ? snapshot.data!.duration
                              : Duration.zero;
                          final remainingTime =
                              Duration(seconds: widget.maxAudioLength) -
                                  duration;
                          String twoDigitsInMinutes =
                              twoDigits(remainingTime.inMinutes.remainder(60));
                          String twoDigitsInSeconds =
                              twoDigits(remainingTime.inSeconds.remainder(60));
                          return Text(
                            "$twoDigitsInMinutes:$twoDigitsInSeconds",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  letterSpacing: -0.24,
                                  color: ColorSchemes.black,
                                ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Expanded(child: SizedBox()),
              Text(
                "minimum",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: _getTextColor(),
                      letterSpacing: -0.13,
                    ),
              ),
              Text(
                " ${widget.minLength} ",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: _getMaxCharacterColor(),
                      letterSpacing: -0.13,
                    ),
              ),
              Text(
                "maximum",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: _getTextColor(),
                      letterSpacing: -0.13,
                    ),
              ),
              Text(
                " ${widget.maxLength} ",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: _getMaxCharacterColor(),
                      letterSpacing: -0.13,
                    ),
              ),
              Text(
                "characters",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: _getTextColor(),
                      letterSpacing: -0.13,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  TextStyle _labelStyle(BuildContext context, bool hasFocus) {
    if (hasFocus || widget.describeController.text.isNotEmpty) {
      return Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: Constants.fontWeightRegular,
            color: widget.isDescribeValid
                ? ColorSchemes.gray
                : ColorSchemes.redError,
            letterSpacing: -0.13,
          );
    } else {
      return Theme.of(context).textTheme.titleSmall!.copyWith(
            fontWeight: Constants.fontWeightRegular,
            color: widget.isDescribeValid
                ? ColorSchemes.gray
                : ColorSchemes.redError,
            letterSpacing: -0.13,
          );
    }
  }

  Color _getMaxCharacterColor() {
    // if (widget.isDescribeValid && widget.remainingCharacter > 0) {
    if (widget.isDescribeValid) {
      return ColorSchemes.black;
    } else {
      return ColorSchemes.redError;
    }
  }

  Color _getBorderColor() {
    if (widget.isDescribeValid) {
      return ColorSchemes.border;
    } else {
      return ColorSchemes.redError;
    }
  }

  Color _getTextColor() {
    if (widget.isDescribeValid) {
      return ColorSchemes.gray;
    } else {
      return ColorSchemes.redError;
    }
  }

  Widget _buildIcon({
    required String path,
    required bool isVisible,
    required Function() onTap,
    bool isLastIcon = false,
  }) {
    return isVisible
        ? InkWell(
            onTap: () {
              onTap();
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  path,
                  fit: BoxFit.scaleDown,
                ),
                isLastIcon
                    ? const SizedBox.shrink()
                    : const SizedBox(
                        width: 8,
                      ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }

  String twoDigits(int n) => n.toString().padLeft(2, "0");
}
/*
if (isImageIconVisible &&
                      isAudioIconVisible &&
                      isVideoIconVisible) ...[
                    _buildIcon(
                      path: ImagePaths.video,
                      onTap: onVideoTap,
                      isVisible: true,
                    ),
                    _buildIcon(
                      path: ImagePaths.gallery,
                      onTap: onGalleryTap,
                      isVisible: true,
                    ),
                    _buildIcon(
                      path: isRecording
                          ? ImagePaths.stopRecord
                          : ImagePaths.microphone,
                      isVisible: true,
                      onTap: onMicrophoneTap,
                      isLastIcon: true,
                    ),
                    Visibility(
                      visible: isRecording,
                      child: StreamBuilder<RecordingDisposition>(
                          stream: onProgress,
                          builder: (context, snapshot) {
                            final duration = snapshot.hasData
                                ? snapshot.data!.duration
                                : Duration.zero;
                            String twoDigitsInMinutes =
                                twoDigits(duration.inMinutes.remainder(60));
                            String twoDigitsInSeconds =
                                twoDigits(duration.inSeconds.remainder(60));
                            return Text(
                              "$twoDigitsInMinutes:$twoDigitsInSeconds",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    letterSpacing: -0.24,
                                    color: ColorSchemes.black,
                                  ),
                            );
                          }),
                    ),
                  ] else if (isImageIconVisible && !isVideoIconVisible && !isAudioIconVisible) ...[
                    _buildIcon(
                      path: ImagePaths.gallery,
                      onTap: onGalleryTap,
                      isVisible: true,
                      isLastIcon: true,
                    ),
                  ] else if (isAudioIconVisible && !isVideoIconVisible && !isImageIconVisible) ...[
                    _buildIcon(
                      path: isRecording
                          ? ImagePaths.stopRecord
                          : ImagePaths.microphone,
                      isVisible: true,
                      onTap: onMicrophoneTap,
                      isLastIcon: true,
                    ),
                    Visibility(
                      visible: isRecording,
                      child: StreamBuilder<RecordingDisposition>(
                          stream: onProgress,
                          builder: (context, snapshot) {
                            final duration = snapshot.hasData
                                ? snapshot.data!.duration
                                : Duration.zero;
                            String twoDigitsInMinutes =
                                twoDigits(duration.inMinutes.remainder(60));
                            String twoDigitsInSeconds =
                                twoDigits(duration.inSeconds.remainder(60));
                            return Text(
                              "$twoDigitsInMinutes:$twoDigitsInSeconds",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    letterSpacing: -0.24,
                                    color: ColorSchemes.black,
                                  ),
                            );
                          }),
                    ),
                  ] else if (isVideoIconVisible && !isImageIconVisible && !isAudioIconVisible) ...[
                    _buildIcon(
                      path: ImagePaths.video,
                      onTap: onVideoTap,
                      isVisible: true,
                      isLastIcon: true,
                    ),
                  ] else if (isImageIconVisible && isAudioIconVisible) ...[
                    _buildIcon(
                      path: ImagePaths.gallery,
                      onTap: onGalleryTap,
                      isVisible: true,
                    ),
                    _buildIcon(
                      path: isRecording
                          ? ImagePaths.stopRecord
                          : ImagePaths.microphone,
                      isVisible: true,
                      onTap: onMicrophoneTap,
                      isLastIcon: true,
                    ),
                    Visibility(
                      visible: isRecording,
                      child: StreamBuilder<RecordingDisposition>(
                          stream: onProgress,
                          builder: (context, snapshot) {
                            final duration = snapshot.hasData
                                ? snapshot.data!.duration
                                : Duration.zero;
                            String twoDigitsInMinutes =
                                twoDigits(duration.inMinutes.remainder(60));
                            String twoDigitsInSeconds =
                                twoDigits(duration.inSeconds.remainder(60));
                            return Text(
                              "$twoDigitsInMinutes:$twoDigitsInSeconds",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    letterSpacing: -0.24,
                                    color: ColorSchemes.black,
                                  ),
                            );
                          }),
                    ),
                  ] else if (isImageIconVisible && isVideoIconVisible) ...[
                    _buildIcon(
                      path: ImagePaths.video,
                      onTap: onVideoTap,
                      isVisible: true,
                    ),
                    _buildIcon(
                      path: ImagePaths.gallery,
                      onTap: onGalleryTap,
                      isVisible: true,
                      isLastIcon: true,
                    ),
                  ] else if (isVideoIconVisible && isAudioIconVisible) ...[
                    _buildIcon(
                      path: ImagePaths.video,
                      onTap: onVideoTap,
                      isVisible: true,
                    ),
                    _buildIcon(
                      path: isRecording
                          ? ImagePaths.stopRecord
                          : ImagePaths.microphone,
                      isVisible: true,
                      onTap: onMicrophoneTap,
                      isLastIcon: true,
                    ),
                    Visibility(
                      visible: isRecording,
                      child: StreamBuilder<RecordingDisposition>(
                          stream: onProgress,
                          builder: (context, snapshot) {
                            final duration = snapshot.hasData
                                ? snapshot.data!.duration
                                : Duration.zero;
                            String twoDigitsInMinutes =
                                twoDigits(duration.inMinutes.remainder(60));
                            String twoDigitsInSeconds =
                                twoDigits(duration.inSeconds.remainder(60));
                            return Text(
                              "$twoDigitsInMinutes:$twoDigitsInSeconds",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    letterSpacing: -0.24,
                                    color: ColorSchemes.black,
                                  ),
                            );
                          }),
                    ),
                  ],
* */
