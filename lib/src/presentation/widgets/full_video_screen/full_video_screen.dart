import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/base/widget/base_stateful_widget.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

class FullVideoScreen extends BaseStatefulWidget {
  final String videoUrl;

  const FullVideoScreen({
    required this.videoUrl,
    super.key,
  });

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _FullVideoScreenState();
}

class _FullVideoScreenState extends BaseState<FullVideoScreen>
    with WidgetsBindingObserver {
  late VideoPlayerController _videoPlayerController;

  ValueNotifier<bool> isVideoLoaded = ValueNotifier<bool>(false);

  void _initVideoPlayerController() {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initVideoPlayerController();
  }

  @override
  void didChangeDependencies() async {
    _videoPlayerController.initialize().then(
          (_) => isVideoLoaded.value = true,
        );
    _videoPlayerController.play();
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    _videoPlayerController.dispose();
    super.deactivate();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state != AppLifecycleState.resumed) {
      _videoPlayerController.pause();
    } else {
      _videoPlayerController.play();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:
          const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
      child: Theme(
        data: ThemeData(scaffoldBackgroundColor: ColorSchemes.black),
        child: Scaffold(
          body: ValueListenableBuilder(
            valueListenable: isVideoLoaded,
            builder: (context, value, child) {
              return Hero(
                tag: 'video-player',
                child: value
                    ? Stack(
                        children: [
                          VideoPlayer(
                            _videoPlayerController,
                          ),
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
                                      _videoPlayerController,
                                      allowScrubbing: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _videoPlayerController.value.isPlaying
                                  ? _videoPlayerController.pause()
                                  : _videoPlayerController.play();
                              setState(() {});
                            },
                            child: _buildPlay(),
                          ),
                        ],
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                            color: ColorSchemes.primary),
                      ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPlay() => ValueListenableBuilder(
        valueListenable: _videoPlayerController,
        builder: (context, VideoPlayerValue value, child) => AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: Container(
            color: Colors.black26,
            child: Center(
              child: SvgPicture.asset(
                fit: BoxFit.scaleDown,
                _isPlayIcon(value.isPlaying),
                width: 45,
                height: 45,
              ),
            ),
          ),
        ),
      );

  String _isPlayIcon(bool isPlaying) {
    if (isPlaying) {
      return ImagePaths.pause;
    } else {
      return ImagePaths.play;
    }
  }
}
