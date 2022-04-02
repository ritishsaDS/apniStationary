import 'dart:convert';
import 'dart:developer';

import 'package:book_buy_and_sell/ChatUi/views/chat.dart';
import 'package:book_buy_and_sell/UI/Activities/MainScreen.dart';
import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class AppNotificationHandler {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  new FlutterLocalNotificationsPlugin();
  static AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  ///get fcm token
  static Future<String> getFcmToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    try {
      String token = await firebaseMessaging.getToken();
      // await PreferenceManager.setFCMToken(token);
      log("=========fcm-token===$token");
      return token;
    } catch (e) {
      log("=========fcm- Error :$e");
      return null;
    }
  }

  ///call when app in fore ground
  static void showMsgHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;


      if (notification != null && android != null) {
        showMsg(notification);
      }
    });
  }

  /// handle notification when app in fore ground..
  static void getInitialMsg() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {

      if (message != null) {
        if (message.data.containsKey('data')) {

          Map<String, dynamic> data = jsonDecode(message.data['data']);


        } else {
          Get.to(MainScreen());
        }
      }
    });
  }

  static void onMsgOpen() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {

      print('onMsgOpen A new onMessageOpenedApp event was published!');
      if (message != null) {
        if (message.data.containsKey('data')) {
          print('Data:${message.data}');
          print('TYPE:${message.data['data'].runtimeType}');
          Map<String, dynamic> data = jsonDecode(message.data['data']);

        } else {

        }
      }
    });
  }

  ///show notification msg
  static void showMsg(RemoteNotification notification) {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel', // id
            'High Importance Notifications', // title
            'This channel is used for important notifications.',
            // description
            importance: Importance.high,
            playSound: true,
sound: RawResourceAndroidNotificationSound('soundfxmeloboom'),
            icon: '@drawable/launcher_icon',
          ),
        ));
  }

  ///background notification handler..
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Handling a background message ${message.messageId}');
  }

  ///SEND NOTIFICATION FROM ONE DEVICE TO ANOTHER DEVICE...
  static Future<bool> sendMessage(
      {String msg, String token, Map<String, dynamic> data}) async {
    print("==========="+data.toString());
    var serverKey =
        "AAAA4SFG2Sc:APA91bFUxtmCjcW7coAw_sHxXDmmi3YBbstT-nk9DFlNFx9n3Qk0phR2rVNZbzdB-IQ5GCgSiNPTDXTxBf4eLVeDfZBZZQjqII3nzMW-IUmTV0mZ-hvvs3fXvr7WAAXccbsDSiz20bfD";
    print("TOKEN $token");
    try {
      http.Response response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': msg,
              'title':
              "${PreferenceManager.getName()} "
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
              'data': data
            },
            'to': token,
          },
        ),
      );
      log("RESPONSE CODE 1 ${response.statusCode}");
      log("RESPONSE CODE 1 ${jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': msg,
            'title':
            "${PreferenceManager.getName()}"
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
            'data': data
          },
          'to': token,
        },
      )}");

      log("RESPONSE BODY 1${response.body}");
    } catch (e) {
      print("error push notification");
    }
  }
}