import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itp_voice/app_theme.dart';
import 'package:itp_voice/controllers/base_screen_controller.dart';
import 'package:itp_voice/controllers/call_history_controller.dart';
import 'package:itp_voice/routes.dart';
import 'package:itp_voice/widgets/call_history_shimmer.dart';
import 'package:itp_voice/widgets/search_textfield.dart';
import 'package:itp_voice/widgets/text_container.dart';
import 'package:itp_voice/temp_data.dart' as repo;

class CallHistoryScreen extends StatefulWidget {
  CallHistoryScreen({Key? key}) : super(key: key);

  @override
  State<CallHistoryScreen> createState() => _CallHistoryScreenState();
}

class _CallHistoryScreenState extends State<CallHistoryScreen> {
  CallHistoryController con = Get.put(CallHistoryController());
  BaseScreenController baseController = Get.find<BaseScreenController>();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: con,
        builder: (CallHistoryController value) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                // leading: Container(
                //   margin: EdgeInsets.only(top: 10.h, left: 0.w),
                //   child: GestureDetector(
                //       onTap: () {
                //         Get.back();
                //       },
                //       child: Icon(Icons.arrow_back_ios, color: AppTheme.colors(context)?.textColor, size: 18.sp)),
                // ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        useRootNavigator: true,
                        builder: (context) {
                          return Container(
                            height: 120.h,
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
                                  Get.toNamed(Routes.CALL_HISTORY_SCREEN_ROUTE);
                                },
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Clear Call History",
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
                      child: Icon(Icons.more_vert, color: const Color(0xff6B6F80), size: 22.sp),
                    ),
                  )
                ],
                elevation: 0,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                title: Container(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Text(
                    "Call History",
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
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Divider(
                    height: 0,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Searchbar(
                    controller: value.searchController,
                    onChanged: (val) {
                      value.update();
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TabBar(
                    labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
                    labelColor: Theme.of(context).colorScheme.primary,
                    isScrollable: true, // add this property
                    unselectedLabelColor: const Color(0xff838799),
                    indicatorColor: Theme.of(context).colorScheme.primary,
                    indicatorSize: TabBarIndicatorSize.label,

                    indicatorPadding: EdgeInsets.only(bottom: 10.h),
                    labelStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
                    tabs: [
                      const Tab(
                        text: 'All',
                      ),
                      const Tab(
                        text: 'Missed',
                      ),
                    ],
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.63,
                      child: TabBarView(children: [

                        SingleChildScrollView(
                                controller: con.scrollController,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    value.todayCallHistory.length < 1
                                        ? Container()
                                        : Column(
                                            children: [
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                                child: Align(
                                                  child: Text(
                                                    "Today",
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w600,
                                                      color: AppTheme.colors(context)?.textColor,
                                                    ),
                                                  ),
                                                  alignment: Alignment.centerLeft,
                                                ),
                                              ),
                                              ListView.builder(
                                                physics: const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: value.getDataList("today", false).length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  return Container(
                                                    child: ListTile(
                                                      dense: true,
                                                      leading: TextBox(
                                                        text: value.getDataList("today", false)[index].name!.length == 3
                                                            ? value
                                                                .getDataList("today", false)[index]
                                                                .name!
                                                                .substring(0, 3)
                                                            : value.getDataList("today", false)[index].name!.length == 2
                                                                ? value
                                                                    .getDataList("today", false)[index]
                                                                    .name!
                                                                    .substring(0, 1)
                                                                : value.getDataList("today", false)[index].name![0],
                                                      ),
                                                      subtitle: Container(
                                                        margin: EdgeInsets.only(top: 5.h),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              child: Image.asset(
                                                                value.getDataList("today", false)[index].isIncoming! &&
                                                                        value
                                                                            .getDataList("today", false)[index]
                                                                            .isMissed!
                                                                    ? "assets/images/missed_call.png"
                                                                    : value
                                                                                .getDataList("today", false)[index]
                                                                                .isIncoming! &&
                                                                            !value
                                                                                .getDataList("today", false)[index]
                                                                                .isMissed!
                                                                        ? "assets/images/incoming_call.png"
                                                                        : "assets/images/outgoing_call.png", //                                                                    // fit: BoxFit.fill,
                                                                scale: 4.2,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10.w,
                                                            ),
                                                            Text(
                                                              DateFormat.MMMEd()
                                                                  .add_jm()
                                                                  .format(
                                                                      value.getDataList("today", false)[index].time!)
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 14.sp,
                                                                color: Theme.of(context).colorScheme.tertiary,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      trailing: GestureDetector(
                                                        onTap: () {
                                                          baseController.handleCall(
                                                              value.getDataList("today", false)[index].numberToDial,
                                                              context);
                                                        },
                                                        child: Container(
                                                          child: Image.asset(
                                                            'assets/images/dial.png',
                                                            color: AppTheme.colors(context)?.textColor,
                                                            height: 17.h,
                                                          ),
                                                        ),
                                                      ),
                                                      title: Text(
                                                        value.getDataList("today", false)[index].name!,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 15.sp,
                                                            overflow: TextOverflow.ellipsis),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                    value.getDataList("yesterday", false).length < 1
                                        ? Container()
                                        : Column(
                                            children: [
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                                child: Align(
                                                  child: Text(
                                                    "Yesterday",
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w600,
                                                      color: AppTheme.colors(context)?.textColor,
                                                    ),
                                                  ),
                                                  alignment: Alignment.centerLeft,
                                                ),
                                              ),
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemCount: value.getDataList("yesterday", false).length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  return Container(
                                                    child: ListTile(
                                                      dense: true,
                                                      leading: TextBox(
                                                        text: value
                                                                    .getDataList("yesterday", false)[index]
                                                                    .name!
                                                                    .length ==
                                                                3
                                                            ? value
                                                                .getDataList("yesterday", false)[index]
                                                                .name!
                                                                .substring(0, 3)
                                                            : value
                                                                        .getDataList("yesterday", false)[index]
                                                                        .name!
                                                                        .length ==
                                                                    2
                                                                ? value
                                                                    .getDataList("yesterday", false)[index]
                                                                    .name!
                                                                    .substring(0, 1)
                                                                : value.getDataList("yesterday", false)[index].name![0],
                                                      ),
                                                      subtitle: Container(
                                                        margin: EdgeInsets.only(top: 5.h),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              child: Image.asset(
                                                                value
                                                                            .getDataList("yesterday", false)[index]
                                                                            .isIncoming! &&
                                                                        value
                                                                            .getDataList("yesterday", false)[index]
                                                                            .isMissed!
                                                                    ? "assets/images/missed_call.png"
                                                                    : value
                                                                                .getDataList("yesterday", false)[index]
                                                                                .isIncoming! &&
                                                                            !value
                                                                                .getDataList("yesterday", false)[index]
                                                                                .isMissed!
                                                                        ? "assets/images/incoming_call.png"
                                                                        : "assets/images/outgoing_call.png", // fit: BoxFit.fill,
                                                                scale: 4.2,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10.w,
                                                            ),
                                                            Text(
                                                              DateFormat.MMMEd()
                                                                  .add_jm()
                                                                  .format(value
                                                                      .getDataList("yesterday", false)[index]
                                                                      .time!)
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 14.sp,
                                                                color: Theme.of(context).colorScheme.tertiary,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      trailing: GestureDetector(
                                                        onTap: () {
                                                          baseController.handleCall(
                                                              value.getDataList("yesterday", false)[index].numberToDial,
                                                              context);
                                                        },
                                                        child: Container(
                                                          child: Image.asset(
                                                            'assets/images/dial.png',
                                                            color: AppTheme.colors(context)?.textColor,
                                                            height: 17.h,
                                                          ),
                                                        ),
                                                      ),
                                                      title: Text(
                                                        value.getDataList("yesterday", false)[index].name!,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 15.sp,
                                                            overflow: TextOverflow.ellipsis),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                    value.getDataList("earlier", false).length < 1
                                        ? Container()
                                        : Column(
                                            children: [
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                                child: Align(
                                                  child: Text(
                                                    "Earlier",
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  alignment: Alignment.centerLeft,
                                                ),
                                              ),
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemCount: value.getDataList("earlier", false).length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  return Container(
                                                    child: ListTile(
                                                      dense: true,
                                                      leading: TextBox(
                                                        text: value.getDataList("earlier", false)[index].name?.length == 3
                                                            ? value.getDataList("earlier", false)[index].name!.substring(0, 3)
                                                            : value.getDataList("earlier", false)[index].name?.length == 2
                                                            ? value.getDataList("earlier", false)[index].name!.substring(0, 1)
                                                            : value.getDataList("earlier", false)[index].name?.substring(0, 1) ?? '',
                                                      ),
                                                      subtitle: Container(
                                                        margin: EdgeInsets.only(top: 5.h),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              child: Image.asset(
                                                                // 'assets/images/${repo.allCallHistory['Today'][index]['type']}_call.png',
                                                                value
                                                                            .getDataList("earlier", false)[index]
                                                                            .isIncoming! &&
                                                                        value
                                                                            .getDataList("earlier", false)[index]
                                                                            .isMissed!
                                                                    ? "assets/images/missed_call.png"
                                                                    : value
                                                                                .getDataList("earlier", false)[index]
                                                                                .isIncoming! &&
                                                                            !value
                                                                                .getDataList("earlier", false)[index]
                                                                                .isMissed!
                                                                        ? "assets/images/incoming_call.png"
                                                                        : "assets/images/outgoing_call.png",
                                                                // fit: BoxFit.fill,
                                                                scale: 4.2,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10.w,
                                                            ),
                                                            Text(
                                                              DateFormat.MMMEd()
                                                                  .add_jm()
                                                                  .format(
                                                                      value.getDataList("earlier", false)[index].time!)
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 14.sp,
                                                                color: Theme.of(context).colorScheme.tertiary,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      trailing: GestureDetector(
                                                        onTap: () {
                                                          baseController.handleCall(
                                                              value.getDataList("earlier", false)[index].numberToDial,
                                                              context);
                                                        },
                                                        child: Container(
                                                          child: Image.asset(
                                                            'assets/images/dial.png',
                                                            color: Colors.black,
                                                            height: 17.h,
                                                          ),
                                                        ),
                                                      ),
                                                      title: Text(
                                                        value.getDataList("earlier", false)[index].name??"",
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 15.sp,
                                                            overflow: TextOverflow.ellipsis),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                    value.isLoading ?const SizedBox(height:20 ,):const SizedBox(),
                                    value.isLoading ? const CircularProgressIndicator():const SizedBox(),
                                    value.isLoading ?const SizedBox(height:15,):const SizedBox(),
                                  ],
                                ),
                              ),
                        SingleChildScrollView(
                                child: Column(
                                  children: [
                                    value.getDataList("today", true).length < 1
                                        ? Container()
                                        : Column(
                                            children: [
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                                child: Align(
                                                  child: Text(
                                                    "Today",
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  alignment: Alignment.centerLeft,
                                                ),
                                              ),
                                              ListView.builder(
                                                physics: const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: value.getDataList("today", true).length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  return Container(
                                                    child: ListTile(
                                                      dense: true,
                                                      leading: TextBox(
                                                        text: value.getDataList("today", true)[index].name!.length == 3
                                                            ? value
                                                                .getDataList("today", true)[index]
                                                                .name!
                                                                .substring(0, 3)
                                                            : value.getDataList("today", true)[index].name!.length == 2
                                                                ? value
                                                                    .getDataList("today", true)[index]
                                                                    .name!
                                                                    .substring(0, 1)
                                                                : value.getDataList("today", true)[index].name![0],
                                                      ),
                                                      subtitle: Container(
                                                        margin: EdgeInsets.only(top: 5.h),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              child: Image.asset(
                                                                value.getDataList("today", true)[index].isIncoming! &&
                                                                        value
                                                                            .getDataList("today", true)[index]
                                                                            .isMissed!
                                                                    ? "assets/images/missed_call.png"
                                                                    : value
                                                                                .getDataList("today", true)[index]
                                                                                .isIncoming! &&
                                                                            !value
                                                                                .getDataList("today", true)[index]
                                                                                .isMissed!
                                                                        ? "assets/images/incoming_call.png"
                                                                        : "assets/images/outgoing_call.png", //                                                                    // fit: BoxFit.fill,
                                                                scale: 4.2,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10.w,
                                                            ),
                                                            Text(
                                                              DateFormat.MMMEd()
                                                                  .add_jm()
                                                                  .format(value.getDataList("today", true)[index].time!)
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 14.sp,
                                                                color: Theme.of(context).colorScheme.tertiary,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      trailing: GestureDetector(
                                                        onTap: () {
                                                          baseController.handleCall(
                                                              value.getDataList("today", true)[index].numberToDial,
                                                              context);
                                                        },
                                                        child: Container(
                                                          child: Image.asset(
                                                            'assets/images/dial.png',
                                                            color: Colors.black,
                                                            height: 17.h,
                                                          ),
                                                        ),
                                                      ),
                                                      title: Text(
                                                        value.getDataList("today", true)[index].name!,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 15.sp,
                                                            overflow: TextOverflow.ellipsis),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                    value.getDataList("yesterday", true).length < 1
                                        ? Container()
                                        : Column(
                                            children: [
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                                child: Align(
                                                  child: Text(
                                                    "Yesterday",
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  alignment: Alignment.centerLeft,
                                                ),
                                              ),
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemCount: value.getDataList("yesterday", true).length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  return Container(
                                                    child: ListTile(
                                                      dense: true,
                                                      leading: TextBox(
                                                        text: value
                                                                    .getDataList("yesterday", true)[index]
                                                                    .name!
                                                                    .length ==
                                                                3
                                                            ? value
                                                                .getDataList("yesterday", true)[index]
                                                                .name!
                                                                .substring(0, 3)
                                                            : value
                                                                        .getDataList("yesterday", true)[index]
                                                                        .name!
                                                                        .length ==
                                                                    2
                                                                ? value
                                                                    .getDataList("yesterday", true)[index]
                                                                    .name!
                                                                    .substring(0, 1)
                                                                : value.getDataList("yesterday", true)[index].name![0],
                                                      ),
                                                      subtitle: Container(
                                                        margin: EdgeInsets.only(top: 5.h),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              child: Image.asset(
                                                                value
                                                                            .getDataList("yesterday", true)[index]
                                                                            .isIncoming! &&
                                                                        value
                                                                            .getDataList("yesterday", true)[index]
                                                                            .isMissed!
                                                                    ? "assets/images/missed_call.png"
                                                                    : value
                                                                                .getDataList("yesterday", true)[index]
                                                                                .isIncoming! &&
                                                                            !value
                                                                                .getDataList("yesterday", true)[index]
                                                                                .isMissed!
                                                                        ? "assets/images/incoming_call.png"
                                                                        : "assets/images/outgoing_call.png", // fit: BoxFit.fill,
                                                                scale: 4.2,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10.w,
                                                            ),
                                                            Text(
                                                              DateFormat.MMMEd()
                                                                  .add_jm()
                                                                  .format(
                                                                      value.getDataList("yesterday", true)[index].time!)
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 14.sp,
                                                                color: Theme.of(context).colorScheme.tertiary,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      trailing: GestureDetector(
                                                        onTap: () {
                                                          baseController.handleCall(
                                                              value.getDataList("yesterday", true)[index].numberToDial,
                                                              context);
                                                        },
                                                        child: Container(
                                                          child: Image.asset(
                                                            'assets/images/dial.png',
                                                            color: Colors.black,
                                                            height: 17.h,
                                                          ),
                                                        ),
                                                      ),
                                                      title: Text(
                                                        value.getDataList("yesterday", true)[index].name!,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 15.sp,
                                                            overflow: TextOverflow.ellipsis),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                    value.getDataList("earlier", true).length < 1
                                        ? Container()
                                        : Column(
                                            children: [
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                                child: Align(
                                                  child: Text(
                                                    "Earlier",
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  alignment: Alignment.centerLeft,
                                                ),
                                              ),
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemCount: value.getDataList("earlier", true).length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  return Container(
                                                    child: ListTile(
                                                      dense: true,
                                                      leading: TextBox(
                                                        text: value.getDataList("earlier", true)[index].name!.length ==
                                                                3
                                                            ? value
                                                                .getDataList("earlier", true)[index]
                                                                .name!
                                                                .substring(0, 3)
                                                            : value.getDataList("earlier", true)[index].name!.length ==
                                                                    2
                                                                ? value
                                                                    .getDataList("earlier", true)[index]
                                                                    .name!
                                                                    .substring(0, 1)
                                                                : value.getDataList("earlier", true)[index].name![0],
                                                      ),
                                                      subtitle: Container(
                                                        margin: EdgeInsets.only(top: 5.h),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              child: Image.asset(
                                                                // 'assets/images/${repo.allCallHistory['Today'][index]['type']}_call.png',
                                                                value.getDataList("earlier", true)[index].isIncoming! &&
                                                                        value
                                                                            .getDataList("earlier", true)[index]
                                                                            .isMissed!
                                                                    ? "assets/images/missed_call.png"
                                                                    : value
                                                                                .getDataList("earlier", true)[index]
                                                                                .isIncoming! &&
                                                                            !value
                                                                                .getDataList("earlier", true)[index]
                                                                                .isMissed!
                                                                        ? "assets/images/incoming_call.png"
                                                                        : "assets/images/outgoing_call.png",
                                                                // fit: BoxFit.fill,
                                                                scale: 4.2,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10.w,
                                                            ),
                                                            Text(
                                                              DateFormat.MMMEd()
                                                                  .add_jm()
                                                                  .format(
                                                                      value.getDataList("earlier", true)[index].time!)
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 14.sp,
                                                                color: Theme.of(context).colorScheme.tertiary,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      trailing: GestureDetector(
                                                        onTap: () {
                                                          baseController.handleCall(
                                                              value.getDataList("earlier", true)[index].numberToDial,
                                                              context);
                                                        },
                                                        child: Container(
                                                          child: Image.asset(
                                                            'assets/images/dial.png',
                                                            color: Colors.black,
                                                            height: 17.h,
                                                          ),
                                                        ),
                                                      ),
                                                      title: Text(
                                                        value.getDataList("earlier", true)[index].name!,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 15.sp,
                                                            overflow: TextOverflow.ellipsis),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                    value.isLoading ?const SizedBox(height:20 ,):const SizedBox(),
                                    value.isLoading ? const CircularProgressIndicator():const SizedBox(),
                                    value.isLoading ?const SizedBox(height:15,):const SizedBox(),
                                  ],
                                ),
                              ),
                      ]))
                ])),
              ),
            ),
          );
        });
  }
}
