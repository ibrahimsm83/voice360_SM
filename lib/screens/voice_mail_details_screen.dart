import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itp_voice/app_theme.dart';
import 'package:itp_voice/controllers/voicemails_controller.dart';
import 'package:itp_voice/models/get_voice_mails_response_model/result.dart';
import 'package:itp_voice/routes.dart';
import 'package:itp_voice/widgets/text_container.dart';
import 'package:itp_voice/widgets/search_textfield.dart';
import 'package:audio_wave/audio_wave.dart';
import 'package:itp_voice/widgets/voicemail_player.dart';

List avatarImages = [
  "https://i.imgur.com/Fur0AUt.png",
  "https://i.imgur.com/kL7WMgG.png",
  "https://i.imgur.com/Bwf87Tv.png",
  "https://i.imgur.com/Fur0AUt.png",
  "https://i.imgur.com/kL7WMgG.png",
  "https://i.imgur.com/Bwf87Tv.png",
  "https://i.imgur.com/Fur0AUt.png",
  "https://i.imgur.com/kL7WMgG.png",
  "https://i.imgur.com/Bwf87Tv.png",
  "https://i.imgur.com/Fur0AUt.png",
  "https://i.imgur.com/kL7WMgG.png",
  "https://i.imgur.com/Bwf87Tv.png",
];

class VoiceMailDetailsScreen extends StatelessWidget {
  VoiceMailDetailsScreen({Key? key}) : super(key: key);

  VoiceMailsController con = Get.find<VoiceMailsController>();

  VoiceMails voicemail = Get.arguments['voicemail'];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VoiceMailsController>(
        init: con,
        builder: (VoiceMailsController value) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      useRootNavigator: true,
                      builder: (context) {
                        return Container(
                          height: 180.h,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(children: [
                            SizedBox(height: 10.h),
                            Divider(
                              color: Colors.grey.shade400,
                              thickness: 3,
                              indent: 140.w,
                              endIndent: 140.w,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Actions",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.secondary),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                // Get.toNamed(Routes.CALL_HISTORY_SCREEN_ROUTE);
                                con.deleteVoiceMail(voicemail.pk.toString());
                              },
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Delete",
                                  style: TextStyle(fontSize: 18.sp, color: Theme.of(context).colorScheme.secondary),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                con.downloadVoicemail(voicemail.pk.toString());
                              },
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Download",
                                  style: TextStyle(fontSize: 18.sp, color: Theme.of(context).colorScheme.secondary),
                                ),
                              ),
                            )
                          ]),
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 20.w, top: 10.h),
                    child: Icon(Icons.more_vert, color: Color(0xff6B6F80), size: 22.sp),
                  ),
                )
              ],
              leading: Container(
                margin: EdgeInsets.only(top: 10.h, left: 0.w),
                child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back_ios, color: AppTheme.colors(context)?.textColor, size: 18.sp)),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Container(
                padding: EdgeInsets.only(top: 10.h),
                child: Text(
                  "Voicemail",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                  child: Column(
                children: [
                  Divider(
                    height: 0,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            TextBox(
                              text: "${voicemail.callerid!.split("<")[0].replaceAll('"', "")[0]}",
                            ),
                            SizedBox(width: 15.w),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${voicemail.callerid!.split("<")[0].replaceAll('"', "")}",
                                          // style: ts(1, 0xff1B1A57, 14.sp, 5),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 3.h),
                                    Container(
                                      width: 215.w,
                                      child: Text(
                                        voicemail.usertime!.split(" ")[0] + " | " + voicemail.usertime!.split(" ")[1],
                                        // style: ts(1, 0xff4F5E7B, 12.sp, 4),
                                        style:
                                            TextStyle(fontSize: 13.sp, color: Theme.of(context).colorScheme.tertiary),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Divider(
                    height: 0,
                    thickness: 0.5,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Text(
                        "Voicemail",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),

                  VoiceMailPlayer(
                    id: voicemail.pk.toString(),
                  )

                  // Container(
                  //   padding: EdgeInsets.all(10.h),
                  //   margin: EdgeInsets.symmetric(horizontal: 15.w),
                  //   decoration: BoxDecoration(
                  //       color: Theme.of(context).colorScheme.primary,
                  //       borderRadius: BorderRadius.circular(20.r),
                  //       border: Border.all(width: 1, color: Colors.white)),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       SizedBox(
                  //         width: 5.w,
                  //       ),
                  //       InkWell(
                  //           onTap: () async {
                  //             print(value.playerController!.playerState);
                  //             try {
                  //               value.playerController!.playerState ==
                  //                       PlayerState.playing
                  //                   ? value.playerController!.pausePlayer()
                  //                   : value.playerController!.startPlayer();
                  //             } catch (e) {
                  //               print("ERRROOORRRR:::" + e.toString());
                  //             }
                  //             value.playerController!.onPlayerStateChanged
                  //                 .listen((event) {
                  //               print("STATUS CHANGED" + event.toString());
                  //             });
                  //             // : await value.downloadVoicemail(
                  //             //     voicemail.pk.toString());
                  //             value.update();
                  //             print(value.playerController!.playerState);
                  //           },
                  //           child: value.isVoiceMailsLoading
                  //               ? Container(
                  //                   height: 30.h,
                  //                   width: 30.h,
                  //                   child: CircularProgressIndicator(
                  //                     color: Colors.white,
                  //                   ),
                  //                 )
                  //               : Image(
                  //                   image: AssetImage(
                  //                       value.playerController!.playerState ==
                  //                               PlayerState.playing
                  //                           ? "assets/images/pause.png"
                  //                           : "assets/images/play_button.png"),
                  //                   width: 40.w,
                  //                   height: 40.h,
                  //                 )),
                  //       value.voiceMailDownload
                  //           ? SizedBox(
                  //               width: MediaQuery.of(context).size.width * 0.5,
                  //               height: 20.h,
                  //               // padding: EdgeInsets.symmetric(vertical: 10.h),
                  //               child: AudioFileWaveforms(
                  //                 // padding: EdgeInsets.symmetric(vertical: .h),
                  //                 // playerWaveStyle: PlayerWaveStyle(
                  //                 //   visualizerHeight: 10.h,
                  //                 // ),
                  //                 size: Size(
                  //                     MediaQuery.of(context).size.width * 0.5,
                  //                     20.h),
                  //                 playerController: value.playerController!,
                  //               ),
                  //             )
                  //           : Container(),

                  //       SizedBox(
                  //         width: 5.w,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              )),
            ),
          );
        });
  }
}
