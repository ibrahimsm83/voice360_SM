import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:itp_voice/models/get_thread_messages_response_model/get_thread_messages_response_model.dart';
import 'package:itp_voice/notification_service.dart';
import 'package:itp_voice/routes.dart';

import '../repo/messages_repo.dart';

class ChatController extends GetxController {
  RxBool isLoading = false.obs;
  MessagesRepo repo = MessagesRepo();
  String myNumber = '+13053170959';
  String get threadId => Get.arguments;
  GetThreadMessagesResponseModel? messages;
  TextEditingController messageController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    fetchChat();
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          if (Get.currentRoute == Routes.CHAT_SCREEN_ROUTE) {
            fetchChat();
          } else {
            LocalNotificationService.createanddisplaynotification(message);
          }
        }
      },
    );
    super.onInit();
  }

  fetchChat() async {
    isLoading.value = true;

    final res = await repo.getThreadMessages(threadId);
    if (res.runtimeType == GetThreadMessagesResponseModel) {
      messages = res;
    }
    isLoading.value = false;
  }

  sendMessage() async {
    List numbers = [];
    messages!.result!.participants!
        .where((element) => element.number != myNumber)
        .toList()
        .forEach((element) {
      numbers.add(element.number);
    });
    repo.sendMessage(myNumber, messageController.text, numbers);
  }
}
