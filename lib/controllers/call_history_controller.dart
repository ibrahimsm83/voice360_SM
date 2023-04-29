import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:itp_voice/models/call_history_model.dart';
import 'package:itp_voice/repo/call_history_repo.dart';
import 'package:itp_voice/widgets/custom_loader.dart';
import 'package:itp_voice/widgets/custom_toast.dart';

int itemCount=0;
int apiLimit=20;
class CallHistoryController extends GetxController {
  bool isLoading = false;
  CallHistoryRepo repo = CallHistoryRepo();
  List<CallHistory> callHistoryList = [];
  List<CallHistory> todayCallHistory = [];
  List<CallHistory> yesterdayCallHistory = [];
  TextEditingController searchController = TextEditingController();
  int apiOffset=0;

  late ScrollController scrollController;
  getCallHistory() async {
    DateTime todayDate = DateTime.now();
    isLoading = true;

    update();
    final res = await repo.fetchCallHistory( offSet: apiOffset);
    isLoading = false;
    update();
    if (res.runtimeType == String) {
      CustomToast.showToast(res, true);
      return;
    }
    if (res.runtimeType == List<CallHistory>) {
      apiOffset=apiOffset+apiLimit;
      callHistoryList.addAll(res) ;

      // for (int i = 0; i < callHistoryList.length; i++) {
      //   if (callHistoryList[0].time!.day == todayDate.day) {
      //     callHistoryList.add(callHistoryList[i]);
      //   }
      // }
      for (int i = 0; i < callHistoryList.length; i++) {
        if (callHistoryList[0].time!.day == todayDate.day) {
          todayCallHistory.add(callHistoryList[i]);
          callHistoryList.removeAt(i);
        }
        if (callHistoryList[0].time!.day ==
            DateTime.now().subtract(const Duration(days: 1)).day) {
          yesterdayCallHistory.add(callHistoryList[i]);
          callHistoryList.removeAt(i);
        }
      }
      update();
    }
  }

  getDataList(String type, bool missedOnly) {
    if (type == "today" && !missedOnly) {
      if (searchController.text.isEmpty) {
        return todayCallHistory;
      }
      if (searchController.text.isNotEmpty) {
        return todayCallHistory
            .where((element) =>
                element.name!.toLowerCase() ==
                searchController.text.toLowerCase())
            .toList();
      }
    }
    if (type == "today" && missedOnly) {
      if (searchController.text.isEmpty) {
        return todayCallHistory
            .where((element) => element.isMissed! && element.isIncoming!)
            .toList();
      }
      if (searchController.text.isNotEmpty) {
        return todayCallHistory
            .where((element) => element.isMissed! && element.isIncoming!)
            .where((element) =>
                element.name!.toLowerCase() ==
                searchController.text.toLowerCase())
            .toList();
      }
    }

    if (type == "yesterday" && !missedOnly) {
      if (searchController.text.isEmpty) {
        return yesterdayCallHistory;
      }
      if (searchController.text.isNotEmpty) {
        return yesterdayCallHistory
            .where(
              (element) => element.name!
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()),
            )
            .toList();
      }
    }
    if (type == "yesterday" && missedOnly) {
      if (searchController.text.isEmpty) {
        return yesterdayCallHistory
            .where((element) => element.isMissed! && element.isIncoming!)
            .toList();
      }
      if (searchController.text.isNotEmpty) {
        return yesterdayCallHistory
            .where((element) => element.isMissed! && element.isIncoming!)
            .where(
              (element) => element.name!
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()),
            )
            .toList();
      }
    }

    if (type == "earlier" && !missedOnly) {
      if (searchController.text.isEmpty) {
        return callHistoryList;
      }
      if (searchController.text.isNotEmpty) {
        return callHistoryList
            .where(
              (element) => element.name!
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()),
            )
            .toList();
      }
    }
    if (type == "earlier" && missedOnly) {
      if (searchController.text.isEmpty) {
        return callHistoryList
            .where((element) => element.isMissed! && element.isIncoming!)
            .toList();
      }
      if (searchController.text.isNotEmpty) {
        return callHistoryList
            .where((element) => element.isMissed! && element.isIncoming!)
            .where(
              (element) => element.name!
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()),
            )
            .toList();
      }
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && apiLimit==itemCount) {
        getCallHistory();
      }
    });
    getCallHistory();
  }
}
