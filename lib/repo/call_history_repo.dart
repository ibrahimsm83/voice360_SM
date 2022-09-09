import 'package:itp_voice/models/call_history_model.dart';
import 'package:itp_voice/models/get_contacts_reponse_model/get_contacts_reponse_model.dart';
import 'package:itp_voice/models/get_contacts_reponse_model/user_contact.dart';
import 'package:itp_voice/repo/base_requester.dart';
import 'package:itp_voice/repo/contacts_repo.dart';
import 'package:itp_voice/repo/shares_preference_repo.dart';
import 'package:itp_voice/routes.dart';
import 'package:itp_voice/storage_keys.dart';

class CallHistoryRepo {
  fetchCallHistory() async {
    List<CallHistory> callHistoryList = [];
    String? apiId = await SharedPreferencesMethod.getString(StorageKeys.API_ID);
    String? userId =
        await SharedPreferencesMethod.getString(StorageKeys.USER_ID);
    List<CallHistory> callHistory = [];
    String myPhoneNumber =
        SharedPreferencesMethod.storage.getString(StorageKeys.DEFAULT_NUMBER)!;
    String myExtension =
        SharedPreferencesMethod.storage.getString(StorageKeys.EXTENTION)!;
    try {
      final apiResponse = await BaseRequesterMethods.baseRequester
          .baseGetAPI(Endpoints.GET_CALL_HISTORY(apiId));
      if (!apiResponse['errors']) {
        Map<String, dynamic> calls =
            apiResponse['result'] as Map<String, dynamic>;
        for (int i = 0; i < calls.keys.length; i++) {
          Map<String, dynamic> _callData = calls.values.toList()[i];
          CallHistory callHistory = CallHistory(
            name: (_callData['src'] == myExtension ||
                    _callData['src'] == myPhoneNumber)
                ? _callData['clid'].split("<")[0].replaceAll('"', "")
                : _callData['src'],
            time: DateTime.fromMillisecondsSinceEpoch(
                int.parse(_callData['calldate'].toString().split('.')[0]) *
                    1000),
            isIncoming: _callData['from_user_id'].toString() != userId,
            isMissed: _callData['disposition'] != "ANSWERED",
            numberToDial: (_callData['from_user_id'].toString() != userId)
                ? _callData['src']
                : _callData['dst'],
          );
          callHistoryList.add(callHistory);
        }
        return callHistoryList;
      }
      return "Something went wrong";
    } catch (e) {
      print(e.toString());
      return "Something went wrong";
    }
  }
}
