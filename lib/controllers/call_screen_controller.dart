import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' as flwebrtc;
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:itp_voice/routes.dart';
import 'package:sip_ua/sip_ua.dart';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:sip_ua/sip_ua.dart';

class CallScreenController extends GetxController
    implements SipUaHelperListener {
  RxBool showNumpad = false.obs;
  RxBool audioMuted = false.obs;
  RxBool videoMuted = false.obs;
  RxBool speakerOn = false.obs;
  RxBool hold = false.obs;
  RxString? holdOriginator = "".obs;
  RxBool? isIncomingCall = false.obs;
  RxBool? isIncomingCallAccepted = false.obs;
  Rx<CallStateEnum> state = CallStateEnum.NONE.obs;
  RxString timeLabel = ''.obs;
  Timer? timer;
  RTCVideoRenderer? localRenderer = RTCVideoRenderer();
  RTCVideoRenderer? remoteRenderer = RTCVideoRenderer();
  MediaStream? localStream;
  MediaStream? remoteStream;
  bool get voiceonly =>
      (localStream == null || localStream!.getVideoTracks().isEmpty) &&
      (remoteStream == null || remoteStream!.getVideoTracks().isEmpty);
  SIPUAHelper? helper;
  Call? call;

  @override
  void onInit() {
    // TODO: implement onInit
    call = Get.arguments;
    if (call!.direction == "INCOMING") {
      isIncomingCall!.value = true;
      isIncomingCallAccepted!.value = false;
    }
    helper = Get.find<SIPUAHelper>();
    helper!.addSipUaHelperListener(this);
    startTimer();

    super.onInit();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      Duration duration = Duration(seconds: timer.tick);
      if (Get.routing.current == Routes.CALL_SCREEN_ROUTE) {
        // this.setState(() {
        timeLabel.value = [duration.inMinutes, duration.inSeconds]
            .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
            .join(':');
        // });
      } else {
        timer.cancel();
      }
    });
  }

  void handelStreams(CallState event) async {
    MediaStream? stream = event.stream;
    event.stream?.getAudioTracks().first.enableSpeakerphone(false);
    localStream = stream;
    // }
    if (event.originator == 'remote') {
      if (remoteRenderer != null) {
        remoteRenderer!.srcObject = stream;
      }
      remoteStream = stream;
    }
  }

  @override
  void callStateChanged(Call call, CallState callState) {
    if (callState.state == CallStateEnum.HOLD ||
        callState.state == CallStateEnum.UNHOLD) {
      hold.value = callState.state == CallStateEnum.HOLD;
      holdOriginator!.value = callState.originator!;
      // this.setState(() {});
      return;
    }

    if (callState.state == CallStateEnum.MUTED) {
      if (callState.audio!) audioMuted.value = true;
      if (callState.video!) videoMuted.value = true;
      // this.setState(() {});
      return;
    }

    if (callState.state == CallStateEnum.UNMUTED) {
      if (callState.audio!) audioMuted.value = false;
      if (callState.video!) videoMuted.value = false;
      // this.setState(() {});
      return;
    }

    if (callState.state != CallStateEnum.STREAM) {
      state.value = callState.state;
    }
    print("Session Start Time" + call.session.start_time.toString());
    if (call.session.start_time != null) {
      startTimer();
    }
// call.session.
    switch (callState.state) {
      case CallStateEnum.STREAM:
        handelStreams(callState);
        break;
      case CallStateEnum.ENDED:
        Get.back();
        break;
      case CallStateEnum.FAILED:
        // _backToDialPad();
        break;
      case CallStateEnum.UNMUTED:
        print("CallStateEnum.UNMUTED");
        break;
      case CallStateEnum.MUTED:
        print("CallStateEnum.MUTED");
        break;
      case CallStateEnum.CONNECTING:
        print("CallStateEnum.CONNECTING");
        break;
      case CallStateEnum.PROGRESS:
        print("CallStateEnum.PROGRESS");
        break;
      case CallStateEnum.ACCEPTED:
        state.value = CallStateEnum.ACCEPTED;
        print("CallStateEnum.ACCEPTED");
        break;
      case CallStateEnum.CONFIRMED:
        print("CallStateEnum.CONFIRMED");
        break;
      case CallStateEnum.HOLD:
        print("CallStateEnum.HOLD");
        break;
      case CallStateEnum.UNHOLD:
        print("CallStateEnum.UNHOLD");
        break;
      case CallStateEnum.NONE:
        print("CallStateEnum.NONE");
        break;
      case CallStateEnum.CALL_INITIATION:
        print("CallStateEnum.CALL_INITIATION");
        break;
      case CallStateEnum.REFER:
        print("CallStateEnum.REFER");
        break;
    }
  }

  @override
  void onNewMessage(SIPMessageRequest msg) {
    // TODO: implement onNewMessage
  }

  @override
  void registrationStateChanged(RegistrationState state) {
    // TODO: implement registrationStateChanged
  }

  @override
  void transportStateChanged(TransportState state) {
    // TODO: implement transportStateChanged
  }

  void handleDtmf(String tone) {
    print('Dtmf tone => $tone');
    call!.sendDTMF(tone);
  }

  void handleHangup({bool goBack = false}) {
    try {
      call!.hangup();
      timer!.cancel();
      goBack ? Get.back() : null;
    } catch (e) {
      timer!.cancel();
      goBack ? Get.back() : null;

      print(e.toString());
    }
  }

  void toggleSpeaker() {
    // if (localStream != null) {
    speakerOn.value = !speakerOn.value;
    if (!kIsWeb) {
      localStream!.getAudioTracks()[0].enableSpeakerphone(speakerOn.value);
    }
    // }
  }

  void handleAccept() async {
    bool remote_has_video = call!.remote_has_video;
    final mediaConstraints = <String, dynamic>{
      'audio': true,
      'video': remote_has_video
    };
    MediaStream mediaStream;

    if (kIsWeb && remote_has_video) {
      mediaStream = await flwebrtc.navigator.mediaDevices
          .getDisplayMedia(mediaConstraints);
      mediaConstraints['video'] = false;
      MediaStream userStream =
          await flwebrtc.navigator.mediaDevices.getUserMedia(mediaConstraints);
      mediaStream.addTrack(userStream.getAudioTracks()[0], addToNative: true);
    } else {
      mediaConstraints['video'] = remote_has_video;
      mediaStream =
          await flwebrtc.navigator.mediaDevices.getUserMedia(mediaConstraints);
    }

    call!.answer(helper!.buildCallOptions(!remote_has_video),
        mediaStream: mediaStream);
    isIncomingCallAccepted!.value = true;
  }

  void switchCamera() {
    if (localStream != null) {
      Helper.switchCamera(localStream!.getVideoTracks()[0]);
    }
  }

  void muteAudio() {
    if (audioMuted.value) {
      call!.unmute(true, false);
    } else {
      call!.mute(true, false);
    }
  }

  void muteVideo() {
    if (videoMuted.value) {
      call!.unmute(false, true);
    } else {
      call!.mute(false, true);
    }
  }

  void handleHold() {
    if (hold.value) {
      call!.unhold();
    } else {
      call!.hold();
    }
  }

  callStatus() {
    if (isIncomingCall!.value && !isIncomingCallAccepted!.value) {
      return "Incoming Call";
    }

    if (state.value == CallStateEnum.CALL_INITIATION) {
      return "Calling";
    }
    if (state.value == CallStateEnum.CONFIRMED) {
      return "Ringing";
    }
  }
}
