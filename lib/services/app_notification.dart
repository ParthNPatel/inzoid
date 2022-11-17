import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:inzoid/get_storage_services/get_storage_service.dart';

class AppNotificationHandler {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  static AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
      playSound: true);

  ///get fcm token
  static Future getFcmToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    try {
      String? token = await firebaseMessaging.getToken();

      await GetStorageServices.setFcmToken(token!);
      log('--------get fcm pref ${GetStorageServices.getFcmToken()}');
      log("=========fcm-token===$token");
      return token;
    } catch (e) {
      // log("=========fcm- Error :$e");
      return null;
    }
  }

  ///call when app in fore ground
  static void showMsgHandler() {
    try {
      FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
        RemoteNotification? notification = message!.notification;

        showMsgNormal(notification!);
      });
    } on FirebaseException catch (e) {
      log('notification 6 ${e.message}');
    }
  }

  /// handle notification when app in fore ground..///close app
  static void getInitialMsg() {
    try {
      FirebaseMessaging.instance
          .getInitialMessage()
          .then((RemoteMessage? message) {
        if (message != null) {
          log("action======1===111 ${message.data}");
          log("action======1=== ${message.data['action_click']}");
          log("slug======2=== ${message.data['slug_name']}");
          // _singleListingMainTrailController.setSlugName(
          //     slugName: '${message?.data['slug_name']}');
        }
      });
    } on FirebaseException catch (e) {
      log('notification 5 ${e.message}');
    }
  }

  ///show notification msg
  static void showMsg(RemoteNotification notification) {
    try {
      // InitializationSettings initializationSettings = InitializationSettings(
      //   android: AndroidInitializationSettings(
      //       "@drawable/ic_launcher"), /*iOS: DarwinNotificationDetails()*/
      // );
      // flutterLocalNotificationsPlugin.initialize(initializationSettings,
      //     onDidReceiveBackgroundNotificationResponse: (payload) async {});
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                'high_importance_channel', // id
                'High Importance Notifications', // title
                // 'This channel is used for important notifications.',
                // description
                importance: Importance.high,
                // when: DateTime.now().millisecondsSinceEpoch - 120 * 1000,
                icon: '@mipmap/ic_launcher',
              ),
              iOS: DarwinNotificationDetails()));
    } on FirebaseException catch (e) {
      log('notification 4 ${e.message}');
    }
  }

  static void showMsgNormal(RemoteNotification notification) {
    try {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,

          ///default
          NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel', // id
              'High Importance Notifications', // title
              // 'This channel is used for important notifications.',
              // description
              importance: Importance.high,
              // when: DateTime.now().millisecondsSinceEpoch - 120 * 1000,
              icon: '@mipmap/ic_launcher',
            ), /* iOS: DarwinNotificationDetails()*/
          ));
    } on FirebaseException catch (e) {
      log('notification 3 ${e.message}');
    }
  }

  ///background notification handler..
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    try {
      await Firebase.initializeApp();
      RemoteNotification? notification = message.notification;
    } on FirebaseException catch (e) {
      log('FirebaseException 1 ${e.message}');
    } catch (e) {
      log('Error---->> $e');
    }

    // RemoteNotification notification = message.notification ion!;
  }

  ///call when click on notification back
  static void onMsgOpen() {
    try {
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        log('A new onMessageOpenedApp event was published!');
        log('listen->${message.data}');
        // FlutterRingtonePlayer.stop();

        if (message != null) {
          // log("action======1=== ${message?.data['action_click']}");
          log("action======2=== ${message.data['action_click']}");
        }
      });
    } on FirebaseException catch (e) {
      log('notification 2 ${e.message}');
    }
  }

  /// send notification device to device
  static Future<bool?> sendMessage({
    String? receiverFcmToken,
    String? msg,
    bool isRing = false,
  }) async {
    var serverKey =
        'AAAAHdl8g4g:APA91bFd4Jtck1AXgYDZSgTKSh7CbS41kSXA5Ht74HN74qXo-_lsSpPJrLhS2GdqcHf2IJEWM3uUKD3-V50gpemU9FDmZZkm2ZYZIVaQ_dZKq4oA9-VJY263y98pksdNdzT9iHrD8cUa';
    try {
      // for (String token in receiverFcmToken) {
      // log("RESPONSE TOKEN  $receiverFcmToken");

      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
        body: jsonEncode(
          <String, dynamic>{
            "priority": "high",
            'notification': <String, dynamic>{
              'body': msg ?? 'msg',
              'title': 'plusApp',
              'bodyLocKey': 'true',
              "content_available": true,
              // "sound": "iphone1.mp3"
            },
            'data': <String, dynamic>{
              'click_action': isRing,
              'id': '1',
              'status': 'done'
            },
            'android': {
              'notification': {
                'channel_id': 'high_importance_channel',
              },
            },
            'apns': {
              'headers': {
                // "apns-push-type":
                //     "background", // This line prevents background notification
                "apns-priority": "10",
              },
            },
            "webpush": {
              "headers": {"Urgency": "high"}
            },
            'to': receiverFcmToken,
          },
        ),
      );
      // log("RESPONSE CODE ${response.statusCode}");
      //
      // log("RESPONSE BODY ${response.body}");
      // return true}
    } catch (e) {
      log("error push notification");
      // return false;

    }
  }
}
