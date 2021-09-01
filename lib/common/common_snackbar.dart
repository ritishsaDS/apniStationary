import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/common/color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonSnackBar {
  static void snackBar({
    String message,
  }) {
    Get.showSnackbar(GetBar(
      padding: EdgeInsets.only(bottom: 10, left: 20),
      messageText: Text(
        "$message",
        style: TextStyle(color: Colors.white),
      ),
      title: '',
      duration: Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Color(colorBlue),
    ));
  }
}
