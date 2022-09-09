import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:itp_voice/models/user_profile_model/result.dart';

class ProfileController extends GetxController {
  Profile? userProfile;
  TextEditingController nameController = TextEditingController();
  TextEditingController profileController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  String phoneCode = "";
  fetchUserProfile() async {}
}
