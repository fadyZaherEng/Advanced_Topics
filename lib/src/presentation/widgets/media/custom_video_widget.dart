// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

class CustomVideoWidget extends StatefulWidget {
  final void Function() onClosed;
  VideoPlayerController videoController;

  CustomVideoWidget({
    Key? key,
    required this.videoController,
    required this.onClosed,
  }) : super(key: key);

  @override
  State<CustomVideoWidget> createState() => _CustomVideoWidgetState();
}

class _CustomVideoWidgetState extends State<CustomVideoWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "video",
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: ColorSchemes.black, letterSpacing: -0.24),
        ),
        const SizedBox(
          height: 16,
        ),
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    VideoPlayer(widget.videoController),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 14.0,
                              child: VideoProgressIndicator(
                                widget.videoController,
                                allowScrubbing: true,
                                colors: const VideoProgressColors(
                                  playedColor: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: AlignmentDirectional.center,
                        child: GestureDetector(
                          onTap: () {
                            widget.videoController.value.isPlaying
                                ? widget.videoController.pause()
                                : widget.videoController.play();
                            setState(() {});
                          },
                          child: ValueListenableBuilder(
                            valueListenable: widget.videoController,
                            builder: (context, VideoPlayerValue value, child) =>
                                AnimatedSwitcher(
                              duration: const Duration(milliseconds: 50),
                              reverseDuration:
                                  const Duration(milliseconds: 200),
                              child: SvgPicture.asset(
                                value.isPlaying
                                    ? ImagePaths.pause
                                    : ImagePaths.play,
                                fit: BoxFit.scaleDown,
                                width: 32,
                                height: 32,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            PositionedDirectional(
              top: 0,
              start: 6,
              child: InkWell(
                onTap: () {
                  widget.videoController.pause();
                  widget.videoController.dispose();
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
                        color: ColorSchemes.gray.withOpacity(0.3),
                        blurRadius: 25,
                        spreadRadius: 0,
                        offset: const Offset(0, 0),
                      ),
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
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoController.dispose();
  }
}
