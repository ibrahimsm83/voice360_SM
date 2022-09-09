import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itp_voice/controllers/voicemails_controller.dart';
import 'package:itp_voice/routes.dart';
import 'package:itp_voice/widgets/text_container.dart';
import 'package:itp_voice/widgets/search_textfield.dart';
import 'package:itp_voice/widgets/voice_mails_shimmer.dart';

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

class VoiceMailScreen extends StatelessWidget {
  VoiceMailScreen({Key? key}) : super(key: key);

  VoiceMailsController con = VoiceMailsController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: GetBuilder<VoiceMailsController>(
          init: con,
          builder: (VoiceMailsController value) {
            return SingleChildScrollView(
              child: Container(
                  child: Column(
                children: [
                  Divider(
                    height: 0,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Searchbar(
                    controller: value.searchController,
                    onChanged: (val) {
                      value.update();
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  value.isVoiceMailsLoading
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.64,
                          child: VoiceMailsShimmer(),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.64,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: value.getDataList().length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.VOICE_MAIL_DETAILS_ROUTE,
                                        arguments: {
                                          'voicemail':
                                              value.getDataList()[index]
                                        });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 10.h),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            TextBox(
                                                text:
                                                    "${value.getDataList()[index].callerid!.split("<")[0].replaceAll('"', "")[0]}"),
                                            SizedBox(width: 15.w),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "${value.getDataList()[index].callerid!.split("<")[0].replaceAll('"', "")}",
                                                        // style: ts(1, 0xff1B1A57, 14.sp, 5),
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                      value
                                                              .getDataList()[
                                                                  index]
                                                              .usertime!
                                                              .split(" ")[0] +
                                                          " | " +
                                                          value
                                                              .voiceMails[index]
                                                              .usertime!
                                                              .split(" ")[1],
                                                      // style: ts(1, 0xff4F5E7B, 12.sp, 4),
                                                      style: TextStyle(
                                                          fontSize: 13.sp,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .tertiary),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                ],
              )),
            );
          }),
    );
  }
}
