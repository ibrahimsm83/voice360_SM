import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:itp_voice/models/user_profile_model/result.dart';
import 'package:itp_voice/models/user_profile_model/user_profile.dart';
import 'package:itp_voice/repo/auth_repo.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    fetchUserProfile();
    super.onInit();
  }

  RxBool isloading = false.obs;
  Profile? userProfile;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController mobileController = TextEditingController(text: '');

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  AuthRepo repo = AuthRepo();
  String phoneCode = "";
  fetchUserProfile() async {
    isloading.value = true;

    final res = await repo.getProfile();
    if (res.runtimeType == UserProfile) {
      UserProfile model = res;
      userProfile = model.profile;
      nameController.text = (userProfile?.firstname ?? '') +
          (userProfile?.firstname == null ? '' : ' ') +
          (userProfile?.lastname ?? '');
      emailController.text = userProfile?.email ?? '';
      mobileController.text = userProfile?.mobile ?? '';
    }

    isloading.value = false;
  }
}
