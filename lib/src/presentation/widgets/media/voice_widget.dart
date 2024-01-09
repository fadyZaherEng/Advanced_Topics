// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, deprecated_member_use, must_be_immutable
import 'dart:async';
import 'dart:io';

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
    initialRecorder();

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
        if (isRecording)
          StreamBuilder(
            stream: recorder.onProgress,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final duration =
                    snapshot.hasData ? snapshot.data!.duration : Duration.zero;
                return Text(
                  '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 12,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w400,
                        color: ColorSchemes.black,
                      ),
                );
              }
              return Container();
            },
          ),
        const SizedBox(width: 10),
      ],
    );
  }

  Future record() async {
    if (!isRecorderReady) return;
    setState(() {
      isRecording = true;
    });
    return recorder.startRecorder(toFile: "audio");
  }

  Future stop() async {
    if (!isRecorderReady) return;
    setState(() {
      isRecording = false;
    });
    final path = await recorder.stopRecorder();
    audioFile = File(path!);
    _bloc.add(OnGetAudioPathEvent(audioFile!.path));
    widget.maxRecordingDuration = max;
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  void initialRecorder() async {
    await recorder.openRecorder();
    isRecorderReady = true;
    recorder.setSubscriptionDuration(
      const Duration(
        milliseconds: 500,
      ),
    );
  }

  Future initRecorder() async {
    await recorder.openRecorder();
    isRecorderReady = true;
    recorder.setSubscriptionDuration(
      const Duration(
        milliseconds: 500,
      ),
    );
    recorder.onProgress!.listen((event) {
      setState(() {
        playbackProgress = event.duration.inSeconds.toDouble();
        if (playbackProgress > max) {
          stop();
        }
      });
    });
    return recorder;
  }

  void _onAudioTap(BuildContext context) async {
    if (await PermissionServiceHandler().handleServicePermission(
      setting: Permission.microphone,
    )) {
      if (isRecording) {
        stop();
      } else {
        await initRecorder();
        await record();
        widget.maxRecordingDuration = max;
      }
    } else if (!await PermissionServiceHandler()
        .handleServicePermission(setting: Permission.microphone)) {
      showActionDialogWidget(
        context: context,
        text: "S.of(context).youShouldHaveAudioPermission",
        icon: "ImagePaths.microphone",
        primaryText: "S.of(context).ok",
        secondaryText: " S.of(context).cancel",
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
