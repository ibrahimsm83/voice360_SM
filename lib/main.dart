import 'package:audio_service/audio_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itp_voice/app_theme.dart';
import 'package:itp_voice/controllers/bindings.dart';
import 'package:itp_voice/controllers/call_screen_controller.dart';
import 'package:itp_voice/locator.dart';
import 'package:itp_voice/notification_service.dart';
import 'package:itp_voice/routes.dart';
import 'package:itp_voice/screens/base_screen.dart';
import 'package:itp_voice/screens/login_screen.dart';
import 'package:itp_voice/widgets/custom_toast.dart';
import 'package:sip_ua/sip_ua.dart';
import 'package:timezone/data/latest_all.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  // await setupFlutterNotifications();
  // showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  setupLocator();
  // Step 3
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  LocalNotificationService.initialize();
  initializeTimeZones();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 786),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return DefaultTextStyle(
          style: const TextStyle(
            fontFamily: 'Nato Sans',
          ),
          child: GetMaterialApp(
            title: 'ITP Voice',
            initialBinding: Binding(),
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,

            // translations: Languages(),
            // fallbackLocale: const Locale('en', 'US'),
            getPages: AppRoutes.routes,
            initialRoute: Routes.LOGIN_SCREEN_ROUTE,
            // initialRoute: Routes.LOGIN_SCREEN_ROUTE,
          ),
        );
      },
    );
  }

  // void _portraitModeOnly() {
  //   SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ]);
  // }
}
