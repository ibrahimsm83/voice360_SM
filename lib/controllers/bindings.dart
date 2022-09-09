import 'package:get/get.dart';
import 'package:itp_voice/repo/base_requester.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sip_ua/sip_ua.dart';

class Binding implements Bindings {
  @override
  void dependencies() async {
    await Get.putAsync<SharedPreferences>(() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs;
    }, permanent: true);

    await Get.putAsync<SIPUAHelper>(() async {
      final helper = SIPUAHelper();
      return helper;
    }, permanent: true);

    await Get.put<BaseRequester>(BaseRequester(), permanent: true);
  }
}
