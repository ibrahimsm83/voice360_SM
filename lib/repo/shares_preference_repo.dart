import 'dart:convert';

import 'package:get/get.dart';
import 'package:itp_voice/models/get_devices_reponse_model/devices.dart';
import 'package:itp_voice/models/login_reponse_model/app_user.dart';
import 'package:itp_voice/storage_keys.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesMethod {
  static var storage = Get.find<SharedPreferences>();

  static Future<void> clearLocalStorage() async {
    storage.clear();
  }

  static Future<void> setbool(key, value) async {
    storage.setBool(key, value);
  }

  static bool? getBool(
      key,
      ) {
    bool? data = storage.getBool(key);
    return data;
  }

  static Future<void> setString(key, value) async {
    storage.setString(key, value);
  }


  static String? getString(
    key,
  ) {
    String? data = storage.getString(key);
    return data;
  }

  static AppUser? getUserData() {
    String? keyValue = getString(StorageKeys.APPUSER_DATA)!;
    try {
      AppUser user = AppUser.fromJson(keyValue);
      return user;
    } catch (e) {
      return null;
    }
  }

  static Devices? getDeviceData() {
    String? keyValue = getString(StorageKeys.DEVICE)!;
    try {
      Devices device = Devices.fromJson(keyValue);
      return device;
    } catch (e) {
      return null;
    }
  }
}
