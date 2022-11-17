import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:itp_voice/repo/shares_preference_repo.dart';
import 'package:itp_voice/storage_keys.dart';

class CallSettingsController extends GetxController {
  RxBool isLoading = false.obs;

  RxBool callForwarding = false.obs;

  // CALLER ID SETTINGS
  RxBool _overrideDefaultCallerIdSettings = false.obs;
  bool get overrideDefaultCallerIdSettings => _overrideDefaultCallerIdSettings.value;
  set overrideDefaultCallerIdSettings(bool value) {
    print(value);
    if (value == false) {
      SharedPreferencesMethod.storage.remove(StorageKeys.CURRENT_CALL_NAME);
      SharedPreferencesMethod.storage.remove(StorageKeys.CURRENT_CALL_NUMBER);
    }
    _overrideDefaultCallerIdSettings.value = value;
    isLoading.value = true;
    isLoading.value = false;
  }

  TextEditingController callerNameController = TextEditingController();
  TextEditingController callerNnumberController = TextEditingController();

  updateOverriddenCallerData() async {
    await SharedPreferencesMethod.storage.setString(StorageKeys.CURRENT_CALL_NAME, callerNameController.text);
    await SharedPreferencesMethod.storage.setString(StorageKeys.CURRENT_CALL_NUMBER, callerNnumberController.text);
  }

  RxBool forwardDirectCallsOnly = false.obs;
  RxBool keepOriginalCallerId = false.obs;
  RxBool callRecordingInternal = false.obs;
  RxBool callRecordingExternal = false.obs;

  @override
  void onInit() {
    String? callNumber = SharedPreferencesMethod.storage.getString(StorageKeys.CURRENT_CALL_NUMBER);
    if (callNumber != null) {
      callerNameController.text = SharedPreferencesMethod.storage.getString(StorageKeys.CURRENT_CALL_NAME) ?? '';
      callerNnumberController.text = SharedPreferencesMethod.storage.getString(StorageKeys.CURRENT_CALL_NUMBER) ?? '';
      _overrideDefaultCallerIdSettings.value = true;
    }
    isLoading.value = true;
    isLoading.value = false;
    super.onInit();
  }
}
