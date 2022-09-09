import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itp_voice/controllers/base_screen_controller.dart';
import 'package:itp_voice/screens/contacts_screen.dart';
import 'package:itp_voice/screens/home_screen.dart';
import 'package:itp_voice/screens/messages_screen.dart';
import 'package:itp_voice/screens/profile_screen.dart';
import 'package:itp_voice/screens/voice_mail_screen.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({Key? key}) : super(key: key);
  BaseScreenController con = Get.put(BaseScreenController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Color(0xff222736),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              child: Obx(
                () => BottomNavigationBar(
                  onTap: (index) {
                    con.updateCurrentTab(index);
                  },
                  currentIndex: con.currentTab.value,
                  type: BottomNavigationBarType.fixed,
                  iconSize: 20.sp,
                  selectedItemColor: Theme.of(context).colorScheme.primary,
                  unselectedItemColor: Color(0xffA6B0CF),
                  selectedLabelStyle: TextStyle(
                    fontSize: 12.sp,
                  ),
                  unselectedLabelStyle:
                      TextStyle(fontSize: 12.sp, color: Colors.blue),
                  backgroundColor: Color(0xff222736),
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/images/home.png",
                        height: 23.sp,
                        width: 23.sp,
                        color: con.currentTab.value == 0
                            ? Theme.of(context).colorScheme.primary
                            : Color(0xffA6B0CF),
                      ),
                      label: ('Home'),
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/images/contacts.png",
                        height: 23.sp,
                        width: 23.sp,
                        color: con.currentTab.value == 1
                            ? Theme.of(context).colorScheme.primary
                            : Color(0xffA6B0CF),
                      ),
                      label: ('Contacts'),
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/images/messages.png",
                        height: 23.sp,
                        width: 23.sp,
                        color: con.currentTab.value == 2
                            ? Theme.of(context).colorScheme.primary
                            : Color(0xffA6B0CF),
                      ),
                      label: ('Messages'),
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/images/voice_mail.png",
                        height: 23.sp,
                        width: 23.sp,
                        color: con.currentTab.value == 3
                            ? Theme.of(context).colorScheme.primary
                            : Color(0xffA6B0CF),
                      ),
                      label: ('Voicemail'),
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/images/profile.png",
                        height: 23.sp,
                        width: 23.sp,
                        color: con.currentTab.value == 4
                            ? Theme.of(context).colorScheme.primary
                            : Color(0xffA6B0CF),
                      ),
                      label: ('Profile'),
                    ),
                  ],
                ),
              ))),
      body: Obx(() => con.currentTab.value == 0
          ? HomeScreen()
          : con.currentTab.value == 2
              ? MessagesScreen()
              : con.currentTab.value == 3
                  ? VoiceMailScreen()
                  : con.currentTab.value == 1
                      ? ContactsScreen()
                      : ProfileScreen()),
    ));
  }
}
