import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itp_voice/controllers/call_history_controller.dart';
import 'package:itp_voice/controllers/contacts_controller.dart';
import 'package:itp_voice/repo/call_history_repo.dart';
import 'package:itp_voice/repo/shares_preference_repo.dart';
import 'package:itp_voice/routes.dart';
import 'package:itp_voice/storage_keys.dart';
import 'package:itp_voice/widgets/contact_list_shimmer.dart';
import 'package:itp_voice/widgets/search_textfield.dart';
import 'package:itp_voice/widgets/text_container.dart';
import 'package:itp_voice/temp_data.dart' as repo;

class ContactsScreen extends StatefulWidget {
  ContactsScreen({Key? key}) : super(key: key);

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

final List<AlphabetListViewItemGroup> animals = [
  for (var animalLetter in repo.animals.entries)
    AlphabetListViewItemGroup(
      tag: animalLetter.key,
      children: animalLetter.value
          .map(
            (animal) => GestureDetector(
              onTap: () {
                Get.toNamed(Routes.CONTACT_DETAIS_SCREEN_ROUTE);
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextBox(
                      text: animal[0],
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
                                  "${animal}",
                                  // style: ts(1, 0xff1B1A57, 14.sp, 5),
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.sp,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                              ],
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          )
          .toList(),
    ),
];

class _ContactsScreenState extends State<ContactsScreen> {
  ContactsController con = Get.put(ContactsController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: SizedBox(
          height: 50.h,
          width: 50.h,
          child: FloatingActionButton(
            onPressed: () {
              Get.toNamed(Routes.ADD_NEW_CONTACT_ROUTE);
              // con.fetchContacts();
              // SharedPreferencesMethod.storage
              //     .setString(StorageKeys.REFRESH_TOKEN, "asdfadfasdfasdfa");
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
          actions: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  useRootNavigator: true,
                  builder: (context) {
                    return Container(
                      height: 180.h,
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

                            // CallHistoryRepo().getCallHistory();
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Call History",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.SETTINGS_SCREEN_ROUTE);
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Settings",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                          ),
                        )
                      ]),
                    );
                  },
                );
              },
              child: Container(
                margin: EdgeInsets.only(right: 20.w, top: 10.h),
                child: Icon(Icons.more_vert,
                    color: Color(0xff6B6F80), size: 22.sp),
              ),
            )
          ],
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Container(
            padding: EdgeInsets.only(top: 10.h),
            child: Text(
              "Contacts",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        body: GetBuilder<ContactsController>(
            init: con,
            builder: (ContactsController value) {
              return SingleChildScrollView(
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
                        unselectedLabelColor: Color(0xff838799),
                        indicatorColor: Theme.of(context).colorScheme.primary,
                        indicatorSize: TabBarIndicatorSize.label,

                        indicatorPadding: EdgeInsets.only(bottom: 10.h),
                        labelStyle: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.w500),
                        tabs: [
                          Tab(
                            text: 'Contacts',
                          ),
                          Tab(
                            text: 'Groups',
                          ),
                        ],
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.63,
                          child: TabBarView(children: [
                            value.isContactsLoading
                                ? ContactListShimmer()
                                : ListView.builder(
                                    itemCount: con.getDataList().length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Get.toNamed(
                                              Routes
                                                  .CONTACT_DETAIS_SCREEN_ROUTE,
                                              arguments:
                                                  con.getDataList()[index]);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10.h, horizontal: 10.w),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              TextBox(
                                                text: con
                                                    .getDataList()[index]
                                                    .firstname![0],
                                              ),
                                              SizedBox(width: 15.w),
                                              Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "${con.getDataList()[index].firstname!}",
                                                            // style: ts(1, 0xff1B1A57, 14.sp, 5),
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 15.sp,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5.w,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ))
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                            ListView.builder(itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 0.w),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
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
                                                Container(
                                                  width: 100.w,
                                                  child: Stack(
                                                    children: [
                                                      Positioned(
                                                        left: 35.w,
                                                        child: Container(
                                                          height: 50.h,
                                                          width: 50.w,
                                                          alignment:
                                                              Alignment.center,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .white),
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Color(
                                                                  0xffF5F8FF)),
                                                          child: Text(
                                                            "B",
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff2960EC),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 17.sp,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        child: Container(
                                                          height: 50.h,
                                                          width: 50.w,
                                                          alignment:
                                                              Alignment.center,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .white),
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Color(
                                                                0xffF5F8FF),
                                                          ),
                                                          child: Text(
                                                            "A",
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xff2960EC),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 17.sp,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  "ABC",
                                                  // style: ts(1, 0xff1B1A57, 14.sp, 5),
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15.sp,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              );
                            })
                          ]))
                    ])),
              );
            }),
      ),
    );
  }
}
