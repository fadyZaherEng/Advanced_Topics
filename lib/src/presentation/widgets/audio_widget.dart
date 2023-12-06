import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AudioWidget extends StatefulWidget {
  final String audioPath;

  const AudioWidget({
    Key? key,
    required this.audioPath,
  }) : super(key: key);

  @override
  State<AudioWidget> createState() => _AudioWidgetState();
}

class _AudioWidgetState extends State<AudioWidget> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

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
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Records",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorSchemes.black, letterSpacing: -0.24, fontSize: 16),
          ),
          const SizedBox(
            height: 16,
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                  height: 150,
                  width: 170,
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
                  child: Stack(
                    children: [
                      Center(
                        child: InkWell(
                          onTap: () async {
                            if (isPlaying) {
                              await audioPlayer.pause();
                              setState(() {
                                isPlaying = false;
                              });
                            } else {
                              await audioPlayer
                                  .play(UrlSource(widget.audioPath));
                              setState(() {
                                isPlaying = true;
                              });
                            }
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            margin: const EdgeInsetsDirectional.only(start: 8),
                            decoration: const BoxDecoration(
                              color: ColorSchemes.white,
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              isPlaying ? ImagePaths.pause : ImagePaths.play,
                              matchTextDirection: true,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ),
                      PositionedDirectional(
                        end: 16,
                        bottom: 8,
                        child: Text(formatTime(position),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.grey, fontSize: 12)),
                      ),
                    ],
                  )),
            ],
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
