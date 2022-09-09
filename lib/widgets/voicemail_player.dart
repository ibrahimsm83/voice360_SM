import 'dart:io';
import 'dart:typed_data';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itp_voice/controllers/voicemail_player_controller.dart';
import 'package:itp_voice/repo/shares_preference_repo.dart';
import 'package:itp_voice/routes.dart';
import 'package:itp_voice/storage_keys.dart';
import 'package:itp_voice/widgets/custom_toast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sprintf/sprintf.dart';

class VoiceMailPlayer extends StatefulWidget {
  String? id;
  VoiceMailPlayer({
    this.id,
    Key? key,
  }) : super(key: key);

  @override
  State<VoiceMailPlayer> createState() => _VoiceMailPlayerState();
}

class _VoiceMailPlayerState extends State<VoiceMailPlayer> {
  late final PlayerController playerController1;
  String? path;
  String? musicFile;
  bool isRecording = false;
  late Directory appDirectory;

  @override
  void initState() {
    super.initState();
    _getDir();
    _initialiseControllers();
  }

  void _getDir() async {
    appDirectory = await getApplicationDocumentsDirectory();
    _downloadAndPlay(widget.id);
  }

  void _initialiseControllers() {
    playerController1 = PlayerController()
      ..addListener(() {
        if (mounted)
          setState(() {
            playerController1
                .getDuration(DurationType.current)
                .then((value) => print("DURATION: ${value}"));
          });
      });
  }

  void _downloadAndPlay(id) async {
    ///audio-1
    String savePath = appDirectory.path + "voicemail_${id}.mp3";
    String? apiId = await SharedPreferencesMethod.getString(StorageKeys.API_ID);
    String? token =
        await SharedPreferencesMethod.getString(StorageKeys.REFRESH_TOKEN);
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    if (statuses[Permission.storage]!.isGranted) {
      try {
        await Dio().download(
            "${Endpoints.DOWNLOAD_VOICE_MAIL_MESSAGES(apiId)}/${id}?token=${token}",
            savePath, onReceiveProgress: (received, total) {
          if (total != -1) {
            print((received / total * 100).toStringAsFixed(0) + "%");
            //you can build progressbar feature too
          }
        });
        playerController1.preparePlayer(savePath);
      } catch (e) {
        print(e.toString());
      }
    } else {
      CustomToast.showToast(
        "Please allow storage permission to download voicemail",
        true,
      );
      return null;
    }
  }

  void _disposeControllers() {
    playerController1.stopAllPlayers();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _playOrPlausePlayer(PlayerController controller) async {
    controller.playerState == PlayerState.playing
        ? await controller.pausePlayer()
        : await controller.startPlayer(finishMode: FinishMode.loop);

    // controller.getDuration();
  }

  String getDuration(Duration duration) {
    var components = <String>[];

    var days = duration.inDays;
    if (days != 0) {
      components.add('${days}d');
    }
    var hours = duration.inHours % 24;
    if (hours != 0) {
      components.add('${hours}h');
    }
    var minutes = duration.inMinutes % 60;
    if (minutes != 0) {
      components.add('${minutes}m');
    }

    var seconds = duration.inSeconds % 60;
    var centiseconds = (duration.inMilliseconds % 1000) ~/ 10;
    if (components.isEmpty || seconds != 0 || centiseconds != 0) {
      components.add('$seconds');
      if (centiseconds != 0) {
        components.add('.');
        components.add(centiseconds.toString().padLeft(2, '0'));
      }
      components.add('s');
    }
    return components.join();
  }
// didC
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.detached) {
  //     _disposeControllers();
  //   }
  //   super.didChangeAppLifecycleState(state);
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (playerController1.playerState != PlayerState.stopped) ...[
          Align(
            // alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              // padding: EdgeInsets.only(right: 10),
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      _playOrPlausePlayer(playerController1);
                    },
                    icon: Icon(
                        playerController1.playerState == PlayerState.playing
                            ? Icons.stop
                            : Icons.play_arrow),
                    color: Colors.white,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  AudioFileWaveforms(
                    size: Size(MediaQuery.of(context).size.width / 2, 30),
                    playerController: playerController1,
                    density: 1.1,
                    playerWaveStyle: const PlayerWaveStyle(
                      showTop: true,
                      scaleFactor: 0.5,
                      fixedWaveColor: Colors.white30,
                      liveWaveColor: Colors.white,
                      waveCap: StrokeCap.round,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  FutureBuilder(
                    future: playerController1.getDuration(DurationType.max),
                    builder: (context, snapshot) {
                      if (snapshot.hasData)
                        return Text(
                          getDuration(
                            Duration(milliseconds: snapshot.data as int),
                          ),
                          style:
                              TextStyle(color: Colors.white, fontSize: 14.sp),
                        );
                      return Container();
                    },
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                ],
              ),
            ),
          )
        ] else ...[
          CircularProgressIndicator()
        ],
      ],
    );
  }
}
