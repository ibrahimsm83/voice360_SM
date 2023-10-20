import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itp_voice/controllers/login_controller.dart';
import 'package:itp_voice/notification_service.dart';
import 'package:itp_voice/repo/auth_repo.dart';
import 'package:itp_voice/routes.dart';
import 'package:itp_voice/widgets/app_button.dart';
import 'package:itp_voice/widgets/app_textfield.dart';
import 'package:itp_voice/widgets/custom_loader.dart';
import 'package:itp_voice/widgets/password_textfield.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController con = Get.put(LoginController());

  @override
  void initState() {
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) async {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          if (message.data != null) {
            final notificationData = message.data;
            if ((notificationData as Map<String, dynamic>).containsKey("message_thread_id")) {
              await Get.toNamed(Routes.CHAT_SCREEN_ROUTE,
                  arguments: [notificationData["message_thread_id"], notificationData["to_phone_number"], null]);
              if (con.initializedd == true) {
                Get.offAllNamed(Routes.BASE_SCREEN_ROUTE);
              }
            }
          }
        }
      },
    );

    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          if (Get.currentRoute == Routes.CHAT_SCREEN_ROUTE) {
          } else {
            LocalNotificationService.createanddisplaynotification(message);
          }
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data}");
          if (message != null) {
            if (message.data != null) {
              final notificationData = message.data;
              if ((notificationData as Map<String, dynamic>).containsKey("message_thread_id")) {
                Get.toNamed(Routes.CHAT_SCREEN_ROUTE,
                    arguments: [notificationData["message_thread_id"], notificationData["to_phone_number"], null]);
              }
            }
          }
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(image: con.showLogin.value?AssetImage("assets/images/login_background.png"):AssetImage("assets/images/dial.png"), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                    () => con.showLogin.value
                    ? Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    margin: EdgeInsets.symmetric(horizontal: 15.w),
                    decoration: BoxDecoration(
                      color: Color(0xff222736),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        Image.asset(
                          "assets/images/logo_white.png",
                          width: 120.w,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Email",
                                  style: TextStyle(
                                    color: Color(0xffA6B0CF),
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
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        AppTextField(
                          textController: con.emailController,
                          hint: "Enter email",
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Password",
                                  style: TextStyle(
                                    color: Color(0xffA6B0CF),
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
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        PasswordTextField(
                          textController: con.passwordController,
                          hint: "Enter password",
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Obx(
                                  () => Checkbox(
                                side: BorderSide(color: Color(0xffC4C4C4)),
                                // activeColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                checkColor: Colors.white,
                                fillColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                                value: con.isRemember.value,
                                onChanged: (v) {
                                  con.isRemember.value = v!;
                                },
                              ),
                            ),
                            Text(
                              "Remember Me",
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Color(0xffA6B0CF),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20.h),
                        GestureDetector(
                          onTap: () {
                            con.login();
                            // AuthRepo().getAllPosts();

                            // Get.toNamed(Routes.BASE_SCREEN_ROUTE);
                            // CustomLoader.showLoader();
                          },
                          child: AppButton(
                            text: "Log In",
                          ),
                        ),
                        SizedBox(height: 50.h),
                      ],
                    ),
                  ),
                )
                    : Container(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Image.asset("assets/images/logo_white.png"),
                )),
              ),
            ],
          ),
        ),
      ))
      ,
    );
  }
}
