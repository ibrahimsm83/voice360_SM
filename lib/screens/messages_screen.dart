import 'package:floating_bottom_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itp_voice/app_theme.dart';
import 'package:itp_voice/controllers/messages_controller.dart';
import 'package:itp_voice/models/get_message_threads_response_model/get_message_threads_response_model.dart';
import 'package:itp_voice/repo/shares_preference_repo.dart';
import 'package:itp_voice/routes.dart';
import 'package:itp_voice/storage_keys.dart';
import 'package:itp_voice/widgets/search_textfield.dart';
import 'package:timezone/timezone.dart';

List avatarImages = [
  "https://i.imgur.com/Fur0AUt.png",
  "https://i.imgur.com/kL7WMgG.png",
  "https://i.imgur.com/Bwf87Tv.png",
  "https://i.imgur.com/Fur0AUt.png",
  "https://i.imgur.com/kL7WMgG.png",
  "https://i.imgur.com/Bwf87Tv.png",
  "https://i.imgur.com/Fur0AUt.png",
  "https://i.imgur.com/kL7WMgG.png",
  "https://i.imgur.com/Bwf87Tv.png",
  "https://i.imgur.com/Fur0AUt.png",
  "https://i.imgur.com/kL7WMgG.png",
  "https://i.imgur.com/Bwf87Tv.png",
];

class MessagesScreen extends StatelessWidget {
  MessagesScreen({Key? key}) : super(key: key);

  MessagesController con = Get.put(MessagesController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => con.isloading.value == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : DefaultTabController(
              length: 2,
              child: Scaffold(
                floatingActionButton: SizedBox(
                  height: 50.h,
                  width: 50.h,
                  child: FloatingActionButton(
                    onPressed: () {
                      con.sendNewMessage(context);
                    },
                    child: Container(
                      height: 50.h,
                      width: 50.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Theme.of(context).colorScheme.primary.withOpacity(0.7),
                          Theme.of(context).colorScheme.primary,
                        ]),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                  ),
                ),
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  title: Container(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Text(
                      "Chats",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                body: Column(
                  children: [
                    Divider(
                      height: 0,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Searchbar(
                      controller: con.searchController,
                      onChanged: (text) {
                        con.filterThreads();
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "My Number",
                            style: TextStyle(fontSize: 17),
                          ),
                          Spacer(),
                          DropdownButton<String>(
                            value: con.selectedNumber,
                            hint: const Text('-'),
                            items: List.generate(
                              con.numbers.length,
                              (index) => DropdownMenuItem(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    con.numbers[index],
                                  ),
                                ),
                                value: con.numbers[index],
                              ),
                            ),
                            onChanged: (text) {
                              con.selectedNumber = text;
                              con.loadThreads();
                            },
                          ),
                        ],
                      ),
                    ),
                    TabBar(
                      tabs: [
                        Tab(
                          text: 'All',
                        ),
                        Tab(
                          text: 'Unread',
                        )
                      ],
                      labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                      labelColor: Theme.of(context).colorScheme.primary,
                      unselectedLabelColor: Theme.of(context).colorScheme.tertiary,
                      indicatorColor: Theme.of(context).colorScheme.primary,
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          ListView.separated(
                              primary: false,
                              padding: const EdgeInsets.only(bottom: 10, top: 10),
                              separatorBuilder: (context, index) {
                                return Divider();
                              },
                              shrinkWrap: true,
                              itemCount: con.threads.length,
                              itemBuilder: (context, index) {
                                print(con.threads.length);
                                String? _timeZone = SharedPreferencesMethod.getString(StorageKeys.TIME_ZONE);
                                final zone = getLocation(_timeZone ?? '');
                                final time = TZDateTime.from(DateTime.parse(con.threads[index].lastUpdated!), zone);
                                return con.threads[index].participants!
                                        .where((element) => element.isSelf != true)
                                        .toList()
                                        .isEmpty
                                    ? const SizedBox.shrink()
                                    : GestureDetector(
                                        onTap: () async {
                                          await Get.toNamed(Routes.CHAT_SCREEN_ROUTE, arguments: [
                                            con.threads[index].participants![0].messageThreadId,
                                            con.selectedNumber,
                                            con.threads[index].participants
                                                ?.firstWhere((participant) => participant.isSelf == false)
                                                .number,
                                          ]);
                                          con.onInit();
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Stack(
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets.all(2.h),
                                                        alignment: Alignment.topCenter,
                                                        decoration: BoxDecoration(
                                                          color: Colors.grey,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.black.withOpacity(0.1),
                                                              spreadRadius: 2,
                                                              blurRadius: 4,
                                                              offset: Offset(0, 3), // changes position of shadow
                                                            ),
                                                          ],
                                                          shape: BoxShape.circle,
                                                        ),
                                                        child: Container(
                                                          height: 50.h,
                                                          width: 50.w,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.all(
                                                              Radius.circular(
                                                                6,
                                                              ),
                                                            ),
                                                            // image: DecorationImage(
                                                            //   image: AssetImage('assets/images/profile.png'),
                                                            //   fit: BoxFit.cover,
                                                            // ),
                                                          ),
                                                          child: Icon(
                                                            Icons.person,
                                                            size: 30,
                                                          ),
                                                        ),
                                                      ),
                                                      // index == 0
                                                      //     ? Positioned(
                                                      //         bottom: 0,
                                                      //         right: 0,
                                                      //         child: Container(
                                                      //           padding: EdgeInsets.all(4.h),
                                                      //           decoration: BoxDecoration(
                                                      //             border: Border.all(color: Colors.white),
                                                      //             shape: BoxShape.circle,
                                                      //             color: Theme.of(context).colorScheme.primary,
                                                      //           ),
                                                      //           child: Text(
                                                      //             "5",
                                                      //             style: TextStyle(color: Colors.white, fontSize: 12.h),
                                                      //           ),
                                                      //         ),
                                                      //       )
                                                      //     : Container()
                                                    ],
                                                  ),
                                                  SizedBox(width: 15.w),
                                                  Container(
                                                      alignment: Alignment.centerLeft,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                con.threads[index].participants!
                                                                    .where((element) => element.isSelf != true)
                                                                    .toList()[0]
                                                                    .number!, //"Mathew Murdock",
                                                                // style: ts(1, 0xff1B1A57, 14.sp, 5),
                                                                style: TextStyle(
                                                                  fontWeight: con.threads[index].threadRead == false
                                                                      ? FontWeight.w600
                                                                      : FontWeight.w400,
                                                                  fontSize: 15.sp,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 5.w,
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 3.h),
                                                          Container(
                                                            width: 215.w,
                                                            child: Text(
                                                              con.threads[index].lastMessage ?? 'Empty chat',
                                                              // style: ts(1, 0xff4F5E7B, 12.sp, 4),
                                                              style: TextStyle(
                                                                  fontSize: 13.sp,
                                                                  color: Theme.of(context).colorScheme.tertiary),
                                                              maxLines: 2,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ))
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    alignment: Alignment.topCenter,
                                                    child: Text(
                                                      time.hour.toString().padLeft(2, "0") +
                                                          ':' +
                                                          time.minute.toString().padLeft(2, "0"),
                                                      style: TextStyle(
                                                              fontSize: 13.sp,
                                                              color: Theme.of(context).colorScheme.tertiary)
                                                          .copyWith(
                                                              fontWeight: con.threads[index].threadRead == false
                                                                  ? FontWeight.w600
                                                                  : FontWeight.normal),
                                                      // ((index == 0 || index == 1 || index == 2)
                                                      //         ? "${DateFormat('hh:mm').format(DateTime.now())}"
                                                      //         : (index == 3 || index == 4)
                                                      //             ? "Yesterday"
                                                      //             : (index == 5)
                                                      //                 ? "2 days ago"
                                                      //                 : "Sat 9 March") +
                                                      //     "",
                                                    ),
                                                  ),
                                                  Opacity(
                                                    opacity: con.threads[index].unreadMessages! > 0 ? 1 : 0,
                                                    child: Container(
                                                      width: 20,
                                                      height: 20,
                                                      alignment: Alignment.center,
                                                      margin: const EdgeInsets.only(top: 5),
                                                      decoration: BoxDecoration(
                                                        color: con.threads[index].unreadMessages! > 0
                                                            ? Theme.of(context).colorScheme.primary
                                                            : Colors.transparent,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Text(
                                                        con.threads[index].unreadMessages! > 99
                                                            ? '99'
                                                            : con.threads[index].unreadMessages!.toString(),
                                                        style: TextStyle(fontSize: 13.sp, color: AppColors.white),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                              }),
                          ListView.separated(
                              primary: false,
                              padding: const EdgeInsets.only(bottom: 10, top: 10),
                              separatorBuilder: (context, index) {
                                return Divider();
                              },
                              shrinkWrap: true,
                              itemCount: con.threads.where((element) => element.threadRead == false).toList().length,
                              itemBuilder: (context, index) {
                                String? _timeZone = SharedPreferencesMethod.getString(StorageKeys.TIME_ZONE);
                                final zone = getLocation(_timeZone ?? '');
                                MessageThreads item =
                                    con.threads.where((element) => element.threadRead == false).toList()[index];
                                final time = TZDateTime.from(DateTime.parse(item.lastUpdated!), zone);

                                return item.participants!.where((element) => element.isSelf != true).toList().isEmpty
                                    ? const SizedBox.shrink()
                                    : GestureDetector(
                                        onTap: () {
                                          Get.toNamed(Routes.CHAT_SCREEN_ROUTE, arguments: [
                                            item.participants![0].messageThreadId,
                                            con.selectedNumber,
                                            item.participants
                                                ?.firstWhere((participant) => participant.isSelf == false)
                                                .number,
                                          ]);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Stack(
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets.all(2.h),
                                                        alignment: Alignment.topCenter,
                                                        decoration: BoxDecoration(
                                                          color: Colors.grey,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.black.withOpacity(0.1),
                                                              spreadRadius: 2,
                                                              blurRadius: 4,
                                                              offset: Offset(0, 3), // changes position of shadow
                                                            ),
                                                          ],
                                                          shape: BoxShape.circle,
                                                        ),
                                                        child: Container(
                                                          height: 50.h,
                                                          width: 50.w,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.all(
                                                              Radius.circular(
                                                                6,
                                                              ),
                                                            ),
                                                            // image: DecorationImage(
                                                            //   image: AssetImage('assets/images/profile.png'),
                                                            //   fit: BoxFit.cover,
                                                            // ),
                                                          ),
                                                          child: Icon(
                                                            Icons.person,
                                                            size: 30,
                                                          ),
                                                        ),
                                                      ),
                                                      // index == 0
                                                      //     ? Positioned(
                                                      //         bottom: 0,
                                                      //         right: 0,
                                                      //         child: Container(
                                                      //           padding: EdgeInsets.all(4.h),
                                                      //           decoration: BoxDecoration(
                                                      //             border: Border.all(color: Colors.white),
                                                      //             shape: BoxShape.circle,
                                                      //             color: Theme.of(context).colorScheme.primary,
                                                      //           ),
                                                      //           child: Text(
                                                      //             "5",
                                                      //             style: TextStyle(color: Colors.white, fontSize: 12.h),
                                                      //           ),
                                                      //         ),
                                                      //       )
                                                      //     : Container()
                                                    ],
                                                  ),
                                                  SizedBox(width: 15.w),
                                                  Container(
                                                      alignment: Alignment.centerLeft,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                item.participants!
                                                                    .where((element) => element.isSelf != true)
                                                                    .toList()[0]
                                                                    .number!, //"Mathew Murdock",
                                                                // style: ts(1, 0xff1B1A57, 14.sp, 5),
                                                                style: TextStyle(
                                                                  fontWeight: item.threadRead == false
                                                                      ? FontWeight.w600
                                                                      : FontWeight.w400,
                                                                  fontSize: 15.sp,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 5.w,
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 3.h),
                                                          Container(
                                                            width: 215.w,
                                                            child: Text(
                                                              item.lastMessage ?? 'Empty chat',
                                                              // style: ts(1, 0xff4F5E7B, 12.sp, 4),
                                                              style: TextStyle(
                                                                  fontSize: 13.sp,
                                                                  color: Theme.of(context).colorScheme.tertiary),
                                                              maxLines: 2,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ))
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    alignment: Alignment.topCenter,
                                                    child: Text(
                                                      time.hour.toString().padLeft(2, "0") +
                                                          ':' +
                                                          time.minute.toString().padLeft(2, "0"),
                                                      style: TextStyle(
                                                              fontSize: 13.sp,
                                                              color: Theme.of(context).colorScheme.tertiary)
                                                          .copyWith(
                                                              color: item.threadRead == false
                                                                  ? AppTheme.colors(context)?.textColor
                                                                  : Color(0xFF6B6F80)),
                                                      // ((index == 0 || index == 1 || index == 2)
                                                      //         ? "${DateFormat('hh:mm').format(DateTime.now())}"
                                                      //         : (index == 3 || index == 4)
                                                      //             ? "Yesterday"
                                                      //             : (index == 5)
                                                      //                 ? "2 days ago"
                                                      //                 : "Sat 9 March") +
                                                      //     "",
                                                    ),
                                                  ),
                                                  Opacity(
                                                    opacity: item.unreadMessages! > 0 ? 1 : 0,
                                                    child: Container(
                                                      width: 20,
                                                      height: 20,
                                                      alignment: Alignment.center,
                                                      margin: const EdgeInsets.only(top: 5),
                                                      decoration: BoxDecoration(
                                                        color: item.unreadMessages! > 0
                                                            ? Theme.of(context).colorScheme.primary
                                                            : Colors.transparent,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Text(
                                                        item.unreadMessages! > 99
                                                            ? '99'
                                                            : item.unreadMessages!.toString(),
                                                        style: TextStyle(fontSize: 13.sp, color: AppColors.white),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                              }),
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
