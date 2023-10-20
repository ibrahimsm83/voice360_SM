import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itp_voice/helpers/config.dart';
import 'package:itp_voice/models/contact_list_data_model.dart';
import 'package:itp_voice/models/get_contacts_reponse_model/contact_response.dart';
import 'package:itp_voice/models/get_contacts_reponse_model/get_contacts_reponse_model.dart';
import 'package:itp_voice/repo/contacts_repo.dart';
import 'package:itp_voice/routes.dart';
import 'package:itp_voice/widgets/custom_loader.dart';
import 'package:itp_voice/widgets/custom_toast.dart';
import 'package:itp_voice/widgets/text_container.dart';

class ContactsController extends GetxController {
  bool isContactsLoading = false;
  ContactsRepo repo = ContactsRepo();
  Map<String, List<String>> filteredData = {};
  List<Contact> unfilteredData = [];
  List<AlphabetListViewItemGroup> contacts = [];
  TextEditingController searchController = TextEditingController();
  RxInt conOffSet=0.obs,totalPages=0.obs,currentPage=0.obs,totalCount=0.obs;

  fetchContacts(String offSet) async {
    if(offSet == '0') {
      unfilteredData.clear();
      conOffSet.value=0;
      totalPages.value=0;
      totalCount.value=0;
      currentPage.value=0;
      isContactsLoading = true;
    }

    update();
    final res = await repo.getContacts(offSet,);
    isContactsLoading = false;
    print("~~~~~~~~~~~~~~~~${res.runtimeType}~~~~~~~~~~~~~~~${res.runtimeType}");

    if (res.runtimeType == ContactResponse) {
      print("**************INIT DATA ${unfilteredData.length}  ");
      ContactResponse model = res;
      print("**************TOTAL DATA ${model.itemCount!}  ");
      totalPages.value=model.totalPages!;
      totalCount.value=model.itemCount!;
      currentPage.value = 1 + currentPage.value ;
      conOffSet.value=conOffSet.value+20;


      if (model.result!.isNotEmpty) {
        for (int i = 0; i < Helpers.alphabet.length; i++) {
          filteredData.putIfAbsent(Helpers.alphabet[i], () => [""]);
          for (int j = 0; j < model.result!.length; j++) {
            if (Helpers.alphabet[i] ==
                model.result![j].firstname![0].toLowerCase()) {
              filteredData[Helpers.alphabet[i]]!.add(
                  model.result![j].firstname.toString() +
                      model.result![j].pk.toString());

              unfilteredData.add(model.result![j]);
            }
          }
        }
        print("FILTERED DATA");
        print(filteredData);
        print("**************END FUNCTION CALL API DATA ${unfilteredData.length}");
      }
    }
    generateWidgetList();
    update();
  }

  searchContacts(String offSet,String query) async {
    if(offSet == '0') {
      unfilteredData.clear();
      conOffSet.value=0;
      totalPages.value=0;
      currentPage.value=0;
      totalCount.value=0;
      isContactsLoading = true;
    }

    update();
    final res = await repo.searchContacts(offSet,query);
    isContactsLoading = false;
    print("~~~~~~~~~~~~~~~~${res.runtimeType}~~~~~~~~~~~~~~~${res.runtimeType}");

    if (res.runtimeType == ContactResponse) {
      print("**************INIT DATA ${unfilteredData.length}");
      ContactResponse model = res;

      totalPages.value=model.totalPages!;
      totalCount.value=model.itemCount!;
      currentPage.value = 1 + currentPage.value ;
      conOffSet.value=conOffSet.value+20;


      if (model.result!.isNotEmpty) {
        for (int i = 0; i < Helpers.alphabet.length; i++) {
          filteredData.putIfAbsent(Helpers.alphabet[i], () => [""]);
          for (int j = 0; j < model.result!.length; j++) {
            if (Helpers.alphabet[i] ==
                model.result![j].firstname![0].toLowerCase()) {
              filteredData[Helpers.alphabet[i]]!.add(
                  model.result![j].firstname.toString() +
                      model.result![j].pk.toString());

              unfilteredData.add(model.result![j]);
            }
          }
        }
        print("FILTERED DATA");
        print(filteredData);
        print("**************END FUNCTION CALL API DATA ${unfilteredData.length}");
      }
    }
    generateWidgetList();
    update();
  }

  deleteContact(id) async {
    Get.back();
    CustomLoader.showLoader();
    var res = await repo.deleteContact(id);
    Get.back();

    if (res.runtimeType == String) {
      CustomToast.showToast(res, true);
    } else {
      Get.back();
      unfilteredData.removeWhere((element) => element.pk == id);
      update();
    }
  }

  getDataList() {
    if (searchController.text.isEmpty) {
      return unfilteredData;
    }
    if (searchController.text.isNotEmpty) {
      return unfilteredData
          .where((element) => element.firstname!
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    }
  }

  generateWidgetList() {
    contacts = [
      for (var contactLetter in filteredData.entries)
        AlphabetListViewItemGroup(
          tag: contactLetter.key,
          children: contactLetter.value
              .map(
                (contact) => GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.CONTACT_DETAIS_SCREEN_ROUTE);
                  },
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextBox(
                          text: contact.isEmpty ? "-" : contact[0],
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
                                    "${contact}",
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
    ];

    update();
    // contacts.toList().clear();
    // for (int i = 0; i < filteredData.entries.length; i++) {
    //   List<Widget> childrens = [];
    //   for (int j = 0; j < filteredData.entries.toList()[i].value.length; j++) {
    //     childrens.add(
    //       GestureDetector(
    //         onTap: () {
    //           Get.toNamed(Routes.CONTACT_DETAIS_SCREEN_ROUTE);
    //         },
    //         child: Container(
    //           margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
    //           child: Row(
    //             mainAxisSize: MainAxisSize.max,
    //             children: [
    //               TextBox(
    //                 text: filteredData.entries.toList()[i].value[j].name![0],
    //               ),
    //               SizedBox(width: 15.w),
    //               Container(
    //                 alignment: Alignment.centerLeft,
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Row(
    //                       children: [
    //                         Text(
    //                           "${filteredData.entries.toList()[i].value[j].name}",
    //                           // style: ts(1, 0xff1B1A57, 14.sp, 5),
    //                           maxLines: 2,
    //                           style: TextStyle(
    //                               fontWeight: FontWeight.w600,
    //                               fontSize: 15.sp,
    //                               overflow: TextOverflow.ellipsis),
    //                         ),
    //                         SizedBox(
    //                           width: 5.w,
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //   }
    //   AlphabetListViewItemGroup item = AlphabetListViewItemGroup(
    //       tag: filteredData.entries.toList()[i].key, children: childrens);

    //   contacts.add(item);
    // }
    // update();
    // print(contacts.length);
    // for (var letters in filteredData.entries) {
    //   AlphabetListViewItemGroup item = AlphabetListViewItemGroup(
    //       tag: letters.key,
    //       children: letters.value.map(
    //         (contact) => GestureDetector(
    //           onTap: () {
    //             Get.toNamed(Routes.CONTACT_DETAIS_SCREEN_ROUTE);
    //           },
    //           child: Container(
    //             margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
    //             child: Row(
    //               mainAxisSize: MainAxisSize.max,
    //               children: [
    //                 TextBox(
    //                   text: contact.name![0],
    //                 ),
    //                 SizedBox(width: 15.w),
    //                 Container(
    //                   alignment: Alignment.centerLeft,
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Row(
    //                         children: [
    //                           Text(
    //                             "${contact.name}",
    //                             // style: ts(1, 0xff1B1A57, 14.sp, 5),
    //                             maxLines: 2,
    //                             style: TextStyle(
    //                                 fontWeight: FontWeight.w600,
    //                                 fontSize: 15.sp,
    //                                 overflow: TextOverflow.ellipsis),
    //                           ),
    //                           SizedBox(
    //                             width: 5.w,
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ));
    //   contacts.map((e) => item);
    // }
  }
  //
  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  //   fetchContacts();
  // }
}
