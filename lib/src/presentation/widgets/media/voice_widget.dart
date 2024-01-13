// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, deprecated_member_use, must_be_immutable
import 'dart:async';
import 'dart:io';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/new/permission_service_handler.dart';
import 'package:flutter_advanced_topics/src/core/utils/new/show_action_dialog_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/need_payment/need_payment_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class RecordVoiceWidget extends StatefulWidget {
  int maxRecordingDuration;

  RecordVoiceWidget({
    super.key,
    required this.maxRecordingDuration,
  });

  @override
  _RecordVoiceWidgetState createState() => _RecordVoiceWidgetState();
}

class _RecordVoiceWidgetState extends State<RecordVoiceWidget> {
  final recorder = FlutterSoundRecorder();
  bool isRecording = false;
  double playbackProgress = 0.0;
  bool isRecorderReady = false;
  File? audioFile;
  int max = 0;

  NeedPaymentBloc get _bloc => BlocProvider.of<NeedPaymentBloc>(context);

  @override
  void initState() {
    super.initState();

    ///initRecorder();

    max = widget.maxRecordingDuration;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () async {
            _onAudioTap(context);
          },
          child: SvgPicture.asset(
            isRecording ? ImagePaths.stopRecord : ImagePaths.microphone,
            fit: BoxFit.scaleDown,
            width: 20,
            height: 20,
          ),
        ),
        Visibility(
          visible: isRecording,
          child: StreamBuilder<RecordingDisposition>(
              stream: recorder.onProgress,
              builder: (context, snapshot) {
                final duration =
                    snapshot.hasData ? snapshot.data!.duration : Duration.zero;
                final remainingTime =
                    Duration(seconds: widget.maxRecordingDuration) - duration;
                String twoDigitsInMinutes =
                    twoDigits(remainingTime.inMinutes.remainder(60));
                String twoDigitsInSeconds =
                    twoDigits(remainingTime.inSeconds.remainder(60));
                return Text(
                  "$twoDigitsInMinutes:$twoDigitsInSeconds",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        letterSpacing: -0.24,
                        color: ColorSchemes.black,
                      ),
                );
              }),
        ),
        // if (isRecording)
        //   StreamBuilder(
        //     stream: recorder.onProgress,
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         final duration =
        //             snapshot.hasData ? snapshot.data!.duration : Duration.zero;
        //         return Text(
        //           '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
        //           style: Theme.of(context).textTheme.bodySmall!.copyWith(
        //                 fontSize: 12,
        //                 fontFamily: "Montserrat",
        //                 fontWeight: FontWeight.w400,
        //                 color: ColorSchemes.black,
        //               ),
        //         );
        //       }
        //       return Container();
        //     },
        //   ),
        const SizedBox(width: 10),
      ],
    );
  }

  Future _startRecording() async {
    if (!isRecorderReady) return;
    setState(() {
      isRecording = true;
    });
    Directory? dir;
    if (Platform.isIOS) {
      dir = await getApplicationDocumentsDirectory();
    } else {
      dir = await getApplicationDocumentsDirectory();
    }
    final record =
        await recorder.startRecorder(toFile: "${dir.path}/audio.aac");
    // recorder.onProgress!.listen((time) async {
    //   _bloc.add(AudioStatusChangeEvent(
    //     isRecording: true,
    //     duration: time.duration.inSeconds,
    //   ));
    // });
    recorder.onProgress!.listen((event) {
      setState(() {
        playbackProgress = event.duration.inSeconds.toDouble();
        if (playbackProgress > max) {
          _stopRecording();
        }
      });
    });
    return record;
  }

  Future<void> _stopRecording() async {
    if (!isRecorderReady) return;
    setState(() {
      isRecording = false;
    });
    String audioPath = await recorder.stopRecorder() ?? "";

    if (audioPath.isEmpty) {
      ///emit audio path event empty
    } else {
      audioFile = File(audioPath);
      _bloc.add(OnGetAudioPathEvent(audioFile!.path));
      widget.maxRecordingDuration = max;
    }
  }

  // Future record() async {
  //   if (!isRecorderReady) return;
  //   setState(() {
  //     isRecording = true;
  //   });
  //   return recorder.startRecorder(toFile: "audio");
  // }
  //
  // Future stop() async {
  //   if (!isRecorderReady) return;
  //   setState(() {
  //     isRecording = false;
  //   });
  //   final path = await recorder.stopRecorder();
  //   audioFile = File(path!);
  //   _bloc.add(OnGetAudioPathEvent(audioFile!.path));
  //   widget.maxRecordingDuration = max;
  // }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  //some configuration for start record in ios
  Future<void> _handleIOSAudio() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));
  }

  Future initRecorder() async {
    if (Platform.isIOS) {
      await _handleIOSAudio();
    }
    await recorder.openRecorder();
    isRecorderReady = true;
    await recorder.setSubscriptionDuration(const Duration(
      milliseconds: 500,
    ));
    return recorder;
  }

  void _onAudioTap(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (audioFile!.path.isNotEmpty && !recorder.isRecording) {
      showActionDialogWidget(
        context: context,
        icon: ImagePaths.warning,
        primaryAction: () {
          Navigator.pop(context);
        },
        primaryText: "no",
        secondaryAction: () async {
          Navigator.pop(context);
          //init Recording with replace
          _requestMicrophonePermission();
        },
        secondaryText: "yes",
        text: "areYouWantToChooseAnotherAudio",
      );
    } else {
      _requestMicrophonePermission();
    }
  }

  String twoDigits(int n) => n.toString().padLeft(2, "0");

  _requestMicrophonePermission() async {
    if (await PermissionServiceHandler().handleServicePermission(
      setting: Permission.microphone,
    )) {
      await initRecorder();
      if (recorder.isRecording) {
        await _stopRecording();
      } else {
        await _startRecording();
      }
      widget.maxRecordingDuration = max;
    } else if (!await PermissionServiceHandler()
        .handleServicePermission(setting: Permission.microphone)) {
      showActionDialogWidget(
        context: context,
        text: "youShouldHaveAudioPermission",
        icon: "ImagePaths.microphone",
        primaryText: "ok",
        secondaryText: "cancel",
        primaryAction: () async {
          openAppSettings().then((value) => Navigator.pop(context));
        },
        secondaryAction: () {
          Navigator.of(context).pop();
        },
      );
    }
  }
}
