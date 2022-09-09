import 'package:get/get.dart';
import 'package:itp_voice/models/get_message_threads_response_model/get_message_threads_response_model.dart';
import 'package:itp_voice/repo/messages_repo.dart';

class MessagesController extends GetxController {
  MessagesRepo repo = MessagesRepo();

  List<MessageThreads> threads = <MessageThreads>[];

  RxBool isloading = false.obs;

  loadThreads() async {
    threads.clear();
    isloading.value = true;

    final res = await repo.getMessageThreads();
    if (res.runtimeType == GetMessageThreadsResponseModel) {
      GetMessageThreadsResponseModel model = res;
      threads = model.result?.messageThreads ?? [];
    }

    isloading.value = false;
  }

  @override
  void onInit() {
    loadThreads();
    super.onInit();
  }
}
