import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itp_voice/controllers/settings_controller.dart';
import 'package:itp_voice/models/message.dart';
import 'package:itp_voice/routes.dart';
import 'package:itp_voice/widgets/app_button.dart';
import 'package:itp_voice/widgets/chat_message_tile.dart';
import 'package:itp_voice/widgets/phone_number_field.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  final double minValue = 8.0.h;
  List<Message> myMessagesList = myMessages;

  bool isCurrentUserTyping = false;

  ScrollController? _scrollController;

  final double iconSize = 28.0;

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
              SizedBox(
                height: 12.h,
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20.w, right: 20.w),
                    height: 20.h,
                    width: 20.h,
                    child: Image.asset(
                      "assets/images/paperclip.png",
                    ),
                  ),
                  Container(
                    width: 250.w,
                    height: 30.h,
                    alignment: Alignment.centerLeft,
                    // color: Colors.blue,
                    child: TextField(
                      style: TextStyle(fontSize: 14.sp),
                      decoration: InputDecoration.collapsed(
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                        ),
                        hintText: "Write a message",
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 8.h),
                    height: 20.h,
                    width: 20.h,
                    child: Image.asset(
                      "assets/images/send.png",
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
              color: Colors.black,
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
            "Aiden Mathew",
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Divider(
              height: 0,
            ),
            Expanded(
              child: ListView.builder(
                reverse: true,
                shrinkWrap: true,
                controller: _scrollController,
                padding:
                    EdgeInsets.symmetric(vertical: minValue * 7, horizontal: 0),
                itemCount: myMessagesList.length,
                itemBuilder: (context, index) {
                  final Message message = myMessagesList[index];
                  return MyMessageChatTile(
                    message: message,
                    isCurrentUser: message.senderId == 9,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
