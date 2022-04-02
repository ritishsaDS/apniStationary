import 'dart:convert';

import 'package:book_buy_and_sell/UI/Activities/Login.dart';
import 'package:book_buy_and_sell/UI/Activities/MainScreen.dart';
import 'package:book_buy_and_sell/Utils/ApiCall.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/Utils/constantString.dart';
import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:book_buy_and_sell/common/validation_widget.dart';
import 'package:book_buy_and_sell/model/apiModel/requestModel/change_password_request_model.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/change_password_response_model.dart';
import 'package:book_buy_and_sell/model/apis/api_response.dart';
import 'package:book_buy_and_sell/viewModel/account_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import 'BookDetails.dart';

class ForgotPassword2 extends StatefulWidget {
  var email;
   ForgotPassword2({this.email});

  @override
  _ForgotPassword2State createState() => _ForgotPassword2State();
}

class _ForgotPassword2State extends State<ForgotPassword2> {

  GlobalKey<FormState> forgotFormKey = GlobalKey<FormState>();
  TextEditingController pwd = TextEditingController();
  TextEditingController cpwd = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
bool isError = false;

 bool  isLoading = false;
  FocusNode pwdFn;
  FocusNode cPwdFn;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pwdFn = FocusNode();
    cPwdFn = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    pwdFn.dispose();
    cPwdFn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
          backgroundColor: Color(backgroundColor),
          body: Container(
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/bg/loginbg.png'),fit: BoxFit.fill)),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.06),
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                        color: Color(colorBlue),
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.blockSizeVertical * 2.5),
                  ),
                ),
                Form(
                  key: forgotFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenWidth * 0.1,
                          vertical: SizeConfig.blockSizeVertical * 3,
                        ),
                        child: TextFormField(
                          controller: oldPasswordController,
                        //  focusNode: pwdFn,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          cursorColor: Color(colorBlue),
                          onFieldSubmitted: (value){
                          //  pwdFn.unfocus();
                           // FocusScope.of(context).requestFocus(cPwdFn);
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical * 1.5,
                                horizontal: SizeConfig.blockSizeHorizontal * 5
                            ),
                            hintText: "Enter  Password/Pin from your email",
                            hintStyle: TextStyle(
                              color: Color(hintGrey),
                              fontSize: 12,
                            ),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0XFFC4C4C4)
                                )
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0XFFC4C4C4)
                                )
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0XFFC4C4C4)
                                )
                            ),
                            disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0XFFC4C4C4)
                                )
                            ),
                            errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0XFFC4C4C4)
                                )
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0XFFC4C4C4)
                                )
                            ),
                          ),
                        ),
                      ),

                      Container(
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenWidth * 0.1,
                          vertical: SizeConfig.blockSizeVertical * 3,
                        ),
                        child: TextFormField(
                          controller: pwd,
                          focusNode: pwdFn,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          cursorColor: Color(colorBlue),
                          onFieldSubmitted: (value){
                            pwdFn.unfocus();
                            FocusScope.of(context).requestFocus(cPwdFn);
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical * 1.5,
                                horizontal: SizeConfig.blockSizeHorizontal * 5
                            ),
                            hintText: "Enter New Password",
                            hintStyle: TextStyle(
                              color: Color(hintGrey),
                              fontWeight: FontWeight.w500,
                            ),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0XFFC4C4C4)
                                )
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0XFFC4C4C4)
                                )
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0XFFC4C4C4)
                                )
                            ),
                            disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0XFFC4C4C4)
                                )
                            ),
                            errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0XFFC4C4C4)
                                )
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0XFFC4C4C4)
                                )
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenWidth * 0.1,
                          vertical: SizeConfig.blockSizeVertical,
                        ),
                        child: TextFormField(
                          controller: cpwd,
                          focusNode: cPwdFn,
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          cursorColor: Color(colorBlue),
                          onFieldSubmitted: (value){
                            cPwdFn.unfocus();
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical * 1.5,
                                horizontal: SizeConfig.blockSizeHorizontal * 5
                            ),
                            hintText: "Re-enter New Password",
                            hintStyle: TextStyle(
                              color: Color(hintGrey),
                              fontWeight: FontWeight.w500,
                            ),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0XFFC4C4C4)
                                )
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0XFFC4C4C4)
                                )
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0XFFC4C4C4)
                                )
                            ),
                            disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0XFFC4C4C4)
                                )
                            ),
                            errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0XFFC4C4C4)
                                )
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0XFFC4C4C4)
                                )
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: SizeConfig.screenWidth * 0.5,
                          height: SizeConfig.blockSizeVertical * 5,
                          margin: EdgeInsets.only(
                              left: SizeConfig.screenWidth * 0.1,
                              right: SizeConfig.screenWidth * 0.1,
                              top: SizeConfig.blockSizeVertical * 3,
                              bottom: SizeConfig.blockSizeVertical
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: MaterialButton(
                            onPressed: () async {
                              if (forgotFormKey.currentState
                                  .validate()) {
                                if (cpwd.text !=
                                    pwd.text) {
                                  showAlert(context,
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
                                    pwd.text;
                                changePasswordReq.confirmPassword =
                                    cpwd.text;
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

                                     // showAlert(context, response.message);
                                      _changePassword();

                                    }
                                    else if(response.message=="oldpassword are not same"){

                                      showAlert(context, "Old Password is not Correct");
                                    }
                                    else {

                                      showAlert(context, response.message);
                                    }
                                  }
                                  else if(response.message=="oldpassword are not same."){
                                    print("jngnrg");
                                    showAlert(context, "Old Password is not Correct");
                                  }else {

                                    showAlert(context, response.message);
                                  }
                                } else {
                                  showAlert(context, 'Server error');
                                }
                              } else {
                                showAlert(context, 'please enter password');
                              }

                            },
                            child: Text("Change Password",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)
                            ),
                            color: Color(colorBlue),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
  void _changePassword() async {
    print("ljhroeoewe");
    var user = await FirebaseAuth.instance.currentUser;
    String email = widget.email;

    //Create field for user to input old password

    //pass the password here
    String password = pwd.text;
    String newPassword = cpwd.text;

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      user.updatePassword(newPassword).then((_){
        print("Successfully changed password");
        showAlert(context, "Successfully changed password");
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return LoginScreen();
        }));
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
