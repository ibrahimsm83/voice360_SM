import 'package:floating_bottom_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itp_voice/app_theme.dart';
import 'package:itp_voice/controllers/chat_controller.dart';
import 'package:itp_voice/controllers/settings_controller.dart';
import 'package:itp_voice/models/message.dart';
import 'package:itp_voice/routes.dart';
import 'package:itp_voice/screens/home_screen.dart';
import 'package:itp_voice/widgets/app_button.dart';
import 'package:itp_voice/widgets/chat_message_tile.dart';
import 'package:itp_voice/widgets/phone_number_field.dart';

import '../repo/shares_preference_repo.dart';
import '../storage_keys.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  final double minValue = 8.0.h;
  List<Message> myMessagesList = myMessages;

  bool isCurrentUserTyping = false;

  ScrollController? _scrollController;

  final double iconSize = 28.0;

  ChatController con = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
          height: 55.h,
          // color: Colors.blue,
          child: Column(
            children: [
              Divider(
                height: 0,
                color: Colors.grey,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => con.sendMessage(isImage: true),
                              child: Container(
                                margin: EdgeInsets.only(left: 20.w, right: 20.w),
                                height: 20.h,
                                width: 20.h,
                                child: Image.asset(
                                  "assets/images/paperclip.png",
                                  color: AppTheme.colors(context)?.textColor,
                                ),
                              ),
                            ),
                            Container(
                              width: 250.w,
                              height: 30.h,
                              alignment: Alignment.centerLeft,
                              // color: Colors.blue,
                              child: TextField(
                                controller: con.messageController,
                                style: TextStyle(fontSize: 14.sp),
                                decoration: InputDecoration.collapsed(
                                  hintStyle: TextStyle(
                                    fontSize: 14.sp,
                                  ),
                                  hintText: "Write a message",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Obx(
                      () => GestureDetector(
                        onTap: () => con.sendMessage(),
                        child: Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            margin: const EdgeInsets.only(
                              right: 12,
                              top: 12,
                            ),
                            padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 4.w, bottom: 4.w),
                            width: 32,
                            height: 32,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: con.isMessageLoading.value == true
                                    ? null
                                    : Border.all(width: 1.5, color: AppColors.black)),
                            child: con.isMessageLoading.value == true
                                ? CircularProgressIndicator(
                                    color: AppColors.black,
                                  )
                                : Image.asset(
                                    "assets/images/send_icon.jpg",
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Container(
          margin: EdgeInsets.only(top: 10.h, left: 0.w),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: AppTheme.colors(context)?.textColor,
              size: 18.sp,
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.only(top: 10.h),
          child: Text(
            con.threadNumber ?? "",
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => Scaffold(
                        body: Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: HomeScreen(
                            initialValue: con.threadNumber ?? "",
                          ),
                        ),
                      )));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20, top: 7),
              child: Icon(
                Icons.phone,
                color: AppTheme.colors(context)?.textColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.CHAT_DETAIL_ROUTE, arguments: con.threadNumber ?? "");
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20, top: 7),
              child: Icon(
                Icons.info_outline,
                color: AppTheme.colors(context)?.textColor,
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Divider(
              height: 0,
            ),
            Expanded(
              child: Obx(
                () => con.isLoading.value == true
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        controller: _scrollController,
                        padding: EdgeInsets.symmetric(vertical: minValue * 7, horizontal: 0),
                        itemCount: con.messages?.result?.messages?.length ?? 0,
                        itemBuilder: (context, index) {
                          // final Message message = myMessagesList[index];
                          String? apiId = SharedPreferencesMethod.getString(StorageKeys.API_ID);
                          String _token = SharedPreferencesMethod.getString(StorageKeys.ACCESS_TOKEN)!;
                          return MyMessageChatTile(
                            isDelivered: con.messages?.result?.messages?[index].isDelivered,
                            media: con.messages?.result?.messages?[index].messageMmsMedia == null
                                ? null
                                : "https://api.itpscorp.com/dev/portal/itpvoice/v2/${apiId}/my-extension/chat/media/${con.messages?.result?.messages?[index].messageMmsMedia}?token=${_token}",
                            fileName: con.messages?.result?.messages?[index].messageMmsMedia,
                            message: con.messages?.result?.messages?[index].messageBody ?? '',
                            isCurrentUser:
                                (con.messages?.result?.messages?[index].messageParticipant ?? '') == con.myNumber,
                            deliveryTime: DateTime.parse(con.messages!.result!.messages![index].messageTimestamp!)
                                    .toLocal()
                                    .hour
                                    .toString()
                                    .padLeft(2, "0") +
                                ':' +
                                DateTime.parse(con.messages!.result!.messages![index].messageTimestamp!)
                                    .toLocal()
                                    .minute
                                    .toString()
                                    .padLeft(2, "0"),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
