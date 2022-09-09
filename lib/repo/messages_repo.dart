import 'package:itp_voice/models/get_message_threads_response_model/get_message_threads_response_model.dart';
import 'package:itp_voice/repo/base_requester.dart';
import 'package:itp_voice/repo/shares_preference_repo.dart';
import 'package:itp_voice/routes.dart';
import 'package:itp_voice/storage_keys.dart';

class MessagesRepo {
  getMessageThreads() async {
    String? apiId = await SharedPreferencesMethod.getString(StorageKeys.API_ID);
    try {
      String number = '+13053170959';
      final apiResponse = await BaseRequesterMethods.baseRequester.baseGetAPI(
        Endpoints.GET_MESSAGE_THREADS(apiId, number),
      );
      if (!apiResponse['errors']) {
        GetMessageThreadsResponseModel response =
            GetMessageThreadsResponseModel.fromJson(apiResponse);
        return response;
      }
      return "Something went wrong";
    } catch (e) {
      print(e.toString());
      return "Something went wrong";
    }
  }
}
