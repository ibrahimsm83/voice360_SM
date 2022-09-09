import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itp_voice/controllers/add_new_contact_controller.dart';
import 'package:itp_voice/controllers/settings_controller.dart';
import 'package:itp_voice/routes.dart';
import 'package:itp_voice/widgets/app_button.dart';
import 'package:itp_voice/widgets/app_textfield.dart';
import 'package:itp_voice/widgets/phone_number_field.dart';

class AddNewContactScreen extends StatelessWidget {
  AddNewContactScreen({Key? key}) : super(key: key);

  AddNewContactController con = Get.put(AddNewContactController());

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
            "Add New Contact",
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
              SizedBox(
                height: 20.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Full Name",
                            style: TextStyle(
                              color: Colors.black,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Phone Number",
                                style: TextStyle(
                                  color: Colors.black,
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
                        GestureDetector(
                          onTap: () {
                            con.addNewContactField();
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add,
                                size: 18.sp,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              Text(
                                "Add another",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 14.sp,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    GetBuilder<AddNewContactController>(
                        init: con,
                        builder: (AddNewContactController value) {
                          return ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.symmetric(vertical: 5.h),
                              );
                            },
                            shrinkWrap: true,
                            itemCount: value.contactFieldsData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      PhoneNumberField(
                                        textController:
                                            value.contactFieldsData[index]
                                                ['controller'],
                                        hint: "xxx xxxxxxxx",
                                        onChanged: (val) {
                                          value.contactFieldsData[index]
                                              ['code'] = val;
                                          // print("Vaule " + value);
                                        },
                                      ),
                                      index == 0
                                          ? Container()
                                          : Positioned(
                                              right: 0,
                                              child: GestureDetector(
                                                onTap: () {
                                                  value.removeContactField(
                                                      index);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(2.h),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                                  child: Icon(
                                                    Icons.close,
                                                    size: 15.sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                  Container(
                                    // height: 30.h,
                                    child: ChipsChoice<int>.single(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 0.h),
                                      choiceActiveStyle: C2ChoiceStyle(
                                        borderWidth: 0,
                                        showCheckmark: false,
                                        labelPadding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 01,
                                        ),
                                        margin: EdgeInsets.zero,
                                        labelStyle: TextStyle(
                                          fontSize: 14.sp,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        borderColor: Colors.transparent,
                                        color: Colors.white,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 2.w,
                                          vertical: 0.002,
                                        ),
                                        backgroundColor: Colors.transparent,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(500)),
                                      ),
                                      alignment: WrapAlignment.start,
                                      choiceStyle: C2ChoiceStyle(
                                        borderWidth: 0,
                                        showCheckmark: false,
                                        labelPadding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 0.001,
                                        ),
                                        labelStyle: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.black),
                                        borderColor: Colors.transparent,
                                        color: Colors.white,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 2.w,
                                          vertical: 0.002,
                                        ),
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .tertiary
                                            .withOpacity(0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(500)),
                                      ),
                                      wrapped: true,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      value: value.contactFieldsData[index]
                                          ['selectedLabel'],
                                      onChanged: (val) {
                                        value.contactFieldsData[index]
                                            ['selectedLabel'] = val;
                                        value.update();
                                      },
                                      choiceItems:
                                          C2Choice.listFrom<int, String>(
                                        source: value.contactFieldsData[index]
                                            ['labelOptions'],
                                        value: (i, v) => i,
                                        label: (i, v) => v,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                ],
                              );
                            },
                          );
                        }),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Email",
                                style: TextStyle(
                                  color: Colors.black,
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
                        GestureDetector(
                          onTap: () {
                            con.addNewEmailField();
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add,
                                size: 18.sp,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              Text(
                                "Add another",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 14.sp,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    GetBuilder<AddNewContactController>(
                        init: con,
                        builder: (AddNewContactController value) {
                          return ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.symmetric(vertical: 5.h),
                              );
                            },
                            shrinkWrap: true,
                            itemCount: value.emailFieldsData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      AppTextField(
                                        hint: "john@abc.com",
                                        textController:
                                            value.emailFieldsData[index]
                                                ['controller'],
                                      ),
                                      index == 0
                                          ? Container()
                                          : Positioned(
                                              right: 0,
                                              child: GestureDetector(
                                                onTap: () {
                                                  con.removeEmailField(index);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(2.h),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                                  child: Icon(
                                                    Icons.close,
                                                    size: 15.sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                  Container(
                                    // height: 30.h,
                                    child: ChipsChoice<int>.single(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 0.h),
                                      choiceActiveStyle: C2ChoiceStyle(
                                        borderWidth: 0,
                                        showCheckmark: false,
                                        labelPadding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 01,
                                        ),
                                        margin: EdgeInsets.zero,
                                        labelStyle: TextStyle(
                                          fontSize: 14.sp,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        borderColor: Colors.transparent,
                                        color: Colors.white,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 2.w,
                                          vertical: 0.002,
                                        ),
                                        backgroundColor: Colors.transparent,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(500)),
                                      ),
                                      alignment: WrapAlignment.start,
                                      choiceStyle: C2ChoiceStyle(
                                        borderWidth: 0,
                                        showCheckmark: false,
                                        labelPadding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 0.001,
                                        ),
                                        labelStyle: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.black),
                                        borderColor: Colors.transparent,
                                        color: Colors.white,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 2.w,
                                          vertical: 0.002,
                                        ),
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .tertiary
                                            .withOpacity(0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(500)),
                                      ),
                                      wrapped: true,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      value: value.emailFieldsData[index]
                                          ['selectedLabel'],
                                      onChanged: (val) {
                                        value.emailFieldsData[index]
                                            ['selectedLabel'] = val;
                                        value.update();
                                      },
                                      choiceItems:
                                          C2Choice.listFrom<int, String>(
                                        source: value.emailFieldsData[index]
                                            ['labelOptions'],
                                        value: (i, v) => i,
                                        label: (i, v) => v,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                ],
                              );
                            },
                          );
                        }),
                    SizedBox(
                      height: 40.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        con.saveContact();
                      },
                      child: AppButton(
                        text: "Save",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
