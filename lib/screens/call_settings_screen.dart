import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:itp_voice/controllers/call_settings_controller.dart';
import 'package:itp_voice/widgets/app_textfield.dart';
import 'package:itp_voice/widgets/phone_number_field.dart';

class CallSettingsScreen extends StatelessWidget {
  CallSettingsScreen({Key? key}) : super(key: key);

  CallSettingsController con = Get.put(CallSettingsController());
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
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 18.sp,
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.only(top: 10.h),
          child: Text(
            "Call Settings",
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Divider(
                height: 0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Devices",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Phone abc",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          Text(
                            "Edit",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Divider(),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Enable Call Forwarding",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Obx(() => FlutterSwitch(
                              height: 22.h,
                              width: 50.w,
                              activeColor:
                                  Theme.of(context).colorScheme.primary,
                              padding: 0,
                              value: con.callForwarding.value,
                              onToggle: (val) {
                                con.callForwarding.value = val;
                              },
                            )),
                      ],
                    ),
                    Obx(() => con.callForwarding.value
                        ? Column(
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Number or extension to forward calls to",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              PhoneNumberField(),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Forward Direct Calls\n(Ignore queues, ring groups,etc)",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      // fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                  ),
                                  Obx(() => FlutterSwitch(
                                        height: 22.h,
                                        width: 50.w,
                                        activeColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        padding: 0,
                                        value: con.forwardDirectCallsOnly.value,
                                        onToggle: (val) {
                                          con.forwardDirectCallsOnly.value =
                                              val;
                                        },
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Keep original caller-ID",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      // fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                  ),
                                  Obx(() => FlutterSwitch(
                                        height: 22.h,
                                        width: 50.w,
                                        activeColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        padding: 0,
                                        value: con.keepOriginalCallerId.value,
                                        onToggle: (val) {
                                          con.keepOriginalCallerId.value = val;
                                        },
                                      )),
                                ],
                              ),
                            ],
                          )
                        : Container()),
                    SizedBox(
                      height: 10.h,
                    ),
                    Divider(),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Override Default Caller ID Settings",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Obx(
                          () => FlutterSwitch(
                            height: 22.h,
                            width: 50.w,
                            activeColor: Theme.of(context).colorScheme.primary,
                            padding: 0,
                            value: con.overrideDefaultCallerIdSettings.value,
                            onToggle: (val) {
                              con.overrideDefaultCallerIdSettings.value = val;
                            },
                          ),
                        ),
                      ],
                    ),
                    Obx(
                      (() => con.overrideDefaultCallerIdSettings.value
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20.h,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Caller ID Name",
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
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
                                  height: 5.h,
                                ),
                                AppTextField(
                                  hint: "Jhon Doe",
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Caller ID Number",
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
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
                                  height: 5.h,
                                ),
                                AppTextField(
                                  hint: "923309887878",
                                )
                              ],
                            )
                          : Container()),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Divider(),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Call Recording",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Call Recording Internal",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Theme.of(context).colorScheme.tertiary
                              // fontWeight: FontWeight.bold,
                              ),
                        ),
                        Obx(() => FlutterSwitch(
                              height: 22.h,
                              width: 50.w,
                              activeColor:
                                  Theme.of(context).colorScheme.primary,
                              padding: 0,
                              value: con.callRecordingInternal.value,
                              onToggle: (val) {
                                con.callRecordingInternal.value = val;
                              },
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Call Recording External",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Theme.of(context).colorScheme.tertiary
                              // fontWeight: FontWeight.bold,
                              ),
                        ),
                        Obx(() => FlutterSwitch(
                              height: 22.h,
                              width: 50.w,
                              activeColor:
                                  Theme.of(context).colorScheme.primary,
                              padding: 0,
                              value: con.callRecordingExternal.value,
                              onToggle: (val) {
                                con.callRecordingExternal.value = val;
                              },
                            )),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
