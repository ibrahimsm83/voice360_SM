import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itp_voice/repo/contacts_repo.dart';

import '../app_theme.dart';
import '../repo/shares_preference_repo.dart';
import '../storage_keys.dart';

class SettingsController extends GetxController {
  ContactsRepo contactsRepo = ContactsRepo();

  RxBool isPhoneEditing = false.obs;

  TextEditingController myNumberController = TextEditingController(text: Get.arguments);

  RxBool isLoading = false.obs;

  RxBool isDark = false.obs;

  updateNumber() async {
    try {
      await contactsRepo.updateMyNumber(myNumberController.text);
    } catch (e) {
      myNumberController.text = Get.arguments;
    }
    isLoading.value = true;
    isLoading.value = false;
  }

  @override
  void onInit() {
    isDark.value = SharedPreferencesMethod.storage.getBool(StorageKeys.DARK_THEME) ?? false;

    super.onInit();
  }

  void changeTheme(bool value) {
    if (value == true) {
      Get.changeThemeMode(ThemeMode.dark);
      SharedPreferencesMethod.storage.setBool(StorageKeys.DARK_THEME, true);
    } else {
      Get.changeThemeMode(ThemeMode.light);
      SharedPreferencesMethod.storage.setBool(StorageKeys.DARK_THEME, false);
    }
  }
}
