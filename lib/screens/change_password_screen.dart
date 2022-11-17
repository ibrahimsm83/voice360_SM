import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itp_voice/app_theme.dart';
import 'package:itp_voice/controllers/settings_controller.dart';
import 'package:itp_voice/routes.dart';
import 'package:itp_voice/widgets/app_button.dart';
import 'package:itp_voice/widgets/password_textfield.dart';
import 'package:itp_voice/widgets/phone_number_field.dart';

class ChangePassordScreen extends StatelessWidget {
  ChangePassordScreen({Key? key}) : super(key: key);

  SettingsController con = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Container(
          margin: EdgeInsets.only(top: 10.h, left: 0.w),
          child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back_ios, color: AppTheme.colors(context)?.textColor, size: 18.sp)),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.only(top: 10.h),
          child: Text(
            "Change Password",
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Divider(
              height: 0,
            ),
            SizedBox(
              height: 30.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your new password must be different from previously used passwords",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Current Password",
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
                  PasswordTextField(
                    hint: "Enter Current Password",
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "New Password",
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
                  PasswordTextField(
                    hint: "Enter New Password",
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Confirm New Password",
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
                  PasswordTextField(
                    hint: "Confirm New Password",
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            )
          ],
        ),
      ),
    );
  }
}
