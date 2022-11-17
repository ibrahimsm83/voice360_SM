import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:itp_voice/models/get_message_threads_response_model/get_message_threads_response_model.dart';
import 'package:itp_voice/models/get_thread_messages_response_model/get_thread_messages_response_model.dart';
import 'package:itp_voice/repo/base_requester.dart';
import 'package:itp_voice/repo/shares_preference_repo.dart';
import 'package:itp_voice/routes.dart';
import 'package:itp_voice/storage_keys.dart';

class MessagesRepo {
  getMessageThreads(String myNumber) async {
    String? apiId = await SharedPreferencesMethod.getString(StorageKeys.API_ID);
    try {
      String number = myNumber;
      final apiResponse = await BaseRequesterMethods.baseRequester.baseGetAPI(
        Endpoints.GET_MESSAGE_THREADS(apiId, number),
      );
      if (!apiResponse['errors']) {
        GetMessageThreadsResponseModel response = GetMessageThreadsResponseModel.fromJson(apiResponse);
        return response;
      }
      return "Something went wrong";
    } catch (e) {
      print(e.toString());
      return "Something went wrong";
    }
  }

  getThreadMessages(String threadId, String myNumber) async {
    String? apiId = await SharedPreferencesMethod.getString(StorageKeys.API_ID);
    try {
      String number = myNumber;
      final apiResponse = await BaseRequesterMethods.baseRequester.baseGetAPI(
        Endpoints.GET_THREAD_MESSAGES(apiId, number, threadId),
      );
      if (!apiResponse['errors']) {
        GetThreadMessagesResponseModel response = GetThreadMessagesResponseModel.fromJson(apiResponse);
        return response;
      }
      return "Something went wrong";
    } catch (e) {
      print(e.toString());
      return "Something went wrong";
    }
  }

  Future<Messages?> sendMessage(String myNumber, String body, String to, [String? image]) async {
    String? apiId = await SharedPreferencesMethod.getString(StorageKeys.API_ID);
    try {
      // {
      //     "body": body,
      //     "from_number": myNumber,
      //     "to_numbers_list": "{\"list\": [\"+13052990233\"]}"
      //   }
      Dio dio = Dio();
      print(body);
      Map<String, dynamic> data = {
        "body": body,
        "from_number": myNumber,
        "to_numbers_list": to,
      };
      print(to);
      if (image != null) {
        data["file"] = await MultipartFile.fromFile(image);
      }
      final resp = await BaseRequesterMethods.baseRequester
          .basePostAPI(Endpoints.SEND_MESSAGE(apiId, myNumber), data, useDio: true);
      print(resp);
      return Messages.fromJson(resp["result"]);
    } catch (e) {
      if (e is DioError) {
        print(e.response);
      }
      print(e.toString());
      return null;
    }
  }
}
