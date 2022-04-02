import 'package:book_buy_and_sell/ChatUi/views/chatrooms.dart';
import 'package:book_buy_and_sell/UI/Activities/Login.dart';
import 'package:book_buy_and_sell/UI/Activities/MainScreen.dart';
import 'package:book_buy_and_sell/viewModel/account_view_model.dart';
import 'package:book_buy_and_sell/viewModel/image_upload_view_model.dart';
import 'package:book_buy_and_sell/viewModel/login_view_model.dart';
import 'package:book_buy_and_sell/viewModel/register_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

import 'ChatUi/views/search.dart';
import 'UI/Activities/OtpScreen.dart';
import 'UI/test.dart';
import 'Utils/helper/helperfunctions.dart';
import 'common/preference_manager.dart';
import 'model/services/AppNotification.dart';
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  configLoading();
  FirebaseMessaging.onBackgroundMessage(
      AppNotificationHandler.firebaseMessagingBackgroundHandler);

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  IOSInitializationSettings initializationSettings = IOSInitializationSettings(
      requestAlertPermission: true,
      requestSoundPermission: true,
      requestBadgePermission: true);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(AppNotificationHandler.channel);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      IOSFlutterLocalNotificationsPlugin>()
      ?.initialize(initializationSettings);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
    alert: true,
    badge: true,
    sound: true,
  );

  // Update the iOS foreground notification presentation options to allow
  // heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  ///Get FCM Token..
  await AppNotificationHandler.getFcmToken();

  runApp(BookBuySell());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.blue, // navigation bar color
      statusBarColor: Colors.grey[300], // status bar color
      statusBarBrightness: Brightness.dark,//status bar brigtness
      statusBarIconBrightness:Brightness.dark , //status barIcon Brightness
      systemNavigationBarDividerColor: Colors.greenAccent,//Navigation bar divider color
      systemNavigationBarIconBrightness: Brightness.light)); //navigation bar icon
}
var fcmtoken;
const kGoogleApiKey =  "AIzaSyCbOKNtOA92bs4we0Owf1g6kGKRBKljQQM";

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}
class BookBuySell extends StatefulWidget {
  @override
  _BookBuySellState createState() => _BookBuySellState();
}

class _BookBuySellState extends State<BookBuySell> {
  bool userIsLoggedIn;

  FirebaseMessaging messaging;
@override
  void initState() {
  AppNotificationHandler.getInitialMsg();
  AppNotificationHandler.showMsgHandler();
  AppNotificationHandler.onMsgOpen();
  Firebase.initializeApp().whenComplete(() {
    print("completed");
    setState(() {});
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) async {
      print("fcm" + value);
      fcmtoken = value;
   // PreferenceManager.setfirebasetoken(value);
    PreferenceManager.setfirebasetokennotif(value);


    });
  });
  FirebaseMessaging.onMessage.listen((RemoteMessage event) {

    // notifpermission();
    print("message recieved"+event.notification.body);
    Vibration.vibrate(duration: 3000);
    HapticFeedback.vibrate();

    // showSimpleNotification(
    //
    //   Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //
    //     Row(
    //       children: [
    //         Container(
    //           height: 50,
    //           width: 60,
    //           child: Image.asset("assets/icons/applogo.png"),
    //         ),
    //         Text( "Apni Stationary",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),),
    //       ],
    //     ),
    //     Text( event.notification.body,style: TextStyle(color: Colors.black,)),
    //   ],),
    //   background: Colors.white,
    //   slideDismiss: true,
    //   autoDismiss: false,
    //   elevation: 4,
    //
    //
    // );

  });
  getLoggedInState();

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: GetMaterialApp(


        debugShowCheckedModeBanner: false,
        title: 'Book Buy & Sell',
        theme: ThemeData(fontFamily: 'Helvetica'),
        home:    PreferenceManager.getEmailId()==null?LoginScreen():MainScreen()
      ),
    );
  }
  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn  = value;
      });
    });
  }
  LoginViewModel loginViewModel = Get.put(LoginViewModel());

  RegisterViewModel registerViewModel = Get.put(RegisterViewModel());

  ImageUploadViewModel imageUploadViewModel = Get.put(ImageUploadViewModel());

  AccountViewModel accountViewModel = Get.put(AccountViewModel());
}
