import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itp_voice/controllers/settings_controller.dart';
import 'package:itp_voice/repo/auth_repo.dart';
import 'package:itp_voice/routes.dart';
import 'package:itp_voice/widgets/app_button.dart';
import 'package:itp_voice/widgets/phone_number_field.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

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
              child:
                  Icon(Icons.arrow_back_ios, color: Colors.black, size: 18.sp)),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.only(top: 10.h),
          child: Text(
            "Settings",
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
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.CHANGE_PASSWORD_ROUTE);
              },
              child: ListTile(
                title: Text(
                  "Change Password",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).colorScheme.tertiary,
                  size: 18.sp,
                ),
              ),
            ),
            Divider(
              height: 0,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.CALL_SETTINGS_ROUTE);
              },
              child: ListTile(
                title: Text(
                  "Call Settings",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).colorScheme.tertiary,
                  size: 18.sp,
                ),
              ),
            ),
            Divider(
              height: 0,
            ),
            ListTile(
              dense: true,
              title: Text(
                "My Number",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Obx(
              () => Column(
                children: [
                  ListTile(
                      dense: true,
                      title: Text(
                        "+923341223566",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          con.isPhoneEditing.value = true;
                        },
                        child: con.isPhoneEditing.value == false
                            ? Text(
                                "Edit",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              )
                            : Container(
                                height: 5.h,
                                width: 5.h,
                              ),
                      )),
                  con.isPhoneEditing.value
                      ? Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: PhoneNumberField(
                            hint: "+923341223566",
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 20.h,
                  ),
                  con.isPhoneEditing.value
                      ? Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: GestureDetector(
                            onTap: () {
                              con.isPhoneEditing.value = false;
                            },
                            child: AppButton(
                              text: "Update",
                            ),
                          ),
                        )
                      : Container(),
                  !con.isPhoneEditing.value
                      ? Container()
                      : SizedBox(
                          height: 30.h,
                        ),
                ],
              ),
            ),
            Divider(
              height: 0,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 30.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: 18.sp,
                        ),
                      ),
                      content: Text(
                        "Are you sure you want to logout?",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: new Text(
                            "Yes",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          onPressed: () async {
                            // Navigator.of(context).pop();
                            await AuthRepo().logoutUser();
                            Get.offAllNamed(Routes.LOGIN_SCREEN_ROUTE);
                          },
                        ),
                        TextButton(
                          child: new Text(
                            "No",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: ListTile(
                dense: true,
                title: Text(
                  "Log out",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
