import 'package:itp_voice/models/get_voice_mails_response_model/get_voice_mails_response_model.dart';
import 'package:itp_voice/repo/base_requester.dart';
import 'package:itp_voice/repo/shares_preference_repo.dart';
import 'package:itp_voice/routes.dart';
import 'package:itp_voice/storage_keys.dart';

class VoiceMailsRepo {



  getVoiceMails() async {
    String? apiId = await SharedPreferencesMethod.getString(StorageKeys.API_ID);
    try {
      final apiResponse = await BaseRequesterMethods.baseRequester.baseGetAPI(
        Endpoints.GET_VOICE_MAILS_URL(apiId),
      );

      print("Voice mails respone ---in voicemailRepo.dart line no 18---->${apiResponse}");
      if (!apiResponse['errors']) {
        GetVoiceMailsResponseModel reponse =
            GetVoiceMailsResponseModel.fromMap(apiResponse);
        return reponse;
      }
      return "Something went wrong";
    } catch (e) {
      print(e.toString());
      return "Something went wrong";
    }
  }

  deleteVoicemail(id) async {
    String? apiId = await SharedPreferencesMethod.getString(StorageKeys.API_ID);

    try {
      final apiResponse =
          await BaseRequesterMethods.baseRequester.baseDeleteAPI(
        Endpoints.DELETE_VOICE_MAIL_MESSAGE(apiId) + "/$id",
        null,
        protected: true,
      );

      if (!apiResponse['errors']) {
        return true;
      }
      return "Something went wrong";
    } catch (e) {
      print(e.toString());
      return "Something went wrong";
    }
  }
}
