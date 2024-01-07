// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/need_payment/need_payment_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShowMicrophoneWidget extends StatefulWidget {
  final String audioPath;
  int maxRecordingDuration;
  final void Function() onClosed;

  ShowMicrophoneWidget({
    Key? key,
    required this.audioPath,
    required this.maxRecordingDuration,
    required this.onClosed,
  }) : super(key: key);

  @override
  State<ShowMicrophoneWidget> createState() => _ShowMicrophoneWidgetState();
}

class _ShowMicrophoneWidgetState extends State<ShowMicrophoneWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isMuted = false;

  // CountdownController countdownController = CountdownController();

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    initMethod();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NeedPaymentBloc, NeedPaymentState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            // Countdown(
            //   controller: countdownController,
            //   seconds: 10,
            //   build: (_, double time) {
            //     return Text(
            //       '${time.toInt()} seconds remaining',
            //       style: TextStyle(fontSize: 20.0),
            //     );
            //   },
            //   interval: Duration(milliseconds: 100),
            //   onFinished: () {
            //     audioPlayer.stop();
            //   },
            // ),
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                Container(
                  height: 63,
                  clipBehavior: Clip.antiAlias,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsetsDirectional.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: ColorSchemes.white,
                    boxShadow: [
                      BoxShadow(
                        color: ColorSchemes.gray.withOpacity(0.2),
                        blurRadius: 25,
                        spreadRadius: 0,
                        offset: const Offset(0, 0),
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: ColorSchemes.primary.withOpacity(0.03),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () async {
                              if (_isPlaying) {
                                //countdownController.restart();
                                await _audioPlayer.pause();
                                setState(() {
                                  _isPlaying = false;
                                });
                              } else {
                                await _audioPlayer
                                    .play(UrlSource(widget.audioPath));
                                setState(() {
                                  _isPlaying = true;
                                });
                              }
                            },
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: const BoxDecoration(
                                color: ColorSchemes.white,
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                _isPlaying
                                    ? ImagePaths.pause
                                    : ImagePaths.play,
                                matchTextDirection: true,
                                fit: BoxFit.scaleDown,
                                // color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.45,
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: ColorSchemes.primary,
                                inactiveTrackColor: ColorSchemes.gray,
                                trackHeight: 1.0,
                                thumbColor: ColorSchemes.primary,
                              ),
                              child: Slider(
                                value: _position.inSeconds.toDouble(),
                                max: _duration.inSeconds.toDouble(),
                                activeColor: ColorSchemes.primary,
                                inactiveColor: Colors.grey,
                                thumbColor: ColorSchemes.primary,
                                min: 0,
                                onChanged: (value) {
                                  _audioPlayer.seek(
                                    Duration(
                                      seconds: value.toInt(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Text(
                            _formatTime(_position),
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: ColorSchemes.primary,
                                      fontSize: 12,
                                    ),
                          ),
                          //const SizedBox(width: 8),
                          // SvgPicture.asset(
                          //   ImagePaths.microphone,
                          //   matchTextDirection: true,
                          //   fit: BoxFit.scaleDown,
                          // ),
                          IconButton(
                            onPressed: () async {
                              await _toggleMute();
                            },
                            icon: _isMuted
                                ? const Icon(Icons.mic_off, size: 20)
                                : const Icon(Icons.mic, size: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 5),
                  child: InkWell(
                    onTap: () {
                      _audioPlayer.pause();
                      _audioPlayer.release();
                      _audioPlayer.dispose();
                      widget.onClosed();
                    },
                    child: Container(
                      width: 17,
                      height: 17,
                      decoration: BoxDecoration(
                        color: ColorSchemes.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: ColorSchemes.gray.withOpacity(0.5),
                            blurRadius: 25,
                            spreadRadius: 0,
                            offset: const Offset(0, 0),
                          )
                        ],
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          ImagePaths.close,
                          color: ColorSchemes.black,
                          fit: BoxFit.scaleDown,
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _toggleMute() async {
    if (_isMuted) {
      await _audioPlayer.setVolume(1.0);
    } else {
      await _audioPlayer.setVolume(0.0);
    }
    setState(() {
      _isMuted = !_isMuted;
    });
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    int tempSeconds = duration.inSeconds.remainder(60);
    int tempMinutes = duration.inMinutes.remainder(60);
    int tempHours = duration.inHours;
    final hours = twoDigits(tempHours);
    final minutes = twoDigits(tempMinutes);
    final seconds = twoDigits(tempSeconds);
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.pause();
    _audioPlayer.release();
    _audioPlayer.dispose();
  }

  void initMethod() {
    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });

    _audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        _duration = newDuration;
      });
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        _position = newPosition;
      });
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _isPlaying = false;
        _position = Duration.zero;
        _audioPlayer.seek(_position);
        _audioPlayer.stop();
        _audioPlayer.release();
      });
    });
  }
}
