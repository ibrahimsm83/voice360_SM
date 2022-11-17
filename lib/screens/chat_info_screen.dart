import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itp_voice/controllers/chat_info_controller.dart';

import '../app_theme.dart';
import '../widgets/app_button.dart';
import '../widgets/app_textfield.dart';

class ChatInfoScreen extends StatelessWidget {
  ChatInfoScreen({Key? key}) : super(key: key);

  ChatInfoController con = Get.put(ChatInfoController());

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
            child: Icon(Icons.arrow_back_ios, color: AppTheme.colors(context)?.textColor, size: 18.sp),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.only(top: 10.h),
          child: Text(
            "Chat Details",
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Obx(
          () => con.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        textController: con.fullNameController,
                        hint: "Jhon Doe",
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          con.phone,
                          style: TextStyle(
                            color: AppTheme.colors(context)?.textColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          con.initialName.isEmpty ? con.addContact() : con.updateContact();
                        },
                        child: AppButton(
                          text: con.initialName.isEmpty ? "Add Contact" : "Update Contact",
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
