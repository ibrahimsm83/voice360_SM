import 'dart:convert';

import 'package:itp_voice/models/add_contact_request_model/add_contact_request_model.dart';
import 'package:itp_voice/models/get_contacts_reponse_model/contact_response.dart';
import 'package:itp_voice/models/get_contacts_reponse_model/get_contacts_reponse_model.dart';
import 'package:itp_voice/repo/base_requester.dart';
import 'package:itp_voice/repo/shares_preference_repo.dart';
import 'package:itp_voice/routes.dart';
import 'package:itp_voice/storage_keys.dart';

class ContactsRepo {
  BaseRequester requester = BaseRequester();

  createContact(String name, String notes, String phone, String email) async {
    try {
      String? apiId = await SharedPreferencesMethod.getString(StorageKeys.API_ID);

      final apiResponse = await requester
          .basePostAPI(Endpoints.CREATE_CONTACT_URL(apiId), jsonEncode({'firstname': name, 'lastname': '', 'notes': notes, 'phone': phone, 'email': email}), protected: true);

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

  updateContact(dynamic id, String name, String notes, String phone, String email) async {
    try {
      String? apiId = await SharedPreferencesMethod.getString(StorageKeys.API_ID);

      final apiResponse = await requester.basePatchAPI(
          Endpoints.UPDATE_CONTACT_URL(apiId) + '/${id}', jsonEncode({'firstname': name, 'lastname': '', 'notes': notes, 'phone': phone, 'email': email}),
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

  getContacts(String offSet,) async {
    String? apiId = await SharedPreferencesMethod.getString(StorageKeys.API_ID);

    try {
      final apiResponse = await BaseRequesterMethods.baseRequester.baseGetAPI(
        Endpoints.GET_CONTACTS_URL(apiId,offSet),
      );

      if (apiResponse['errors'] ==false) {
        ContactResponse reponse = ContactResponse.fromJson(apiResponse);
        // GetContactsReponseModel reponse =
        //     GetContactsReponseModel.fromMap(apiResponse);
        return reponse;
      }
      return "Something went wrong";
    } catch (e) {
      print(e.toString());
      return "Something went wrong";
    }
  }
  searchContacts(String offSet,String query) async {
    String? apiId = await SharedPreferencesMethod.getString(StorageKeys.API_ID);

    try {
      final apiResponse = await BaseRequesterMethods.baseRequester.baseGetAPI(
        Endpoints.SEARCH_CONTACTS_URL(apiId,offSet,query),
      );

      if (apiResponse['errors'] ==false) {
        ContactResponse reponse = ContactResponse.fromJson(apiResponse);
        // GetContactsReponseModel reponse =
        //     GetContactsReponseModel.fromMap(apiResponse);
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
      print("_________$apiId **$id");
      final apiResponse = await BaseRequesterMethods.baseRequester.baseDeleteAPI(
        Endpoints.DELETE_CONTACT(apiId) + "/$id",
        null,
        protected: true,
      );

      if (apiResponse['error']==null) {
        return true;
      }
      return apiResponse['message'];
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

  updateMyNumber(String myNumber) async {
    try {
      await BaseRequesterMethods.baseRequester.basePatchAPI(
        Endpoints.USER_PROFILE,
        jsonEncode({"mobile": myNumber}),
        protected: true,
      );
    } catch (e) {
      throw (e.toString());
    }
  }
}
