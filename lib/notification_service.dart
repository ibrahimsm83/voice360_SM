import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:itp_voice/routes.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize() async {
    // initializationSettings  for Android
    const InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );

    _notificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? data) async {
        if (data != null) {
          final notificationData = jsonDecode(data);
          if ((notificationData as Map<String, dynamic>).containsKey("message_thread_id")) {
            Get.toNamed(Routes.CHAT_SCREEN_ROUTE,
                arguments: [notificationData["message_thread_id"], notificationData["to_phone_number"], null]);
          }
        }
      },
    );

    print(await FirebaseMessaging.instance.getToken());
  }

  static void createanddisplaynotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "itpvoice",
          "pushnotificationappchannel",
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: jsonEncode(message.data),
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
