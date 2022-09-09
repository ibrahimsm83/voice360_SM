import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itp_voice/controllers/voicemails_controller.dart';

class VoiceMailPlayerController extends GetxController {
  PlayerController? playerController;
  VoidCallback? onTap;
  bool isPlaying = false;
  VoiceMailsController? voicemailsController;

  playOrPlausePlayer() async {
    playerController!.playerState == PlayerState.playing
        ? await playerController!.pausePlayer()
        : await playerController!.startPlayer(finishMode: FinishMode.stop);
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    playerController = PlayerController();
//  if(playerController.)
    voicemailsController = Get.find<VoiceMailsController>();
    super.onInit();
    File audioFile = File(voicemailsController!.savePath);

    await playerController!.preparePlayer(audioFile.path);
    print("DURATION " + playerController!.maxDuration.toString());
    // File audioFile = File(voicemailsController!.savePath);
    // print("FILE EXISTS");
    // print(await audioFile.exists());
    // print(audioFile.)
  }
}
