import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:itp_voice/models/get_voice_mails_response_model/get_voice_mails_response_model.dart';
import 'package:itp_voice/models/get_voice_mails_response_model/result.dart';
import 'package:itp_voice/repo/shares_preference_repo.dart';
import 'package:itp_voice/repo/voice_mails_repo.dart';
import 'package:itp_voice/routes.dart';
import 'package:itp_voice/storage_keys.dart';
import 'package:itp_voice/widgets/custom_loader.dart';
import 'package:itp_voice/widgets/custom_toast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class VoiceMailsController extends GetxController {
  List<VoiceMails> voiceMails = [];
  RxBool downloadingVoicemail = true.obs;
  PlayerController? playerController;
  bool voiceMailDownload = false;
  String savePath = "";
  int tappedIndex = 0;
  late VoiceMails voiceMail;
  // final player = AudioPlayer();
  Duration? voiceMailDuration;
  bool isVoiceMailsLoading = false;
  VoiceMailsRepo repo = VoiceMailsRepo();
  TextEditingController searchController = TextEditingController();

  fetchVoiceMails() async {
    voiceMails.clear();
    isVoiceMailsLoading = true;
    update();

    final res = await repo.getVoiceMails();
    isVoiceMailsLoading = false;
    update();
    if (res.runtimeType == GetVoiceMailsResponseModel) {
      GetVoiceMailsResponseModel model = res;
      for (int i = 0; i < model.voiceMails!.length; i++) {
        voiceMails.add(model.voiceMails![i]);
      }
    }
    update();
  }

  deleteVoiceMail(id) async {
    Get.back();
    CustomLoader.showLoader();
    var res = await repo.deleteVoicemail(id);
    Get.back();

    if (res.runtimeType == String) {
      CustomToast.showToast(res, true);
    } else {
      fetchVoiceMails();
    }
  }

  getDataList() {
    if (searchController.text.isEmpty) {
      return voiceMails;
    }
    if (searchController.text.isNotEmpty) {
      return voiceMails
          .where((element) => element.callerid!
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    playerController = PlayerController();
    fetchVoiceMails();
  }

  downloadVoicemail(id) async {
    String? apiId = await SharedPreferencesMethod.getString(StorageKeys.API_ID);
    String? token =
        await SharedPreferencesMethod.getString(StorageKeys.REFRESH_TOKEN);
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    if (statuses[Permission.storage]!.isGranted) {
      Directory? directory = await DownloadsPathProvider.downloadsDirectory;
      var dir = await directory!.path;
      if (dir != null) {
        savePath = dir + "/ITP Voicemails/voicemail_$id.mp3";

        try {
          Get.back();
          CustomLoader.showLoader();
          await Dio().download(
              "${Endpoints.DOWNLOAD_VOICE_MAIL_MESSAGES(apiId)}/${id}?token=${token}",
              savePath, onReceiveProgress: (received, total) {
            if (total != -1) {
              print((received / total * 100).toStringAsFixed(0) + "%");
            }
          });
          Get.back();

          CustomToast.showToast(
              "Voicemail saved to downloads/ITP Voicemails/voicemail_$id.mp3",
              false);
          return;
        } on DioError catch (e) {
          Get.back();
          savePath = "";
          CustomToast.showToast(
              "Something when wrong while downloading voicemail", true);
          // print(e.message);
          return;
        } catch (e) {
          Get.back();
          CustomToast.showToast("Something went wrong", true);
          return;
        }
      }
    } else {
      CustomToast.showToast(
        "Please allow storage permission to download voicemail",
        true,
      );
      return null;
    }
  }

  // initialiseAudio(String id) async {
  //   String? apiId = await SharedPreferencesMethod.getString(StorageKeys.API_ID);
  //   String? token =
  //       await SharedPreferencesMethod.getString(StorageKeys.REFRESH_TOKEN);

  //   voiceMailDuration = await player.setAudioSource(AudioSource.uri(Uri.parse(
  //       "${Endpoints.DOWNLOAD_VOICE_MAIL_MESSAGES(apiId)}/${id}?token=${token}")));
  // }
}
