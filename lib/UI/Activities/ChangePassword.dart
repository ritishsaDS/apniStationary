import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/common/common_snackbar.dart';
import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:book_buy_and_sell/common/utility.dart';
import 'package:book_buy_and_sell/common/validation_widget.dart';
import 'package:book_buy_and_sell/model/apiModel/requestModel/change_password_request_model.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/change_password_response_model.dart';
import 'package:book_buy_and_sell/model/apis/api_response.dart';
import 'package:book_buy_and_sell/viewModel/account_view_model.dart';
import 'package:book_buy_and_sell/viewModel/validation_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  ValidationViewModel validationController = Get.put(ValidationViewModel());
  GlobalKey<FormState> changePasswordForm = GlobalKey<FormState>();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode pwdFn = FocusNode();
  FocusNode newPwdFn = FocusNode();
  FocusNode confirmPwdFn = FocusNode();
  @override
  void initState() {
    pwdFn = FocusNode();
    newPwdFn = FocusNode();
    confirmPwdFn = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(backgroundColor),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.02,
                    vertical: SizeConfig.blockSizeVertical * 2),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: ImageIcon(
                        AssetImage('assets/icons/back.png'),
                        color: Color(colorBlue),
                        size: SizeConfig.blockSizeVertical * 4,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 5,
                          right: SizeConfig.screenWidth * 0.35),
                      child: Text(
                        "Change Password",
                        style: TextStyle(color: Color(black)),
                      ),
                    ),
                    Spacer(),
                    ImageIcon(
                      AssetImage('assets/icons/notification.png'),
                      color: Color(colorBlue),
                      size: SizeConfig.blockSizeVertical * 4,
                    )
                  ],
                ),
              ),
              Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * 0.3,
                  alignment: Alignment.center,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                          'assets/icons/applogo.png',
                          scale: 8
                      ),

                    ],
                  )),
              Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical * 2),
                alignment: Alignment.center,
                child: Text(
                  "Change Password",
                  style: TextStyle(
                      color: Color(colorBlue),
                      fontWeight: FontWeight.w600,
                      fontSize: SizeConfig.blockSizeVertical * 3),
                ),
              ),
              Stack(
                children: [
                  Form(
                    key: changePasswordForm,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.08,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          CommanWidget.getTextFormField(
                            obscureValue: true,
                            focusNode: pwdFn,
                            function: (value) {
                              pwdFn.unfocus();
                              FocusScope.of(context).requestFocus(newPwdFn);
                            },
                            textEditingController: oldPasswordController,
                            inputLength: 10,
                            regularExpression: Utility.password,
                            validationMessage: "Old Password is required",
                            validationType: 'password',
                            hintText: "Old Password",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CommanWidget.getTextFormField(
                            obscureValue: true,
                            focusNode: newPwdFn,
                            function: (value) {
                              newPwdFn.unfocus();
                              FocusScope.of(context).requestFocus(confirmPwdFn);
                            },
                            textEditingController: newPasswordController,
                            inputLength: 10,
                            regularExpression: Utility.password,
                            validationMessage: "New Password is required",
                            validationType: 'password',
                            hintText: "New Password",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CommanWidget.getTextFormField(
                            obscureValue: true,
                            focusNode: confirmPwdFn,
                            function: (value) {
                              confirmPwdFn.unfocus();
                            },
                            textEditingController: confirmPasswordController,
                            inputLength: 10,
                            regularExpression: Utility.password,
                            validationMessage: "Confirm Password is required",
                            validationType: 'password',
                            hintText: "Confirm Password",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Container(
                              width: SizeConfig.screenWidth * 0.5,
                              height: SizeConfig.blockSizeVertical * 5,
                              margin: EdgeInsets.only(
                                  left: SizeConfig.screenWidth * 0.1,
                                  right: SizeConfig.screenWidth * 0.1,
                                  top: SizeConfig.blockSizeVertical * 3,
                                  bottom: SizeConfig.blockSizeVertical),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(gradientColor1),
                                    Color(gradientColor2),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: MaterialButton(
                                onPressed: () async {
                                  if (changePasswordForm.currentState
                                      .validate()) {
                                    if (newPasswordController.text !=
                                        confirmPasswordController.text) {
                                      CommonSnackBar.snackBar(
                                          message:
                                              'new password and confirm password not match');
                                      return;
                                    }
                                    AccountViewModel accountViewModel =
                                        Get.find();
                                    ChangePasswordReq changePasswordReq =
                                        ChangePasswordReq();
                                    changePasswordReq.userId =
                                        PreferenceManager.getUserId()
                                            .toString();
                                    changePasswordReq.oldPassword =
                                        oldPasswordController.text;
                                    changePasswordReq.newPassword =
                                        newPasswordController.text;
                                    changePasswordReq.confirmPassword =
                                        confirmPasswordController.text;
                                    changePasswordReq.sessionKey =
                                        PreferenceManager.getSessionKey();
                                    await accountViewModel
                                        .changePassword(changePasswordReq);
                                    if (accountViewModel
                                            .changePasswordApiResponse.status ==
                                        Status.COMPLETE) {
                                      ChangePasswordResponseModel response =
                                          accountViewModel
                                              .changePasswordApiResponse.data;
                                      if (response.status == '200') {
                                        if (response.message ==
                                            'Password updated successfully') {

                                          CommonSnackBar.snackBar(
                                              message: response.message);
                                          _changePassword();
                                          Future.delayed(Duration(seconds: 2),
                                              () {
                                            Get.back();
                                            oldPasswordController.clear();
                                            newPasswordController.clear();
                                            confirmPasswordController.clear();
                                          });
                                        }
                                        else if(response.message=="oldpassword are not same"){

                                          CommonSnackBar.snackBar(
                                              message: "Old Password is not Correct");
                                        }
                                        else {

                                          CommonSnackBar.snackBar(
                                              message: response.message);
                                        }
                                      }
                                      else if(response.message=="oldpassword are not same."){
                                        print("jngnrg");
                                        CommonSnackBar.snackBar(
                                            message: "Old Password is not Correct");
                                      }else {

                                        CommonSnackBar.snackBar(
                                            message: response.message);
                                      }
                                    } else {
                                      CommonSnackBar.snackBar(
                                          message: 'Server error');
                                    }
                                  } else {
                                    CommonSnackBar.snackBar(
                                        message: 'please enter password');
                                  }
                                },
                                child: Text(
                                  "Change Password",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GetBuilder<AccountViewModel>(
                    builder: (controller) {
                      if (controller.changePasswordApiResponse.status ==
                          Status.LOADING) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return SizedBox();
                      }
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _changePassword() async {
    var user = await FirebaseAuth.instance.currentUser;
    String email = user.email;

    //Create field for user to input old password

    //pass the password here
    String password = "123456";
    String newPassword = confirmPasswordController.text;

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      user.updatePassword(newPassword).then((_){
        print("Successfully changed password");
      }).catchError((error){
        print("Password can't be changed" + error.toString());
        //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
