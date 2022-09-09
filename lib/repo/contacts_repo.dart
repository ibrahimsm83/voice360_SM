import 'dart:convert';

import 'package:itp_voice/models/add_contact_request_model/add_contact_request_model.dart';
import 'package:itp_voice/models/get_contacts_reponse_model/get_contacts_reponse_model.dart';
import 'package:itp_voice/repo/base_requester.dart';
import 'package:itp_voice/repo/shares_preference_repo.dart';
import 'package:itp_voice/routes.dart';
import 'package:itp_voice/storage_keys.dart';

class ContactsRepo {
  BaseRequester requester = BaseRequester();

  createContact(AddContactRequestModel requestData) async {
    try {
      String? apiId =
          await SharedPreferencesMethod.getString(StorageKeys.API_ID);

      final apiResponse = await requester.basePostAPI(
          Endpoints.CREATE_CONTACT_URL(apiId), requestData.toJson(),
          protected: true);

      if (apiResponse != null) {
        if (apiResponse['errors']) {
          return apiResponse['message'];
        } else {
          return true;
        }
      }
    } catch (e) {
      return "Something went wrong";
    }
  }

  getContacts() async {
    String? apiId = await SharedPreferencesMethod.getString(StorageKeys.API_ID);

    try {
      final apiResponse = await BaseRequesterMethods.baseRequester.baseGetAPI(
        Endpoints.GET_CONTACTS_URL(apiId),
      );

      if (!apiResponse['errors']) {
        GetContactsReponseModel reponse =
            GetContactsReponseModel.fromMap(apiResponse);
        return reponse;
      }
      return "Something went wrong";
    } catch (e) {
      print(e.toString());
      return "Something went wrong";
    }
  }

  deleteContact(id) async {
    String? apiId = await SharedPreferencesMethod.getString(StorageKeys.API_ID);

    try {
      final apiResponse =
          await BaseRequesterMethods.baseRequester.baseDeleteAPI(
        Endpoints.DELETE_CONTACT(apiId) + "/$id",
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

  validatePhoneNumber(String phoneNumber) async {
    String? apiId = await SharedPreferencesMethod.getString(StorageKeys.API_ID);

    try {
      final apiResponse = await BaseRequesterMethods.baseRequester.basePostAPI(
        Endpoints.VALIDATE_PHONE_NUMBER(apiId),
        jsonEncode({"number": phoneNumber}),
        protected: true,
      );

      if (apiResponse['message'] == "Validated Number") {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return "Something went wrong";
    }
  }
}
