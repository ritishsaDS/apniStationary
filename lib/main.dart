import 'package:book_buy_and_sell/UI/Activities/Login.dart';
import 'package:book_buy_and_sell/viewModel/account_view_model.dart';
import 'package:book_buy_and_sell/viewModel/image_upload_view_model.dart';
import 'package:book_buy_and_sell/viewModel/login_view_model.dart';
import 'package:book_buy_and_sell/viewModel/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  ///Get storage initialize
  await GetStorage.init();
  runApp(BookBuySell());
}

class BookBuySell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Buy & Sell',
      theme: ThemeData(fontFamily: 'Poppins'),
      home: LoginScreen(),
    );
  }

  LoginViewModel loginViewModel = Get.put(LoginViewModel());
  RegisterViewModel registerViewModel = Get.put(RegisterViewModel());
  ImageUploadViewModel imageUploadViewModel = Get.put(ImageUploadViewModel());
  AccountViewModel accountViewModel = Get.put(AccountViewModel());
}
