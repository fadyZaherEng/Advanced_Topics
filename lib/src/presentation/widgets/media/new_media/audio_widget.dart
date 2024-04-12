import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AudioWidget extends StatefulWidget {
  final String audioPath;
  final Function() onClearAudioTap;

  const AudioWidget({
    Key? key,
    required this.audioPath,
    required this.onClearAudioTap,
  }) : super(key: key);

  @override
  State<AudioWidget> createState() => _AudioWidgetState();
}

class _AudioWidgetState extends State<AudioWidget> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool _isMuted = false;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  void didChangeDependencies() {
    audioPlayer
        .play(DeviceFileSource(widget.audioPath))
        .then((value) => audioPlayer.pause());
    setState(() {
      isPlaying = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "audio",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorSchemes.black,
                  letterSpacing: -0.24,
                ),
          ),
          const SizedBox(
            height: 24,
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                  height: 70,
                  clipBehavior: Clip.none,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                        blurRadius: 32,
                        color: Color.fromRGBO(0, 0, 0, 0.12),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      width: 1,
                      color: const Color.fromRGBO(241, 241, 241, 1),
                    ),
                    color: Colors.white,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(242, 243, 245, 1),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            if (isPlaying) {
                              log("duration.inSeconds ${duration.inSeconds}");
                              await audioPlayer.pause();
                              setState(() {
                                isPlaying = false;
                              });
                            } else {
                              await audioPlayer
                                  .play(DeviceFileSource(widget.audioPath));
                              setState(() {
                                isPlaying = true;
                              });
                            }
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            margin: const EdgeInsetsDirectional.only(start: 8),
                            decoration: const BoxDecoration(
                              color: ColorSchemes.primary,
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              isPlaying
                                  ? ImagePaths.pauseAudio
                                  : ImagePaths.playAudio,
                              matchTextDirection: true,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Slider(
                            min: 0,
                            max: duration.inSeconds.toDouble(),
                            value: position.inSeconds.toDouble(),
                            onChanged: (value) async {
                              await audioPlayer
                                  .seek(Duration(seconds: value.toInt()));
                              await audioPlayer.resume();
                            },
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                                "${formatTime(position)} - ${formatTime(duration)}"),
                          ],
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        InkWell(
                          onTap: () {
                            if (_isMuted) {
                              audioPlayer.setVolume(1);
                              setState(() {
                                _isMuted = false;
                              });
                            } else {
                              audioPlayer.setVolume(0);
                              setState(() {
                                _isMuted = true;
                              });
                            }
                          },
                          child: SvgPicture.asset(
                            _isMuted ? ImagePaths.volumeOff : ImagePaths.volume,
                            fit: BoxFit.scaleDown,
                            color: ColorSchemes.gray,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        )
                      ],
                    ),
                  )),
              Positioned.directional(
                textDirection: Directionality.of(context),
                start: 6,
                top: -8,
                child: InkWell(
                  onTap: () {
                    // duration = Duration.zero;
                    // position = Duration.zero;
                    audioPlayer.pause();
                    widget.onClearAudioTap();
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
          const SizedBox(
            height: 16,
          ),
          Container(
            height: 1,
            color: ColorSchemes.border,
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.pause();
    audioPlayer.release();
    audioPlayer.dispose();
  }
}
