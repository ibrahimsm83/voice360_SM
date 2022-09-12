import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:itp_voice/models/get_devices_reponse_model/devices.dart';
import 'package:itp_voice/models/get_devices_reponse_model/get_devices_reponse_model.dart';
import 'package:itp_voice/models/login_reponse_model/login_reponse_model.dart';
import 'package:itp_voice/models/login_request_model.dart';
import 'package:itp_voice/models/services_response_model/service.dart';
import 'package:itp_voice/models/services_response_model/services_response_model.dart';
import 'package:itp_voice/models/user_profile_model/user_profile.dart';
import 'package:itp_voice/repo/base_requester.dart';
import 'package:itp_voice/repo/shares_preference_repo.dart';
import 'package:itp_voice/routes.dart';
import 'package:itp_voice/storage_keys.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
//   Future getAllPosts() async {
//     http.Response response;
//     try {
//       response = await http.get(
//         Uri.parse(
//             "https://accounts.accesscontrol.windows.net/46b48e7d-06a1-4f29-870a-d5cffc2c8e14/tokens/oAuth/2"),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//           'grant_type': 'client_credentials',
//           'client_id':
//               '38947a19-eb00-49f8-acaa-3afa9d2a0755@46b48e7d-06a1-4f29-870a-d5cffc2c8e14',
//           'client_secret': 'PI71DmpnA+QF7K4F0M3mnqN9fgeW1ep2ZYfyV1Hp/l4=',
//           'resource':
//               '00000003-0000-0ff1-ce00-000000000000/martindowgroup.sharepoint.com@46b48e7d-06a1-4f29-870a-d5cffc2c8e14'
//         },
//       );

//       if (response.statusCode == 200) {
//         print(response.body);
//         return response.body;
//       } else {
//         return response.statusCode;
//       }
//     } catch (e) {
//       print(e.toString());

//       return null;
//     }
//   }

//   Future<List?> getPosts() async {
//     print('Remote Service Class');

//     //var client = http.Client();

//     final uri = Uri.parse(
//         'https://accounts.accesscontrol.windows.net/46b48e7d-06a1-4f29-870a-d5cffc2c8e14/tokens/oAuth/2');
//     final request = http.Request('GET', uri);
//     //request.body = '{"grant_type":client_credentials,"client_id":38947a19-eb00-49f8-acaa-3afa9d2a0755@46b48e7d-06a1-4f29-870a-d5cffc2c8e14,"client_secret":PI71DmpnA+QF7K4F0M3mnqN9fgeW1ep2ZYfyV1Hp/l4=,"resource":00000003-0000-0ff1-ce00-000000000000/martindowgroup.sharepoint.com@46b48e7d-06a1-4f29-870a-d5cffc2c8e14}' ;

//     final query_parameters = {
//       'grant_type': 'client_credentials',
//       'client_id':
//           '38947a19-eb00-49f8-acaa-3afa9d2a0755@46b48e7d-06a1-4f29-870a-d5cffc2c8e14',
//       'client_secret': 'PI71DmpnA+QF7K4F0M3mnqN9fgeW1ep2ZYfyV1Hp/l4=',
//       'resource':
//           '00000003-0000-0ff1-ce00-000000000000/martindowgroup.sharepoint.com@46b48e7d-06a1-4f29-870a-d5cffc2c8e14'
//     };
//     print('data');

//     final sal_uri = Uri.https(
//         'accounts.accesscontrol.windows.net',
//         '46b48e7d-06a1-4f29-870a-d5cffc2c8e14/tokens/oAuth/2',
//         query_parameters);
//     http.Response response3 = await http.get(sal_uri);

//     print('--------------after response: ${response3.statusCode}');
//     // String body = json.encode(data);
//     // print('json convert: ${body}');

// /*    http.Response response = http.post(Uri.https('accounts.accesscontrol.windows.net', '46b48e7d-06a1-4f29-870a-d5cffc2c8e14/tokens/oAuth/2'),
//       body: data
//     );*/

//     final response2 = await request.send().asStream().first;

//     print(response2.toString());
//     //print('--------------- response 2 status code: ${response2.statusCode}');

//     // final response = await http.get(uri, headers: {
//     //   'Content-Type': 'application/json'
//     // });
//     //Map<dynamic,String> headers = {HttpHeaders.contentTypeHeader:'application/json','Accept':'application/json;odata=verbose'};

//     // http.Response response = await http.post(uri,
//     //     body: {
//     //       'grant_type':'client_credentials',
//     //       'client_id':'38947a19-eb00-49f8-acaa-3afa9d2a0755@46b48e7d-06a1-4f29-870a-d5cffc2c8e14',
//     //       'client_secret':'PI71DmpnA+QF7K4F0M3mnqN9fgeW1ep2ZYfyV1Hp/l4=',
//     //       'resource':'00000003-0000-0ff1-ce00-000000000000/martindowgroup.sharepoint.com@46b48e7d-06a1-4f29-870a-d5cffc2c8e14',
//     //
//     //     });

//     // print('------------- status code: ${response.statusCode}');

//     // var response = await client.get(uri,body:
//     // {
//     // 'grant_type':'client_credentials',
//     // 'client_id':'38947a19-eb00-49f8-acaa-3afa9d2a0755@46b48e7d-06a1-4f29-870a-d5cffc2c8e14',
//     // 'client_secret':'PI71DmpnA+QF7K4F0M3mnqN9fgeW1ep2ZYfyV1Hp/l4=',
//     // 'resource':'00000003-0000-0ff1-ce00-000000000000/martindowgroup.sharepoint.com@46b48e7d-06a1-4f29-870a-d5cffc2c8e14',
//     //
//     // } );

//     // try{
//     //   if(response.statusCode==200)
//     //   {
//     //     var json = response2.body;
//     //     print('remote service Authentication Success');
//     //     print(response.toString());
//     //     return postsModalFromJson(json).toList();
//     //   }
//     //   else{
//     //     const Text('The server is not responding.');
//     //   }
//     // }
//     // catch(e){
//     //   print('Salman  $e');
//     // }
//   }

///////////

  loginUser(String email, String password, bool rememberMe) async {
    LoginRequestModel body =
        LoginRequestModel(username: email, password: password);
    Map loginBody = body.toMap();
    loginBody['mobile_device_id'] = await FirebaseMessaging.instance.getToken();
    final apiResponse = await BaseRequesterMethods.baseRequester.basePostAPI(
        Endpoints.LOGIN_URL, jsonEncode(loginBody),
        protected: false);
    if (apiResponse != null) {
      try {
        if (apiResponse['errors']) {
          return apiResponse['message'];
        } else {
          LoginReponseModel response = LoginReponseModel.fromMap(apiResponse);
          SharedPreferencesMethod.setString(
              StorageKeys.REFRESH_TOKEN, response.result!.refreshToken);
          final devicesApiResponse = await getDevices();
          if (devicesApiResponse.runtimeType == String) {
            SharedPreferencesMethod.storage.remove(StorageKeys.REFRESH_TOKEN);
            return devicesApiResponse;
          } else if (devicesApiResponse) {
            var userIdApiResponse = await getUserID();
            if (userIdApiResponse.runtimeType == String) {
              SharedPreferencesMethod.storage.remove(StorageKeys.REFRESH_TOKEN);

              return userIdApiResponse;
            }
            if (userIdApiResponse) {
              SharedPreferencesMethod.setString(
                  StorageKeys.ACCESS_TOKEN, response.result!.accessToken);
              SharedPreferencesMethod.setbool(StorageKeys.REMEMBER, rememberMe);

              if (rememberMe) {
                SharedPreferencesMethod.setString(StorageKeys.EMAIL, email);
                SharedPreferencesMethod.setString(
                    StorageKeys.PASSWORD, password);
              } else {
                SharedPreferencesMethod.storage.remove(StorageKeys.EMAIL);
                SharedPreferencesMethod.storage.remove(StorageKeys.PASSWORD);
              }

              SharedPreferencesMethod.setString(
                  StorageKeys.REFRESH_TOKEN, response.result!.refreshToken);
              SharedPreferencesMethod.setString(StorageKeys.APPUSER_DATA,
                  json.encode(response.result!.toMap()));
              SharedPreferencesMethod.getUserData();
              return true;
              SharedPreferencesMethod.storage.remove(StorageKeys.REFRESH_TOKEN);
            } else {
              return "Something went wrong";
            }
          }
        }
      } catch (e) {
        print(e.toString());
        // SharedPreferencesMethod.storage.remove(StorageKeys.REFRESH_TOKEN);

        return "Something went wrong";
      }
    }
  }

  reLoginUser() async {
    String email = SharedPreferencesMethod.getString(StorageKeys.EMAIL)!;
    String password = SharedPreferencesMethod.getString(StorageKeys.PASSWORD)!;
    LoginRequestModel body =
        LoginRequestModel(username: email, password: password);
    final apiResponse = await BaseRequesterMethods.baseRequester
        .basePostAPI(Endpoints.LOGIN_URL, body.toJson(), protected: false);
    if (apiResponse != null) {
      try {
        if (apiResponse['errors']) {
          return apiResponse['message'];
        } else {
          LoginReponseModel response = LoginReponseModel.fromMap(apiResponse);

          SharedPreferencesMethod.setString(
              StorageKeys.REFRESH_TOKEN, response.result!.refreshToken);

          SharedPreferencesMethod.setString(
              StorageKeys.ACCESS_TOKEN, response.result!.accessToken);
          return true;
          // final devicesApiResponse = await getDevices();
          // if (devicesApiResponse.runtimeType == String) {
          //   SharedPreferencesMethod.storage.remove(StorageKeys.REFRESH_TOKEN);
          //   return devicesApiResponse;
          // } else if (devicesApiResponse) {
          // SharedPreferencesMethod.setbool(StorageKeys.REMEMBER, rememberMe);

          // if (rememberMe) {
          //   SharedPreferencesMethod.setString(StorageKeys.EMAIL, email);
          //   SharedPreferencesMethod.setString(StorageKeys.PASSWORD, password);
          // } else {
          //   SharedPreferencesMethod.storage.remove(StorageKeys.EMAIL);
          //   SharedPreferencesMethod.storage.remove(StorageKeys.PASSWORD);
          // }

          //   SharedPreferencesMethod.setString(
          //       StorageKeys.REFRESH_TOKEN, response.result!.refreshToken);
          //   SharedPreferencesMethod.setString(StorageKeys.APPUSER_DATA,
          //       json.encode(response.result!.toMap()));
          //   SharedPreferencesMethod.getUserData();
          //   return true;
          // }
        }
      } catch (e) {
        print(e.toString());
        return "Something went wrong";
      }
    }
  }

  logoutUser() async {
    await SharedPreferencesMethod.storage.remove(StorageKeys.ACCESS_TOKEN);
    await SharedPreferencesMethod.storage.remove(StorageKeys.REFRESH_TOKEN);
    await SharedPreferencesMethod.storage.remove(StorageKeys.APPUSER_DATA);
  }

  getRealm() async {
    String? apiId = await SharedPreferencesMethod.getString(StorageKeys.API_ID);

    final apiResponse = await BaseRequesterMethods.baseRequester
        .baseGetAPI(Endpoints.GET_ACCOUNT_DETAILS(apiId));
    if (!apiResponse['errors']) {
      SharedPreferencesMethod.storage
          .setString(StorageKeys.REALM, apiResponse['result']['realm']);
      return true;
    } else {
      return apiResponse['message'];
    }
  }

  getUserID() async {
    String? apiId = await SharedPreferencesMethod.getString(StorageKeys.API_ID);
    final apiResponse = await BaseRequesterMethods.baseRequester
        .baseGetAPI(Endpoints.GET_USER_DATA(apiId));
    if (apiResponse['message'] == "User details") {
      SharedPreferencesMethod.storage.setString(
          StorageKeys.USER_ID, apiResponse['result']['pk'].toString());

      SharedPreferencesMethod.storage.setString(StorageKeys.EXTENTION,
          apiResponse['result']['presence_id'].toString());

      SharedPreferencesMethod.storage.setString(
          StorageKeys.DEFAULT_NUMBER,
          apiResponse['result']['voice_account']
                  ['default_outbound_callerid_number']
              .toString());
      print("USER ID : ${apiResponse['result']['pk']}");
      return true;
    } else {
      return apiResponse['message'];
    }
  }

  getServices() async {
    final apiResponse = await BaseRequesterMethods.baseRequester
        .baseGetAPI(Endpoints.SERVICES_URL);
    if (!apiResponse['errors']) {
      // try {} catch (e) {}
      ServicesResponseModel response =
          ServicesResponseModel.fromMap(apiResponse);
      try {
        // for(int i =0;i<response.message
        List<Services> itpVoiceServices = response.services!
            .where((element) => element.product!.itemType == "itp_voice")
            .toList();
        if (itpVoiceServices.length > 1) {
          return itpVoiceServices;
        }
        if (itpVoiceServices.length == 1) {
          SharedPreferencesMethod.storage.setString(
              StorageKeys.API_ID, itpVoiceServices[0].apiId.toString());
          return true;
        }
      } catch (e) {
        return "Something went wrong";
      }
    } else {
      return apiResponse['message'];
    }
    // final apiResponse = await requester.baseGetAPI(E);
  }

  getDevices() async {
    final servicesApiResponse = await getServices();
    if (servicesApiResponse.runtimeType == String) {
      return servicesApiResponse;
    }
    if (servicesApiResponse) {
      final realmApiResponse = await getRealm();
      if (realmApiResponse.runtimeType == String) {
        return realmApiResponse;
      } else {
        String? apiId =
            await SharedPreferencesMethod.getString(StorageKeys.API_ID);

        final apiResponse = await BaseRequesterMethods.baseRequester
            .baseGetAPI(Endpoints.GET_DEVICES_URL(apiId));
        if (!apiResponse['errors']) {
          GetDevicesReponseModel response =
              GetDevicesReponseModel.fromMap(apiResponse);
          try {
            Devices appPhone = response.devices!.firstWhere(
              (element) => element.deviceType == "app_phone",
            );
            SharedPreferencesMethod.setString(
              StorageKeys.DEVICE,
              json.encode(
                appPhone.toMap(),
              ),
            );
            return true;
          } on StateError catch (e) {
            return "No registered device found";
          }
        } else {
          return apiResponse['message'];
        }
      }
    }
  }

  getProfile() async {
    String? apiId = await SharedPreferencesMethod.getString(StorageKeys.API_ID);
    UserProfile? profile;
    final apiResponse = await BaseRequesterMethods.baseRequester.baseGetAPI(
      Endpoints.USER_PROFILE,
    );
    if (!apiResponse['errors']) {
      UserProfile reponse = UserProfile.fromMap(apiResponse);
      return reponse;
    } else {
      return apiResponse['message'];
    }
  }
}
