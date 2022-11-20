import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inzoid/constant/text_const.dart';
import 'package:inzoid/services/app_notification.dart';
import 'package:inzoid/view/bottom_bar_screen.dart';
import 'package:sizer/sizer.dart';
import 'controller/filter_screen_controller.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await AppNotificationHandler.getFcmToken();

  // AppNotificationHandler.getInitialMsg();
  // AppNotificationHandler.onMsgOpen();
  await FirebaseMessaging.instance.subscribeToTopic('all');

  // Update the iOS foreground notification presentation options to allow
  // heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  AppNotificationHandler.showMsgHandler();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: BaseBindings(),
        title: 'Inzoid',
        theme: ThemeData(fontFamily: TextConst.fontFamily),
        // home: EditProfileScreen(),
        home: BottomNavScreen(),
      ),
    );
  }
}

class BaseBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FilterScreenController(), fenix: true);
  }
}
