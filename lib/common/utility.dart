import 'package:flutter/material.dart';

class Utility {
  static String emailAddressValidationPattern = r"([a-zA-Z0-9_@.])";
  static String password = r"[a-zA-Z0-9#!_@$%^&*-]";
  static String emailText = "email";
  static String nameEmptyValidation = "Name is required";
  static String emailEmptyValidation = "Email is required";
  static String isRequired = " is required";
  static String kUserNameEmptyValidation = 'Please Enter Valid Email';
  static String kPasswordEmptyValidation = 'Please Enter Password';
  static String kPasswordLengthValidation = 'Must be more than 6 Characters';
  static String mobileNumberInValidValidation = "Mobile Number is required";
  static String alphabetSpaceValidationPattern = r"[a-zA-Z0-9 ]";
  static String digitsValidationPattern = r"[0-9]";
  static String privacyPolicyText =
      "It is a long established fact that a reader will be distracted by the readable content of a page when \n \nlooking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. \n \nMany desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. \n \nVarious versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).";
  static String passwordNotMatch =
      "Password and Conform password does not match!";
  static int kPasswordLength = 6;

  static String validateUserName(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    bool regex = new RegExp(pattern).hasMatch(value);
    if (value.isEmpty) {
      return kUserNameEmptyValidation;
    } else if (regex == false) {
      return kUserNameEmptyValidation;
    }
    return null;
  }

  static String validatePassword(String value) {
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    // RegExp regex = new RegExp(pattern);
    print(value);
    if (value.isEmpty) {
      return kPasswordEmptyValidation;
    } else if (value.length < kPasswordLength) {
      return kPasswordLengthValidation;
    }
    return null;
  }

  static void showLoading(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text("Loading...")
                      ])));
        });
  }

  static void hideLoading(context) {
    Navigator.pop(context); //pop dialog
  }

  static bool isNullOrEmpty(String txt) {
    return txt == null || txt.isEmpty || txt == "" || txt == "null";
  }

  static String checkNSetData(String txt) {
    return !isNullOrEmpty(txt) ? txt : "";
  }
}
