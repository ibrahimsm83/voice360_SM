import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itp_voice/app_theme.dart';
import 'package:itp_voice/controllers/base_screen_controller.dart';
import 'package:itp_voice/controllers/contacts_controller.dart';
import 'package:itp_voice/models/contact_list_data_model.dart';
import 'package:itp_voice/routes.dart';
import 'package:itp_voice/widgets/search_textfield.dart';
import 'package:itp_voice/widgets/text_container.dart';
import 'package:itp_voice/temp_data.dart' as repo;

import '../models/get_contacts_reponse_model/contact_response.dart';

class ContactDetailsScreen extends StatefulWidget {
  ContactDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ContactDetailsScreen> createState() => _ContactDetailsScreenState();
}

class _ContactDetailsScreenState extends State<ContactDetailsScreen> {
  Contact? contact;
  BaseScreenController baseController = Get.find<BaseScreenController>();
  ContactsController con = Get.find<ContactsController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contact = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: con,
        builder: (ContactsController value) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: Container(
                margin: EdgeInsets.only(top: 10.h, left: 15.w),
                child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back_ios, color: AppTheme.colors(context)?.textColor, size: 18.sp)),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      useRootNavigator: true,
                      builder: (context) {
                        return Container(
                          height: 170.h,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(children: [
                            SizedBox(height: 10.h),
                            Divider(
                              color: Colors.grey.shade400,
                              thickness: 3,
                              indent: 140.w,
                              endIndent: 140.w,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Actions",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.secondary),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                // Get.toNamed(Routes.CALL_HISTORY_SCREEN_ROUTE);
                                Get.toNamed(Routes.EDIT_CONTACT_ROUTE, arguments: {'contact': contact});
                              },
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Edit",
                                  style: TextStyle(fontSize: 18.sp, color: Theme.of(context).colorScheme.secondary),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                // Get.toNamed(Routes.CALL_HISTORY_SCREEN_ROUTE);\
                                con.deleteContact(contact!.pk);
                              },
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Delete",
                                  style: TextStyle(fontSize: 18.sp, color: Theme.of(context).colorScheme.secondary),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ]),
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 20.w, top: 10.h),
                    child: Icon(Icons.more_vert, color: Color(0xff6B6F80), size: 22.sp),
                  ),
                )
              ],
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Container(
                padding: EdgeInsets.only(top: 10.h),
                child: Text(
                  "Contact Details",
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
                      child: TextBox(
                        text: contact!.firstname![0].toUpperCase() + contact!.firstname![1].toUpperCase(),
                        height: 100.h,
                        width: 100.h,
                        singleCharFontSize: 30.sp,
                        doubleCharFontSize: 24.sp,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        contact!.firstname!,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Divider(
                      indent: 20.w,
                      endIndent: 20.w,
                    ),
                    ListView.builder(
                      itemCount: 1, //contact!.numbers!.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(
                            contact!.phone ?? '',
                            style: TextStyle(
                              color: AppTheme.colors(context)?.textColor,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          dense: true,
                          trailing: Container(
                            // color: Colors.blue,
                            width: 100.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    baseController.handleCall(contact!.phone!, context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(7.h),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        gradient: LinearGradient(colors: [
                                          Theme.of(context).colorScheme.primary.withOpacity(0.7),
                                          Theme.of(context).colorScheme.primary,
                                        ])),
                                    child: Container(
                                      height: 15.h,
                                      width: 15.h,
                                      child: Image.asset(
                                        'assets/images/dial.png',
                                        height: 12.h,
                                        width: 12.h,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                Container(
                                  padding: EdgeInsets.all(7.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    border: Border.all(
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  child: Container(
                                    height: 15.h,
                                    width: 15.h,
                                    child: Image.asset(
                                      'assets/images/sms.png',
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
