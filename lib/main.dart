import 'package:book_buy_and_sell/ChatUi/views/chatrooms.dart';
import 'package:book_buy_and_sell/UI/Activities/Login.dart';
import 'package:book_buy_and_sell/UI/Activities/MainScreen.dart';
import 'package:book_buy_and_sell/viewModel/account_view_model.dart';
import 'package:book_buy_and_sell/viewModel/image_upload_view_model.dart';
import 'package:book_buy_and_sell/viewModel/login_view_model.dart';
import 'package:book_buy_and_sell/viewModel/register_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'ChatUi/views/search.dart';
import 'Utils/helper/helperfunctions.dart';
import 'common/preference_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  configLoading();
  runApp(BookBuySell());
}
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
@override
  void initState() {
  getLoggedInState();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Book Buy & Sell',
      theme: ThemeData(fontFamily: 'Helvetica'),
      home:    PreferenceManager.getEmailId()==null?LoginScreen():MainScreen()
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
