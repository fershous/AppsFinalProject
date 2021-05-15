import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:rxdart/rxdart.dart';
import 'package:final_project/init.dart';
import 'package:final_project/routes.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
 
import 'package:final_project/controllers/auth_controller.dart';
import 'package:final_project/controllers/database_controller.dart';
import 'package:final_project/controllers/datetime_controller.dart';
import 'package:final_project/controllers/unsplash_controller.dart';

import 'package:final_project/splash%20screen/splash_screen.dart';
import 'package:final_project/splash%20screen/exit_splash_screen.dart';

import 'notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String?> selectNotificationSubject =
    BehaviorSubject<String?>();

String? selectedNotificationPayload;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final NotificationAppLaunchDetails? notificationAppLaunchDetails = 
    await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    selectedNotificationPayload = notificationAppLaunchDetails!.payload;
  }

  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('launch_background');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
   onSelectNotification: (String? payload) async {
     if (payload != null) {
       debugPrint('notification payload: $payload');
     }
     selectedNotificationPayload = payload;
     selectNotificationSubject.add(payload);
   });

  runApp(MyApp());
} 
 
class MyApp extends StatelessWidget {
  
  final UnsplashController unsplashController = Get.put(UnsplashController());
  final DatabaseController databaseController = Get.put(DatabaseController());
  final DateTimeController dateTimeController = Get.put(DateTimeController());
  final AuthController         authController = Get.put(AuthController());

  final Future _initFuture = Init.initialize();

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IPHY',
      home: FutureBuilder(
        future: _initFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if (snapshot.connectionState == ConnectionState.done)
            return ExitSplashScreen();
          else
            return SplashScreen();
        },
      ),
      initialRoute: '/',
      getPages: routes(),
    );
  }
}