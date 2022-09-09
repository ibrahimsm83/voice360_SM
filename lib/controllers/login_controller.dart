import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:itp_voice/repo/auth_repo.dart';
import 'package:itp_voice/repo/shares_preference_repo.dart';
import 'package:itp_voice/routes.dart';
import 'package:itp_voice/storage_keys.dart';
import 'package:itp_voice/widgets/custom_loader.dart';
import 'package:itp_voice/widgets/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/login_reponse_model/app_user.dart';

class LoginController extends GetxController {
  RxBool isRemember = true.obs;
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final _authRepo = AuthRepo();

  RxBool showLogin = false.obs;
  login() async {
    bool isFormValid = validateLoginForm();
    if (isFormValid) {
      print("Logging in");
      CustomLoader.showLoader();
      var res = await _authRepo.loginUser(
          emailController.text, passwordController.text, isRemember.value);
      Get.back();
      if (res.runtimeType == String) {
        CustomToast.showToast(res.toString(), true);

        return;
      }
      if (res == null) {
        CustomToast.showToast("Unexpected error occurred", true);

        return;
      } else {
        Get.offAllNamed(Routes.BASE_SCREEN_ROUTE);
      }
    }
  }

  validateLoginForm() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      CustomToast.showToast("Please enter email and password", true);
      return false;
    }
    if (emailController.text.isNotEmpty) {
      bool isEmailValid = EmailValidator.validate(emailController.text);
      if (!isEmailValid) {
        CustomToast.showToast("Please enter a valid email", true);
        return false;
      }
    }
    if (passwordController.text.length < 6) {
      CustomToast.showToast("Password must be 6 characters long", true);
      return false;
    }
    return true;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(Duration(seconds: 3), () async {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String? token = _prefs.getString(StorageKeys.REFRESH_TOKEN);
      if (token == null) {
        bool? remember = _prefs.getBool(StorageKeys.REMEMBER);
        if (remember != null && remember) {
          emailController.text = _prefs.getString(StorageKeys.EMAIL)!;
          passwordController.text = _prefs.getString(StorageKeys.PASSWORD)!;
        }
        showLogin.value = true;
      } else {
        Get.offAllNamed(Routes.BASE_SCREEN_ROUTE);
      }
    });
  }
}
