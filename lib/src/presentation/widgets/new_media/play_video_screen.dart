import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/build_app_bar_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

class PlayVideoScreen extends StatefulWidget {
  final File? video;
  final VideoPlayerController? videoController;

  const PlayVideoScreen({
    Key? key,
    required this.video,
    required this.videoController,
  }) : super(key: key);

  @override
  State<PlayVideoScreen> createState() => _PlayVideoScreenState();
}

class _PlayVideoScreenState extends State<PlayVideoScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    widget.videoController!.play();

    widget.videoController!.addListener(() {
      if (widget.videoController!.value.position ==
          widget.videoController!.value.duration) {
        if (mounted) setState(() {});
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    widget.videoController!.addListener(() {
      if (widget.videoController!.value.position ==
          widget.videoController!.value.duration) {
        if (mounted) setState(() {});
      }
    });
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed &&
        !widget.videoController!.value.isCompleted) {
      widget.videoController!.play();
    } else if (!widget.videoController!.value.isCompleted) {
      widget.videoController!.pause();
    }
    setState(() {});
  }

  @override
  void deactivate() {
    widget.videoController!.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    widget.videoController!.pause();
    widget.videoController!.seekTo(Duration(seconds: 0));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBarWidget(
        context,
        title: "video",
        isHaveBackButton: true,
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Container(
          color: ColorSchemes.black.withOpacity(0.8),
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.loose,
            children: [
              VideoPlayer(
                widget.videoController!,
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  widget.videoController!.value.isPlaying
                      ? widget.videoController!.pause()
                      : widget.videoController!.play();
                  setState(() {});
                },
                child: Stack(
                  children: <Widget>[
                    _buildPlay(),
                    Positioned(
                        left: 8,
                        bottom: 28,
                        child: StreamBuilder<String>(
                            stream: getVideoPosition(),
                            builder: (context, snapshot) {
                              return Text(snapshot.data ?? "");
                            })),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Row(
                          children: [
                            Expanded(child: _buildIndicator()),
                            const SizedBox(width: 8),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Stream<String> getVideoPosition() async* {
    while (widget.videoController!.value.isPlaying) {
      final duration = Duration(
          milliseconds:
              widget.videoController!.value.position.inMilliseconds.round());
      yield [duration.inMinutes, duration.inSeconds]
          .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
          .join(':');
      await Future.delayed(const Duration(seconds: 1));
    }

    final duration = Duration(
        milliseconds:
            widget.videoController!.value.position.inMilliseconds.round());
    yield [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  Widget _buildIndicator() => Container(
        margin: const EdgeInsets.all(8).copyWith(right: 0),
        height: 16,
        child: VideoProgressIndicator(
          widget.videoController!,
          allowScrubbing: true,
        ),
      );

  Widget _buildPlay() => AnimatedSwitcher(
        duration: const Duration(milliseconds: 50),
        reverseDuration: const Duration(milliseconds: 200),
        child: Container(
          color: Colors.black26,
          child: Center(
            child: SvgPicture.asset(
              fit: BoxFit.scaleDown,
              _isPlayIcon(widget.videoController!.value.isPlaying),
              color: Colors.white,
              width: 45,
              height: 45,
            ),
          ),
        ),
      );

  String _isPlayIcon(bool isPlaying) {
    if (isPlaying) {
      setState(
        () {},
      );
      return ImagePaths.pause;
    } else {
      setState(() {});
      return ImagePaths.play;
    }
  }
}
