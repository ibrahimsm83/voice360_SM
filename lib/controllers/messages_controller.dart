import 'package:floating_bottom_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itp_voice/locator.dart';
import 'package:itp_voice/models/get_message_threads_response_model/get_message_threads_response_model.dart';
import 'package:itp_voice/repo/messages_repo.dart';
import 'package:itp_voice/services/numbers_service.dart';
import 'package:itp_voice/widgets/app_button.dart';
import 'package:itp_voice/widgets/app_textfield.dart';
import 'package:itp_voice/widgets/phone_number_field.dart';

import '../widgets/custom_toast.dart';

class MessagesController extends GetxController {
  MessagesRepo repo = MessagesRepo();

  List<MessageThreads> get threads => filteredThreads.isEmpty ? allThreads : filteredThreads;
  List<MessageThreads> allThreads = <MessageThreads>[];
  List<MessageThreads> filteredThreads = <MessageThreads>[];

  TextEditingController searchController = TextEditingController();

  List<String> get numbers => locator<NumbersService>().chatNumbers;
  String? selectedNumber;

  RxBool isloading = false.obs;

  loadThreads() async {
    threads.clear();
    isloading.value = true;
    filteredThreads.clear();
    searchController.clear();
    final res = await repo.getMessageThreads(selectedNumber ?? '');
    if (res.runtimeType == GetMessageThreadsResponseModel) {
      GetMessageThreadsResponseModel model = res;
      allThreads = model.result?.messageThreads ?? [];
    }

    isloading.value = false;
  }

  filterThreads() {
    isloading.value = true;
    filteredThreads.clear();
    for (MessageThreads thread in allThreads) {
      if (thread.participants!
          .where((element) => element.isSelf != true)
          .toList()[0]
          .number!
          .contains(searchController.text)) {
        filteredThreads.add(thread);
      }
    }
    isloading.value = false;
  }

  sendNewMessage(BuildContext context) async {
    final res = await showDialog(
      context: context,
      builder: (childContext) => AddThreadDialog(),
    );
    print(res);
    if (res is List) {
      isloading.value = true;
      String numberString = "{\"list\": [\"${res[0]}\"]}";
      await repo.sendMessage(selectedNumber ?? CustomToast.showToast("Please select a number to send from first", true),
          res[1], numberString);
      await loadThreads();
    }
  }

  @override
  void onInit() async {
    if (numbers.isEmpty) {
      await locator<NumbersService>().getUpdatedNumbersList();
    }
    if (numbers.isNotEmpty) {
      selectedNumber = numbers[0];
    }
    loadThreads();
    super.onInit();
  }
}

class AddThreadDialog extends StatelessWidget {
  const AddThreadDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String code = "1";
    TextEditingController number = TextEditingController();
    String message = "";
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "To",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              PhoneNumberField(
                hint: "XXXXXXXXXX",
                textController: number,
                onChanged: (value) {
                  code = value;
                },
              ),
              const SizedBox(height: 15),
              Text(
                "Message",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              AppTextField(
                hint: "Enter message",
                onChanged: (value) => message = value,
              ),
              const SizedBox(height: 10),
              GestureDetector(
                  onTap: () => Navigator.of(context).pop([
                        "+${code}${number.text}",
                        message,
                      ]),
                  child: AppButton(
                    text: "Send",
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
