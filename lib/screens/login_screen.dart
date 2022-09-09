import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itp_voice/controllers/login_controller.dart';
import 'package:itp_voice/repo/auth_repo.dart';
import 'package:itp_voice/routes.dart';
import 'package:itp_voice/widgets/app_button.dart';
import 'package:itp_voice/widgets/app_textfield.dart';
import 'package:itp_voice/widgets/custom_loader.dart';
import 'package:itp_voice/widgets/password_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  LoginController con = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/login_background.png"),
              fit: BoxFit.cover),
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
                                "assets/images/itp_white.png",
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
                                      side:
                                          BorderSide(color: Color(0xffC4C4C4)),
                                      // activeColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      checkColor: Colors.white,
                                      fillColor: MaterialStateProperty.all(
                                          Theme.of(context)
                                              .colorScheme
                                              .primary),
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
                    : Container(
                        child: Image.asset("assets/images/itp_white.png")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
