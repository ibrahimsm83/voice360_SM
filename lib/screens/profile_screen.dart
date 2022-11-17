import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itp_voice/app_theme.dart';
import 'package:itp_voice/controllers/profile_controller.dart';
import 'package:itp_voice/routes.dart';
import 'package:itp_voice/widgets/app_textfield.dart';
import 'package:itp_voice/widgets/custom_widgets/country_phone_code_picker/core/country_phone_code_picker_widget.dart';
import 'package:itp_voice/widgets/custom_widgets/country_phone_code_picker/models/country.dart';
import 'package:itp_voice/widgets/phone_number_field.dart';
import 'package:itp_voice/widgets/prefix_textfield.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  String profileImage =
      "https://images.unsplash.com/photo-1640951613773-54706e06851d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80";

  ProfileController con = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () async {
              await Get.toNamed(Routes.SETTINGS_SCREEN_ROUTE, arguments: con.mobileController.text);
              con.fetchUserProfile();
            },
            child: Container(
              margin: EdgeInsets.only(right: 15.w, top: 10.h),
              child: Image.asset(
                "assets/images/settings.png",
                height: 25.h,
                width: 25.h,
                color: AppTheme.colors(context)?.textColor,
              ),
            ),
          )
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.only(top: 10.h),
          child: Text(
            "Profile",
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Obx(
        () => con.isloading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        height: 0,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Container(
                              height: 110.h,
                              width: 110.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, image: DecorationImage(image: NetworkImage(profileImage))),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                  padding: EdgeInsets.all(5.5.h),
                                  height: 35.h,
                                  width: 35.w,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    "assets/images/camera.png",
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Full Name",
                              style: TextStyle(
                                color: AppTheme.colors(context)?.textColor,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: " *",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      AppTextField(
                        textController: con.nameController,
                        hint: "Jhon Doe",
                        isReadOnly: true,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Email Address",
                              style: TextStyle(
                                color: AppTheme.colors(context)?.textColor,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: " *",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      AppTextField(
                        textController: con.emailController,
                        isReadOnly: true,
                        hint: "jhondoe21@gmail.com",
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Phone Number",
                              style: TextStyle(
                                color: AppTheme.colors(context)?.textColor,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: " *",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      PhoneNumberField(
                        textController: con.mobileController,
                        readOnly: true,
                        hint: "XXX XXXXXXXX",

                        // SizedBox(,)as
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
