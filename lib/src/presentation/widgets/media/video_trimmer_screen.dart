import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/new_utils/show_action_dialog_widget.dart';
import 'package:flutter_advanced_topics/src/core/utils/show_massage_dialog_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/button/custom_button_internet_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/build_app_bar_widget.dart';
import 'package:video_trimmer/video_trimmer.dart';

class VideoTrimmerScreen extends StatefulWidget {
  final File file;
  final int maxDuration;

  const VideoTrimmerScreen({
    Key? key,
    required this.file,
    required this.maxDuration,
  }) : super(key: key);

  @override
  State<VideoTrimmerScreen> createState() => _VideoTrimmerScreenState();
}

class _VideoTrimmerScreenState extends State<VideoTrimmerScreen> {
  final Trimmer _trimmer = Trimmer();

  double _startValue = 0.0;
  double _endValue = 0.0;
  double _initailStartValue = 0.0;
  double _initialEndValue = 0.0;

  bool _isPlaying = false;
  bool _progressVisibility = false;

  Future<String?> _saveVideo() async {
    setState(() {
      _progressVisibility = true;
    });

    String? _value;

    await _trimmer
        .saveTrimmedVideo(
            startValue: _startValue,
            endValue: _endValue,
            onSave: (String? outputPath) {
              _value = outputPath;
              Navigator.pop(context, _value);
            })
        .then((value) {
      setState(() {
        _progressVisibility = false;
      });
    });

    return _value;
  }

  void _loadVideo() {
    _trimmer.loadVideo(videoFile: widget.file);
  }

  @override
  void initState() {
    super.initState();

    _loadVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildAppBarWidget(
            context,
            title: "videoTrimmer",
            isHaveBackButton: true,
            onBackButtonPressed: () {
              if (_startValue == _initailStartValue &&
                  _endValue == _initialEndValue) {
                _navigateBack();
              } else {
                showActionDialogWidget(
                    context: context,
                    text: "doYouWantToSaveTheChanges",
                    icon: ImagePaths.warning,
                    primaryText: "save",
                    secondaryText: "discard",
                    primaryAction: () async {
                      if (!_progressVisibility) {
                        if (Duration(
                                    milliseconds:
                                        (_endValue - _startValue).toInt())
                                .inSeconds >
                            30) {
                          _navigateBack();
                          _showMessageDialog();
                        } else {
                          await _saveVideo();
                          _navigateBack();
                        }
                      }
                    },
                    secondaryAction: () {
                      _navigateBack();
                      _navigateBack();
                    });
              }
            },
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(child: VideoViewer(trimmer: _trimmer)),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 100,
            child: TrimViewer(
              trimmer: _trimmer,
              viewerHeight: 60.0,
              showDuration: true,
              durationStyle: DurationStyle.FORMAT_HH_MM_SS,
              durationTextStyle: const TextStyle(color: Colors.black),
              viewerWidth: MediaQuery.of(context).size.width,
              onChangeStart: (value) {
                _startValue = value;
              },
              onChangeEnd: (value) {
                _endValue = value;
                if (_initialEndValue == 0.0) {
                  _initialEndValue = value;
                }
              },
              onChangePlaybackState: (value) =>
                  setState(() => _isPlaying = value),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomButtonInternetWidget(
                    height: 45,
                    textColor: ColorSchemes.black,
                    backgroundColor: ColorSchemes.white,
                    text: "cancel",
                    borderColor: ColorSchemes.lightGray,
                    onTap: () {
                      _navigateBack();
                    },
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: CustomButtonInternetWidget(
                    height: 45,
                    textColor: ColorSchemes.white,
                    backgroundColor: ColorSchemes.primary,
                    text: "save",
                    borderColor: ColorSchemes.lightGray,
                    onTap: () async {
                      if (!_progressVisibility) {
                        if (Duration(
                                    milliseconds:
                                        (_endValue - _startValue).toInt())
                                .inSeconds >
                            widget.maxDuration) {
                          _showMessageDialog();
                        } else {
                          await _saveVideo();
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showMessageDialog() {
    showMessageDialogWidget(
        context: context,
        text: "${"keepItShortAndSweetVideosAreBestAt"} ${widget.maxDuration} "
            "${"secondsOrLessThanks"}",
        icon: ImagePaths.frame,
        buttonText: "ok",
        onTap: () {
          _navigateBack();
        });
  }

  void _navigateBack() {
    Navigator.pop(context);
  }
}
