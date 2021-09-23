import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/common/color_picker.dart';
import 'package:book_buy_and_sell/common/utility.dart';
import 'package:book_buy_and_sell/viewModel/validation_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

class CommanWidget {
  static ValidationViewModel validationController =
      Get.put(ValidationViewModel());
  static InputBorder outLineGrey = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(
      color: Color(colorBlue),
    ),
  );
  static InputBorder outLineRed = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        color: Colors.red,
      ));

  static sizedBox25() {
    return SizedBox(
      height: 25,
    );
  }

  static sizedBox50() {
    return SizedBox(
      height: 50,
    );
  }

  static sizedBox20() {
    return SizedBox(
      height: 20,
    );
  }

  static sizedBox6_5() {
    return SizedBox(height: Get.width / 6.5);
  }

  static sizedBoxD3() {
    return SizedBox(
      height: Get.width / 3,
    );
  }

  static sizedBox15() {
    return SizedBox(
      height: 15,
    );
  }

  static sizedBox10() {
    return SizedBox(
      height: 10,
    );
  }

  static sizedBox5() {
    return SizedBox(
      height: 5,
    );
  }

  static getTextFormField(
      {TextEditingController textEditingController,
      bool isValidate,
      Function function,
      FocusNode focusNode,
      bool isReadOnly = false,
      bool isEnable,
      TextInputType textInputType,
      String validationType,
      String regularExpression,
      int inputLength,
      String hintText,
      String isIcon,
      String validationMessage,
      String iconPath,
      int maxLine,
      IconData icon,
      Widget sIcon,
      Function obscureOnTap,
      bool obscureValue = false,
      Function onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // height: 40,
          // color: Colors.lightGreen,
          child: Stack(
            children: [
              TextFormField(
                obscureText: obscureValue,
                onFieldSubmitted: function,
                focusNode: focusNode,
                readOnly: isReadOnly,
                showCursor: !isReadOnly,
                keyboardType: textInputType,
                onTap: onTap,
                maxLines: maxLine == null ? 1 : maxLine,
                controller: textEditingController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(inputLength),
                  FilteringTextInputFormatter.allow(RegExp(regularExpression))
                ],
                enabled: isEnable != null ? isEnable : true,

                style: TextStyle(
                    color: isEnable != null ? Colors.black : Colors.black,
                    fontSize: Get.height * 0.019),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  focusedBorder: outLineGrey,
                  enabledBorder: outLineGrey,
                  isDense: true,
                  isCollapsed: true,
                  contentPadding: EdgeInsets.only(
                      top: Get.height * 0.016,
                      bottom: Get.height * 0.016,
                      left: 20),
                  errorBorder: outLineRed,
                  focusedErrorBorder: outLineRed,
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: Color(hintGrey),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                /* obscureText:
                    validationType == 'password' ? obscureValue : false,*/
              ),
              Positioned(
                  right: 10, top: 0, bottom: 0, child: sIcon ?? SizedBox())
            ],
          ),
        ),
      ],
    );
  }
}
