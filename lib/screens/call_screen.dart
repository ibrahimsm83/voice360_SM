import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itp_voice/controllers/call_screen_controller.dart';
import 'package:itp_voice/routes.dart';
import 'package:itp_voice/widgets/action_button.dart';
import 'package:sip_ua/sip_ua.dart';

class CallScreen extends StatelessWidget {
  CallScreen({Key? key}) : super(key: key);

  CallScreenController con = Get.put(CallScreenController());
  @override
  Widget buildActionButtons() {
    var hangupBtn = ActionButton(
      title: "hangup",
      onPressed: () => con.handleHangup(),
      icon: Icons.call_end,
      fillColor: Colors.red,
    );

    var hangupBtnInactive = ActionButton(
      title: "hangup",
      onPressed: () {},
      icon: Icons.call_end,
      fillColor: Colors.grey,
    );

    var basicActions = <Widget>[];
    var advanceActions = <Widget>[];

    switch (con.state.value) {
      case CallStateEnum.NONE:
      case CallStateEnum.CONNECTING:
        if (con.call!.direction == 'INCOMING') {
          basicActions.add(ActionButton(
            title: "Accept",
            fillColor: Colors.green,
            icon: Icons.phone,
            onPressed: () => con.handleAccept(),
          ));
          basicActions.add(hangupBtn);
        } else {
          basicActions.add(hangupBtn);
        }
        break;
      case CallStateEnum.ACCEPTED:
      case CallStateEnum.CONFIRMED:
        {
          advanceActions.add(Obx(() => ActionButton(
                title: con.audioMuted.value ? 'unmute' : 'mute',
                icon: con.audioMuted.value ? Icons.mic_off : Icons.mic,
                checked: con.audioMuted.value,
                onPressed: () => con.muteAudio(),
              )));

          if (con.voiceonly) {
            advanceActions.add(ActionButton(
              title: "keypad",
              icon: Icons.dialpad,
              // onPressed: () => con.handleKeyPad(),
            ));
          }

          if (con.voiceonly) {
            advanceActions.add(Obx(() => ActionButton(
                  title: con.speakerOn.value ? 'speaker off' : 'speaker on',
                  icon:
                      con.speakerOn.value ? Icons.volume_off : Icons.volume_up,
                  checked: con.speakerOn.value,
                  onPressed: () => con.toggleSpeaker(),
                )));
          }
          // else {
          //   advanceActions.add(ActionButton(
          //     title: _videoMuted ? "camera on" : 'camera off',
          //     icon: _videoMuted ? Icons.videocam : Icons.videocam_off,
          //     checked: _videoMuted,
          //     onPressed: () => _muteVideo(),
          //   ));
          // }

          basicActions.add(Obx(() => ActionButton(
                title: con.hold.value ? 'unhold' : 'hold',
                icon: con.hold.value ? Icons.play_arrow : Icons.pause,
                checked: con.hold.value,
                onPressed: () => con.handleHold(),
              )));

          basicActions.add(hangupBtn);

          if (con.showNumpad.value) {
            basicActions.add(ActionButton(
              title: "back",
              icon: Icons.keyboard_arrow_down,
              // onPressed: () => con.handleKeyPad(),
            ));
          }
        }
        break;
      case CallStateEnum.FAILED:
      case CallStateEnum.ENDED:
        basicActions.add(hangupBtnInactive);
        break;
      case CallStateEnum.PROGRESS:
        basicActions.add(hangupBtn);
        break;
      default:
        // print('Other state => $_state');
        break;
    }

    var actionWidgets = <Widget>[];

    // if (con.showNumpad.value) {
    //   actionWidgets.addAll(_buildNumPad());
    // } else {
    //   if (advanceActions.isNotEmpty) {
    //     actionWidgets.add(Padding(
    //         padding: const EdgeInsets.all(3),
    //         child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: advanceActions)));
    //   }
    // }

    actionWidgets.add(Padding(
        padding: const EdgeInsets.all(3),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: basicActions)));

    return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: actionWidgets);
  }

  @override
  Widget build(BuildContext context) {
    print("Call state" + con.state.value.toString());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  child: buildContent(),
                ),

                // (con.call!.direction == "INCOMING")
                //     ? Obx(() => con.state.value == CallStateEnum.ACCEPTED
                //         ? Container()
                //         : Column(
                //             mainAxisAlignment: MainAxisAlignment.end,
                //             children: [
                //               SizedBox(
                //                 height: 400.h,
                //               ),
                //               Row(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 children: [
                //                   Obx(
                //                     () => ActionButton(
                //                       icon: Icons.call_outlined,
                //                       checked: false,
                //                       fillColor: con.hold.value
                //                           ? Theme.of(context)
                //                               .colorScheme
                //                               .secondary
                //                           : Colors.white,
                //                       onPressed: () {
                //                         con.handleAccept();
                //                       },
                //                       iconColor:
                //                           Theme.of(context).colorScheme.primary,
                //                     ),
                //                   ),
                //                   SizedBox(
                //                     width: 40.w,
                //                   ),
                //                   ActionButton(
                //                       icon: Icons.call_end_outlined,
                //                       fillColor: Colors.red,
                //                       checked: false,
                //                       onPressed: () {
                //                         con.handleHangup();
                //                       },
                //                       iconColor: Colors.white),
                //                 ],
                //               ),
                //             ],
                //           ))
                //     :
                Obx(
                  () => con.isIncomingCall!.value &&
                          !con.isIncomingCallAccepted!.value
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 400.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(
                                  () => ActionButton(
                                    icon: Icons.call_outlined,
                                    checked: false,
                                    fillColor: con.hold.value
                                        ? Theme.of(context)
                                            .colorScheme
                                            .secondary
                                        : Colors.white,
                                    onPressed: () {
                                      con.handleAccept();
                                    },
                                    iconColor:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                SizedBox(
                                  width: 40.w,
                                ),
                                ActionButton(
                                    icon: Icons.call_end_outlined,
                                    fillColor: Colors.red,
                                    checked: false,
                                    onPressed: () {
                                      con.handleHangup(goBack: true);
                                    },
                                    iconColor: Colors.white),
                              ],
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 200.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(
                                  () => ActionButton(
                                    icon: con.audioMuted.value
                                        ? Icons.mic_off_outlined
                                        : Icons.mic_outlined,
                                    checked: false,
                                    onPressed: () {
                                      if ((con.state ==
                                              CallStateEnum.CALL_INITIATION ||
                                          con.state ==
                                              CallStateEnum.CONNECTING ||
                                          con.state == CallStateEnum.NONE ||
                                          con.state == CallStateEnum.ENDED)) {
                                        return;
                                      } else {
                                        con.muteAudio();
                                      }
                                    },
                                    iconColor: (con.state ==
                                                CallStateEnum.CALL_INITIATION ||
                                            con.state ==
                                                CallStateEnum.CONNECTING ||
                                            con.state == CallStateEnum.NONE ||
                                            con.state == CallStateEnum.ENDED)
                                        ? Colors.grey
                                        : Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                ActionButton(
                                  icon: Icons.dialpad_outlined,
                                  checked: false,
                                  onPressed: () {
                                    Get.toNamed(Routes.DIALPAD_SCREEN_ROUTE);
                                  },
                                  iconColor:
                                      Theme.of(context).colorScheme.primary,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Obx(
                                  () => ActionButton(
                                    icon: con.speakerOn.value
                                        ? Icons.volume_off_outlined
                                        : Icons.volume_up_outlined,
                                    checked: false,
                                    onPressed: () {
                                      if ((con.state ==
                                              CallStateEnum.CALL_INITIATION ||
                                          con.state ==
                                              CallStateEnum.CONNECTING ||
                                          con.state == CallStateEnum.NONE ||
                                          con.state == CallStateEnum.ENDED)) {
                                        return;
                                      } else {
                                        con.toggleSpeaker();
                                      }
                                    },
                                    iconColor: (con.state ==
                                                CallStateEnum.CALL_INITIATION ||
                                            con.state ==
                                                CallStateEnum.CONNECTING ||
                                            con.state == CallStateEnum.NONE ||
                                            con.state == CallStateEnum.ENDED)
                                        ? Colors.grey
                                        : Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(
                                  () => ActionButton(
                                    icon: Icons.pause,
                                    checked: false,
                                    fillColor: con.hold.value
                                        ? Theme.of(context)
                                            .colorScheme
                                            .secondary
                                        : Colors.white,
                                    onPressed: () {
                                      if ((con.state ==
                                              CallStateEnum.CALL_INITIATION ||
                                          con.state ==
                                              CallStateEnum.CONNECTING ||
                                          con.state == CallStateEnum.NONE ||
                                          con.state == CallStateEnum.ENDED)) {
                                        return;
                                      } else {
                                        con.handleHold();
                                      }
                                    },
                                    iconColor: (con.state ==
                                                CallStateEnum.CALL_INITIATION ||
                                            con.state ==
                                                CallStateEnum.CONNECTING ||
                                            con.state == CallStateEnum.NONE ||
                                            con.state == CallStateEnum.ENDED)
                                        ? Colors.grey
                                        : Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                ActionButton(
                                    icon: Icons.call_end_outlined,
                                    fillColor: Colors.red,
                                    checked: false,
                                    onPressed: () {
                                      con.handleHangup();
                                    },
                                    iconColor: Colors.white),
                              ],
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildContent() {
    var stackWidgets = <Widget>[];

    // if (!voiceonly && _remoteStream != null) {
    //   stackWidgets.add(Center(
    //     child: RTCVideoView(_remoteRenderer!),
    //   ));
    // }

    // if (!voiceonly && _localStream != null) {
    //   stackWidgets.add(Container(
    //     child: AnimatedContainer(
    //       child: RTCVideoView(_localRenderer!),
    //       height: _localVideoHeight,
    //       width: _localVideoWidth,
    //       alignment: Alignment.topRight,
    //       duration: Duration(milliseconds: 300),
    //       margin: con.localVideoMargin,
    //     ),
    //     alignment: Alignment.topRight,
    //   ));
    // }

    stackWidgets.addAll(
      [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            // Center(
            //     child: Padding(
            //         padding: const EdgeInsets.all(6),
            //         child: Obx(() => Text(
            //               (con.voiceonly ? 'VOICE CALL' : 'VIDEO CALL') +
            //                   (con.hold.value
            //                       ? ' PAUSED BY ${con.holdOriginator!.toUpperCase()}'
            //                       : ''),
            //               style: TextStyle(
            //                 fontSize: 24,
            //                 color: Colors.white,
            //               ),
            //             )))),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Text(
                  con.call!.remote_identity!,
                  style: TextStyle(
                      fontSize: 23.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Obx(() => Center(
                    child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Text(
                    con.timeLabel.value.isEmpty
                        ? (!con.isIncomingCallAccepted!.value &&
                                con.isIncomingCall!.value)
                            ? "Incoming call"
                            : "Calling..."
                        : con.timeLabel.value,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                )))
          ],
        )
      ],
    );

    return Column(
      children: stackWidgets,
    );
  }
}
