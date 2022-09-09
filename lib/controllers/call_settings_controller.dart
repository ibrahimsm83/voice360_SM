import 'package:get/get.dart';

class CallSettingsController extends GetxController {
  RxBool callForwarding = false.obs;
  RxBool overrideDefaultCallerIdSettings = false.obs;
  RxBool forwardDirectCallsOnly = false.obs;
  RxBool keepOriginalCallerId = false.obs;
  RxBool callRecordingInternal = false.obs;
  RxBool callRecordingExternal = false.obs;
}
