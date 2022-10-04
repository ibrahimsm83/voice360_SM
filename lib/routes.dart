import 'package:get/get.dart';
import 'package:itp_voice/helpers/config.dart';
import 'package:itp_voice/screens/add_new_contact.dart';
import 'package:itp_voice/screens/base_screen.dart';
import 'package:itp_voice/screens/call_history_screen.dart';
import 'package:itp_voice/screens/call_screen.dart';
import 'package:itp_voice/screens/call_settings_screen.dart';
import 'package:itp_voice/screens/change_password_screen.dart';
import 'package:itp_voice/screens/chat_screen.dart';
import 'package:itp_voice/screens/contact_details_screen.dart';
import 'package:itp_voice/screens/edit_contact_screen.dart';
import 'package:itp_voice/screens/in_call_dialpad.dart';
import 'package:itp_voice/screens/login_screen.dart';
import 'package:itp_voice/screens/settings_screen.dart';
import 'package:itp_voice/screens/voice_mail_details_screen.dart';

class AppRoutes {
  static List<GetPage<dynamic>> routes = [
    GetPage(
      name: Routes.BASE_SCREEN_ROUTE,
      page: () => BaseScreen(),
    ),
    GetPage(
      name: Routes.LOGIN_SCREEN_ROUTE,
      page: () => LoginScreen(),
    ),
    GetPage(
        name: Routes.CONTACT_DETAIS_SCREEN_ROUTE,
        page: () => ContactDetailsScreen()),
    GetPage(
        name: Routes.CALL_HISTORY_SCREEN_ROUTE,
        page: () => CallHistoryScreen()),
    GetPage(
        name: Routes.VOICE_MAIL_DETAILS_ROUTE,
        page: () => VoiceMailDetailsScreen()),
    GetPage(
      name: Routes.SETTINGS_SCREEN_ROUTE,
      page: () => SettingsScreen(),
    ),
    GetPage(
      name: Routes.CALL_SETTINGS_ROUTE,
      page: () => CallSettingsScreen(),
    ),
    GetPage(
      name: Routes.CHANGE_PASSWORD_ROUTE,
      page: () => ChangePassordScreen(),
    ),
    GetPage(
      name: Routes.ADD_NEW_CONTACT_ROUTE,
      page: () => AddNewContactScreen(),
    ),
    GetPage(
      name: Routes.ADD_NEW_CONTACT_ROUTE,
      page: () => AddNewContactScreen(),
    ),
    GetPage(
      name: Routes.CHAT_SCREEN_ROUTE,
      page: () => ChatScreen(),
    ),
    GetPage(
      name: Routes.CALL_SCREEN_ROUTE,
      page: () => CallScreen(),
    ),
    GetPage(
      name: Routes.DIALPAD_SCREEN_ROUTE,
      page: () => InCallDialPad(),
    ),
    GetPage(
      name: Routes.EDIT_CONTACT_ROUTE,
      page: () => EditContactScreen(),
    ),
  ];
}

class Routes {
  static String BASE_SCREEN_ROUTE = '/';
  static String LOGIN_SCREEN_ROUTE = '/login_screen_route';
  static String VOICE_MAIL_DETAILS_ROUTE = '/voice_mail_details_route';
  static String CALL_HISTORY_SCREEN_ROUTE = '/call_history_screen_route';
  static String CONTACT_DETAIS_SCREEN_ROUTE = '/contact_details_screen_route';
  static String SETTINGS_SCREEN_ROUTE = '/settings_screen_route';
  static String CALL_SETTINGS_ROUTE = '/call_settings_route';
  static String CHANGE_PASSWORD_ROUTE = '/change_password_route';
  static String ADD_NEW_CONTACT_ROUTE = '/add_new_contact_screen_route';
  static String CHAT_SCREEN_ROUTE = '/chat_screen_route';
  static String CALL_SCREEN_ROUTE = '/call_screen_route';
  static String DIALPAD_SCREEN_ROUTE = '/dialpad_screen_route';
  static String EDIT_CONTACT_ROUTE = '/edit_contact_screen_route';
}

class Endpoints {
  static String LOGIN_URL = Config.BASE_URL_CRM + "/auth/login";
  static String SERVICES_URL = Config.BASE_URL_CRM + "/services";
  static String REFRESH_TOKEN_URL = Config.BASE_URL_CRM + "/auth/refresh";
  static String USER_PROFILE = Config.BASE_URL_CRM + "/myprofile";

  static String GET_DEVICES_URL(api_id) {
    return Config.BASE_URL_ITP_VOICE + "${api_id}/my-extension/devices";
  }

  static String GET_ACCOUNT_DETAILS(api_id) {
    return Config.BASE_URL_ITP_VOICE + "${api_id}";
  }

  static String CREATE_CONTACT_URL(api_id) {
    return 'https://api.itpscorp.com/dev/portal/360/accounts/${api_id}/my-account/contacts';
    return Config.BASE_URL_ITP_VOICE + "${api_id}/my-extension/contacts";
  }

  static String UPDATE_CONTACT_URL(api_id) {
    return 'https://api.itpscorp.com/dev/portal/360/accounts/${api_id}/my-account/contacts';
    return Config.BASE_URL_ITP_VOICE + "${api_id}/my-extension/contacts";
  }

  static String DELETE_CONTACT(api_id) {
    return 'https://api.itpscorp.com/dev/portal/360/accounts/${api_id}/my-account/contacts';
    return Config.BASE_URL_ITP_VOICE + "${api_id}/my-extension/contacts";
  }

  static String GET_CONTACTS_URL(api_id) {
    return 'https://api.itpscorp.com/dev/portal/360/accounts/${api_id}/my-account/contacts';
    return Config.BASE_URL_ITP_VOICE +
        "${api_id}/my-extension/contacts?unlimit=true";
  }

  static String GET_VOICE_MAILS_URL(api_id) {
    return Config.BASE_URL_ITP_VOICE +
        "${api_id}/my-extension/voicemail-messages";
  }

  static String DOWNLOAD_VOICE_MAIL_MESSAGES(api_id) {
    return Config.BASE_URL_ITP_VOICE +
        "${api_id}/my-extension/voicemail-messages";
  }

  static String DELETE_VOICE_MAIL_MESSAGE(api_id) {
    return Config.BASE_URL_ITP_VOICE +
        "${api_id}/my-extension/voicemail-messages";
  }

  static String GET_USER_DATA(api_id) {
    return Config.BASE_URL_ITP_VOICE + "${api_id}/my-extension";
  }

  static String GET_CALL_HISTORY(api_id) {
    return Config.BASE_URL_ITP_VOICE +
        "${api_id}/my-extension/cdr?paginate=true&page_size=10";
  }

  static String VALIDATE_PHONE_NUMBER(api_id) {
    return Config.BASE_URL_ITP_VOICE + "${api_id}/my-extension/validate-number";
  }

  static String GET_MESSAGE_THREADS(api_id, number) {
    return Config.BASE_URL_ITP_VOICE +
        "${api_id}/my-extension/chat/sms/${number}";
  }

  static String GET_THREAD_MESSAGES(api_id, number, threadId) {
    return Config.BASE_URL_ITP_VOICE +
        "${api_id}/my-extension/chat/sms/${number}/$threadId";
  }

  static String SEND_MESSAGE(api_id, number) {
    return Config.BASE_URL_ITP_VOICE +
        "${api_id}/my-extension/chat/sms/${number}";
  }
}
