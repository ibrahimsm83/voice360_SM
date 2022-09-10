import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itp_voice/controllers/bindings.dart';
import 'package:itp_voice/notification_service.dart';
import 'package:itp_voice/routes.dart';
import 'package:itp_voice/screens/base_screen.dart';
import 'package:itp_voice/screens/login_screen.dart';

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
  // Step 3
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  LocalNotificationService.initialize();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp()));
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
        return GetMaterialApp(
          title: 'ITP Voice',
          initialBinding: Binding(),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Color(0xff6982FF),
              secondary: Color(0xff242424),
              tertiary: Color(0xff6B6F80),
            ),
            fontFamily: 'Noto Sans',
          ),
          debugShowCheckedModeBanner: false,
          // translations: Languages(),
          // fallbackLocale: const Locale('en', 'US'),
          getPages: AppRoutes.routes,
          initialRoute: Routes.LOGIN_SCREEN_ROUTE,
        );
      },
    );
  }

  void _portraitModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
