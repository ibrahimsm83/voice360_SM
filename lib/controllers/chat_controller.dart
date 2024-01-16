import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itp_voice/models/get_thread_messages_response_model/get_thread_messages_response_model.dart';
import 'package:itp_voice/notification_service.dart';
import 'package:itp_voice/routes.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../repo/messages_repo.dart';
import '../repo/shares_preference_repo.dart';
import '../storage_keys.dart';
import '../widgets/custom_toast.dart';

class ChatController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isMicTapped = false.obs;
  RxBool isMessageLoading = false.obs;
  MessagesRepo repo = MessagesRepo();
  String myNumber = Get.arguments[1];
  String? threadNumber = Get.arguments[2];
  String get threadId => Get.arguments[0];
  Rx<GetThreadMessagesResponseModel?> _messages = Rx(null);

  GetThreadMessagesResponseModel? get messages => _messages.value;
  TextEditingController messageController = TextEditingController();
  StreamSubscription? channelSubscription;

  bool socketConnected = false;
  Timer? reconnector;

  @override
  void onClose() {
    reconnector?.cancel();
    channelSubscription?.cancel();
    super.onClose();
  }

  @override
  void onInit() {
    fetchChat();
    repo.markAsRead(threadId, myNumber);
    channelSubscription?.cancel();
    reconnector?.cancel();
    channelSubscription = messageSocketConnect().listen((body) {
      try {
        repo.markAsRead(threadId, myNumber);
      } catch (e) {
        print(e.toString());
      }
      handleWebsocketResponce(body);
    }, onDone: () {
      print("Closed");
      socketConnected = false;
      reconnector = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        if (socketConnected == false) {
          socketConnected = true;
          channelSubscription?.cancel();
          channelSubscription = messageSocketConnect().listen(
            (body) {
              try {
                repo.markAsRead(threadId, myNumber);
              } catch (e) {
                print(e.toString());
              }
              handleWebsocketResponce(body);
            },
            onDone: () {
              socketConnected = false;
              print("Closed");
            },
          );
          print("Reconnected");
        }
      });
    });
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          if (Get.currentRoute == Routes.CHAT_SCREEN_ROUTE) {
            // fetchChat();
          } else {
            LocalNotificationService.createanddisplaynotification(message);
          }
        }
      },
    );

    super.onInit();
  }

  handleWebsocketResponce(dynamic bod) {
    dynamic body = jsonDecode(bod);
    try {
      print(body);
      if (body["payload"] == "Unauthorized") {
        CustomToast.showToast("User Unauthorized Websocket Connection failed", true);
        Get.back();
      }
      socketConnected = true;
      if (body["message_type"] == "sms-status" || body["message_type"] == "sms") {
        if (jsonDecode(body["payload"])["message_status"] != null) {
          print(jsonDecode(body["payload"]) as Map<String, dynamic>);
          // _messages.value?.result?.messages
          //     ?.insert(0, Messages.fromPayload(jsonDecode(body["payload"]) as Map<String, dynamic>));
          int? index = messages?.result?.messages?.indexWhere(
              (element) => element.messageProviderId == jsonDecode(body["payload"])["message_provider_id"]);
          if (index != -1 && index != null) {
            _messages.value!.result!.messages![index].isDelivered = true;
          } else {
            try {
              if (jsonDecode(body["payload"])["from_number"] == threadNumber) {
                _messages.value?.result?.messages
                    ?.insert(0, Messages.fromPayload(jsonDecode(body["payload"]) as Map<String, dynamic>));
              }
            } catch (e) {
              null;
            }
          }
          isLoading.value = true;
          isLoading.value = false;
        } else {
          CustomToast.showToast("Message status from web socket: failed", true);
        }
      }
    } catch (e) {
      print(e.toString());
    }
    // print("RECIEVED FROM WEB SOCKET ${body}");
    // _messages.value?.result?.messages
    //     ?.insert(0, Messages.fromPayload(body["payload"]));
  }

  Stream messageSocketConnect() {
    final apiId = SharedPreferencesMethod.getString(StorageKeys.API_ID);

    final connection = WebSocketChannel.connect(
      Uri.parse("wss://websockets.api.itp247.com/sms"),
      // headers: {
      //   "action": "login",
      //   "payload": {
      //     "account_id": "$apiId",
      //     "jwt_token":
      //         "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NjYzMjQ4NjksImlkIjoiNzYiLCJpYXQiOjE2NjYyMzg0NjksImFjY291bnRfbnVtYmVyIjoiMTY5NTUzMTgiLCJ1c2VyX2NvbnRhY3QiOnsibW9iaWxlIjoiIiwiZmlyc3RuYW1lIjoiRGF2aWQiLCJiaWxsaW5nX2dyb3VwIjp0cnVlLCJsYW5ndWFnZSI6ImVuIiwicGsiOjc2LCJlbWFpbCI6ImRhdmlkcmljYXJkb2xvcGV6YmFycmlvc0BnbWFpbC5jb20iLCJsYXN0bmFtZSI6IkxvcGV6IiwidGVjaG5pY2FsX2dyb3VwIjp0cnVlLCJhY2NvdW50X2lkIjo0MzksImFjY291bnQiOm51bGwsImFkbWluX2dyb3VwIjp0cnVlLCJtb2JpbGVfZGV2aWNlX2lkIjpudWxsLCJ1aV9jb2xvcl9tb2RlIjoiZGFyayIsInRpbWVfem9uZSI6IlVUQyJ9LCJjb250YWN0X2FjbCI6e30sInNlcnZpY2VzX2FwaV9pZF9saXN0IjpbIjk4NDNhMjQ0YmViODQ3MDhiZTA3ZGQ4ZDk2YWUwY2MzIiwiNjEiXSwic2VydmljZXNfdXNlcl9vYmplY3RzIjp7IjYxIjp7InZvaWNlbWFpbF9lbmFibGVkIjp0cnVlLCJwcml2X2xldmVsIjoidXNlciIsInN0YXR1cyI6bnVsbCwiZGVmYXVsdF9vdXRib3VuZF9jYWxsZXJpZF9uYW1lIjpudWxsLCJjYWxsZm9yd2FyZF9udW1iZXIiOiIxMjMiLCJ2bV90b19lbWFpbF9lbmFibGVkIjp0cnVlLCJjYWxsX3JlY29yZGluZ19leHRlcm5hbCI6ImVuYWJsZWQiLCJjYWxsZm9yd2FyZF9lbmFibGUiOnRydWUsImNhbGxmb3J3YXJkX3F1ZXVlX2NhbGxzIjp0cnVlLCJjYWxsZm9yd2FyZF9rZWVwX2NhbGxlcl9jYWxsZXJfaWQiOnRydWUsImNybV9jb250YWN0X2lkIjo3NiwicGsiOjE2MiwicHJlc2VuY2VfaWQiOiIxMDkiLCJ2b2ljZW1haWxfYm94X2lkIjoiMTMwIiwiY2FsbF9yZWNvcmRpbmdfaW50ZXJuYWwiOiJlbmFibGVkIiwiZGVmYXVsdF9vdXRib3VuZF9jYWxsZXJpZF9udW1iZXIiOm51bGwsInVzZXJfdm9sdW1lX3ByZWZlcmVuY2UiOjEwMCwiYWNjb3VudF9pZCI6NjF9fX0.OOrgj9LlK26kTEhJi3BfGAKlyNfZGAHIXIatV1WsJHQ",
      //     "phone_number": "+18637580072"
      //   }
      // },
    );
    // channelSubscription = connection.stream.listen((body) {
    //   print("RECIEVED FROM WEB SOCKET ${jsonDecode(body)}");
    // });
    final String _token = SharedPreferencesMethod.getString(StorageKeys.REFRESH_TOKEN)!;
    connection.sink.add(jsonEncode({
      "action": "login",
      "payload": {"account_id": "$apiId", "jwt_token": _token, "phone_number": myNumber}
    }));
    // connection.sink.add(jsonEncode({
    //   "action": "login",
    //   "payload": {
    //     "account_id": "$apiId",
    //     "jwt_token":
    //         "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NjYzMjQ4NjksImlkIjoiNzYiLCJpYXQiOjE2NjYyMzg0NjksImFjY291bnRfbnVtYmVyIjoiMTY5NTUzMTgiLCJ1c2VyX2NvbnRhY3QiOnsibW9iaWxlIjoiIiwiZmlyc3RuYW1lIjoiRGF2aWQiLCJiaWxsaW5nX2dyb3VwIjp0cnVlLCJsYW5ndWFnZSI6ImVuIiwicGsiOjc2LCJlbWFpbCI6ImRhdmlkcmljYXJkb2xvcGV6YmFycmlvc0BnbWFpbC5jb20iLCJsYXN0bmFtZSI6IkxvcGV6IiwidGVjaG5pY2FsX2dyb3VwIjp0cnVlLCJhY2NvdW50X2lkIjo0MzksImFjY291bnQiOm51bGwsImFkbWluX2dyb3VwIjp0cnVlLCJtb2JpbGVfZGV2aWNlX2lkIjpudWxsLCJ1aV9jb2xvcl9tb2RlIjoiZGFyayIsInRpbWVfem9uZSI6IlVUQyJ9LCJjb250YWN0X2FjbCI6e30sInNlcnZpY2VzX2FwaV9pZF9saXN0IjpbIjk4NDNhMjQ0YmViODQ3MDhiZTA3ZGQ4ZDk2YWUwY2MzIiwiNjEiXSwic2VydmljZXNfdXNlcl9vYmplY3RzIjp7IjYxIjp7InZvaWNlbWFpbF9lbmFibGVkIjp0cnVlLCJwcml2X2xldmVsIjoidXNlciIsInN0YXR1cyI6bnVsbCwiZGVmYXVsdF9vdXRib3VuZF9jYWxsZXJpZF9uYW1lIjpudWxsLCJjYWxsZm9yd2FyZF9udW1iZXIiOiIxMjMiLCJ2bV90b19lbWFpbF9lbmFibGVkIjp0cnVlLCJjYWxsX3JlY29yZGluZ19leHRlcm5hbCI6ImVuYWJsZWQiLCJjYWxsZm9yd2FyZF9lbmFibGUiOnRydWUsImNhbGxmb3J3YXJkX3F1ZXVlX2NhbGxzIjp0cnVlLCJjYWxsZm9yd2FyZF9rZWVwX2NhbGxlcl9jYWxsZXJfaWQiOnRydWUsImNybV9jb250YWN0X2lkIjo3NiwicGsiOjE2MiwicHJlc2VuY2VfaWQiOiIxMDkiLCJ2b2ljZW1haWxfYm94X2lkIjoiMTMwIiwiY2FsbF9yZWNvcmRpbmdfaW50ZXJuYWwiOiJlbmFibGVkIiwiZGVmYXVsdF9vdXRib3VuZF9jYWxsZXJpZF9udW1iZXIiOm51bGwsInVzZXJfdm9sdW1lX3ByZWZlcmVuY2UiOjEwMCwiYWNjb3VudF9pZCI6NjF9fX0.OOrgj9LlK26kTEhJi3BfGAKlyNfZGAHIXIatV1WsJHQ",
    //     "phone_number": "+18637580072"
    //   }
    // }));
    print('CONNECTED TO WEB SOCKET');
    return connection.stream;
  }

  RxBool loadTitle = false.obs;

  fetchChat() async {
    isLoading.value = true;
    final res = await repo.getThreadMessages(threadId, myNumber);
    if (res.runtimeType == GetThreadMessagesResponseModel) {
      _messages.value = res;
      if (threadNumber == null) {
        threadNumber = _messages.value?.result?.participants?.firstWhere((element) => element.isSelf != true).number;
        loadTitle.value = true;
        loadTitle.value = false;
      }
    }
    isLoading.value = false;
  }

  sendMessage({bool isImage = false}) async {
    if (isImage == true) {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        isMessageLoading.value = true;
        List numbers = [];
        messages!.result!.participants!.where((element) => element.number != myNumber).toList().forEach((element) {
          numbers.add(element.number);
        });
        String numberString = "{\"list\": [\"${numbers.join(',')}\"]}";
        await repo.sendMessage(myNumber, "", numberString, image.path).then((message) {
          if (message != null) {
            message.isDelivered = false;
            _messages.value!.result!.messages!.insert(0, message);
            isLoading.value = true;
            isLoading.value = false;
          } else {
            CustomToast.showToast("Please check your internet connvection", true);
          }
        });
        messageController.clear();
        isMessageLoading.value = false;
      }
    } else {
      if (isLoading.value != true && messageController.text.isNotEmpty && isMessageLoading.value != true) {
        isMessageLoading.value = true;
        List numbers = [];
        messages!.result!.participants!.where((element) => element.number != myNumber).toList().forEach((element) {
          numbers.add(element.number);
        });
        String numberString = "{\"list\": [\"${numbers.join(',')}\"]}";
        await repo.sendMessage(myNumber, messageController.text, numberString).then((message) {
          if (message != null) {
            message.isDelivered = false;
            _messages.value!.result!.messages!.insert(0, message);
            isLoading.value = true;
            isLoading.value = false;
          } else {
            CustomToast.showToast("Please check your internet connvection", true);
          }
        });
        messageController.clear();
        isMessageLoading.value = false;
      }
    }
  }
}
