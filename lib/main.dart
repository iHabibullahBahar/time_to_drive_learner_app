import 'package:device_frame/device_frame.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/global.dart';
import 'package:ttd_learner/src/features/splash/view/splash_screen.dart';
import 'package:ttd_learner/src/utils/app_constants.dart';
//import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Firebase.initializeApp();
  // try {
  //   if (!kIsWeb) {
  //     OneSignal.initialize("eb2c19e6-d2fa-4aef-9846-bb54ac07955c");

  //     // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  //     await OneSignal.Notifications.requestPermission(true);
  //   }
  // } catch (e) {
  //   print(e);
  // }
  Get.put(Global());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'INCHECK',
      builder: (BuildContext context, Widget? child) {
        if (kIsWeb) {
          if (MediaQuery.of(context).size.width > 450.0) {
            return Center(
              child: Container(
                margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: DeviceFrame(
                  device: Devices.ios.iPhone13,
                  isFrameVisible: true,
                  orientation: Orientation.portrait,
                  screen: MediaQuery(
                    // ignore: deprecated_member_use
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                    child: child!,
                  ),
                ),
              ),
            );
          } else {
            return MediaQuery(
              // ignore: deprecated_member_use
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
              child: child!,
            );
          }
        } else {
          return MediaQuery(
            // ignore: deprecated_member_use
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: child!,
          );
        }
      },
      // builder: (context, child) {
      //   return MediaQuery(
      //     data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      //     child: child!,
      //   );
      // },
      //home: InformationScreen(),
      //home: NavigationBarScreen(),
      home: SplashScreen(),
      //home: OnboardingScreen(),
      //home: NotificationScreen(),
      //home: InformationScreen(),
      //home: SignInScreen(),
      onInit: () async {},

      /// These delegates make sure that the localization data for the proper language is loaded.
      supportedLocales: const [
        Locale('en', 'US'),
      ],
      //Set the default locale.
      locale: const Locale('en', 'US'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: ThemeData(
        useMaterial3: false,
        fontFamily: zAppFontFamily,
        // colorScheme: ColorScheme.fromSwatch(
        //   primarySwatch: zPrimarySwatch,
        // ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
    );
  }
}
