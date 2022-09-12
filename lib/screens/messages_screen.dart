import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itp_voice/controllers/messages_controller.dart';
import 'package:itp_voice/routes.dart';
import 'package:itp_voice/widgets/search_textfield.dart';

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
          : Scaffold(
              floatingActionButton: SizedBox(
                height: 50.h,
                width: 50.h,
                child: FloatingActionButton(
                  onPressed: () {},
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
              body: SingleChildScrollView(
                child: Container(
                    child: Column(
                  children: [
                    Divider(
                      height: 0,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Searchbar(),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.71,
                      child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                          shrinkWrap: true,
                          itemCount: con.threads.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.CHAT_SCREEN_ROUTE,
                                    arguments: con.threads[index]
                                        .participants![0].messageThreadId);
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 5.h),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    spreadRadius: 2,
                                                    blurRadius: 4,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                                shape: BoxShape.circle,
                                              ),
                                              child: Container(
                                                height: 50.h,
                                                width: 50.w,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(
                                                      6,
                                                    ),
                                                  ),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        avatarImages[index]),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            index == 0
                                                ? Positioned(
                                                    bottom: 0,
                                                    right: 0,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(4.h),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.white),
                                                        shape: BoxShape.circle,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                      ),
                                                      child: Text(
                                                        "5",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12.h),
                                                      ),
                                                    ),
                                                  )
                                                : Container()
                                          ],
                                        ),
                                        SizedBox(width: 15.w),
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      con.threads[index]
                                                          .participants!
                                                          .where((element) =>
                                                              element.isSelf !=
                                                              true)
                                                          .toList()[0]
                                                          .number!, //"Mathew Murdock",
                                                      // style: ts(1, 0xff1B1A57, 14.sp, 5),
                                                      style: TextStyle(
                                                        fontWeight: con
                                                                    .threads[
                                                                        index]
                                                                    .threadRead ==
                                                                false
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
                                                    con.threads[index]
                                                            .lastMessage ??
                                                        'Empty chat',
                                                    // style: ts(1, 0xff4F5E7B, 12.sp, 4),
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .tertiary),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ))
                                      ],
                                    ),
                                    Container(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        con.threads[index].lastUpdated!
                                                .split(':')[0]
                                                .substring(con.threads[index]
                                                        .lastUpdated!
                                                        .split(':')[0]
                                                        .length -
                                                    2) +
                                            ':' +
                                            con.threads[index].lastUpdated!
                                                .split(':')[1]
                                                .substring(con.threads[index]
                                                        .lastUpdated!
                                                        .split(':')[1]
                                                        .length -
                                                    2),
                                        style: TextStyle(
                                                fontSize: 13.sp,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary)
                                            .copyWith(
                                                color: con.threads[index]
                                                            .threadRead ==
                                                        false
                                                    ? Color(0xFF242424)
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
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                )),
              ),
            ),
    );
  }
}
