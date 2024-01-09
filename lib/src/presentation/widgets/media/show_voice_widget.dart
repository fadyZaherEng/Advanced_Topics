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
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
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
                alignment: AlignmentDirectional.topStart,
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
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(242, 243, 245, 1),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
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
                              width: 32,
                              height: 32,
                              margin:
                                  const EdgeInsetsDirectional.only(start: 8),
                              decoration: const BoxDecoration(
                                color: ColorSchemes.primary,
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                _isPlaying
                                    ? ImagePaths.pauseAudio
                                    : ImagePaths.playAudio,
                                matchTextDirection: true,
                                fit: BoxFit.scaleDown,
                                // color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Slider(
                              value: _position.inSeconds.toDouble(),
                              max: _duration.inSeconds.toDouble(),
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
                          Text(_formatTime(_position)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: InkWell(
                              onTap: () async {
                                await _toggleMute();
                              },
                              child: SvgPicture.asset(
                                _isMuted
                                    ? ImagePaths.volumeOff
                                    : ImagePaths.volume,
                                fit: BoxFit.scaleDown,
                                color: ColorSchemes.gray,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned.directional(
                    textDirection: Directionality.of(context),
                    start: 5,
                    top: -8,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(start: 5),
                      child: InkWell(
                        onTap: () {
                          _audioPlayer.pause();
                          _audioPlayer.release();
                          _audioPlayer.dispose();
                          widget.onClosed();
                        },
                        child: Container(
                          width: 20,
                          height: 20,
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
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                height: 1,
                color: ColorSchemes.border,
              ),
            ],
          ),
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
