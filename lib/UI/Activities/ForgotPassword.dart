import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/UI/Activities/ForgotPassword2.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/common/common_snackbar.dart';
import 'package:book_buy_and_sell/common/utility.dart';
import 'package:book_buy_and_sell/model/apiModel/requestModel/forgot_password_request_model.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/forgot_password_response_model.dart';
import 'package:book_buy_and_sell/model/apis/api_response.dart';
import 'package:book_buy_and_sell/viewModel/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  GlobalKey<FormState> forgotFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController otp = TextEditingController();

  FocusNode phnFn;
  FocusNode otpFn;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    phnFn = FocusNode();
    otpFn = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    phnFn.dispose();
    otpFn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(backgroundColor),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight * 0.3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(gradientColor1),
                    Color(gradientColor2),
                  ]),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        child: ImageIcon(
                          AssetImage('assets/icons/back.png'),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.all(12),
                      ),
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      alignment: Alignment.center,
                      margin:
                          EdgeInsets.only(top: SizeConfig.screenHeight * 0.05),
                      child: Image.asset(
                        'assets/bg/logo.png',
                        scale: SizeConfig.blockSizeVertical * 0.6,
                      ),
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      alignment: Alignment.center,
                      child: Text(
                        "App Name",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: SizeConfig.blockSizeVertical * 2),
                      ),
                    )
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
                      validator: (value) {
                        Pattern pattern =
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                        bool regex = new RegExp(pattern).hasMatch(value);
                        if (value.isEmpty) {
                          return Utility.kUserNameEmptyValidation;
                        } else if (regex == false) {
                          return Utility.kUserNameEmptyValidation;
                        }
                        return null;
                      },
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      cursorColor: Color(colorBlue),
                      decoration: InputDecoration(
                        isDense: true,
                        suffixIconConstraints: BoxConstraints(
                            minHeight: SizeConfig.blockSizeVertical * 4,
                            maxHeight: SizeConfig.blockSizeVertical * 4),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical * 1.5,
                            horizontal: SizeConfig.blockSizeHorizontal * 5),
                        hintText: "Enter email",
                        hintStyle: TextStyle(
                          color: Color(hintGrey),
                          fontWeight: FontWeight.w500,
                        ),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFFC4C4C4))),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFFC4C4C4))),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFFC4C4C4))),
                        disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFFC4C4C4))),
                        errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFFC4C4C4))),
                        focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFFC4C4C4))),
                      ),
                    ),
                  ),
                  /*    Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.1,
                      vertical: SizeConfig.blockSizeVertical * 3,
                    ),
                    child: TextFormField(
                      controller: phn,
                      focusNode: phnFn,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      cursorColor: Color(colorBlue),
                      onFieldSubmitted: (value) {
                        phnFn.unfocus();
                        FocusScope.of(context).requestFocus(otpFn);
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        suffixIcon: MaterialButton(
                          onPressed: () {},
                          child: Text(
                            "Send OTP",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          color: Color(colorBlue),
                        ),
                        suffixIconConstraints: BoxConstraints(
                            minHeight: SizeConfig.blockSizeVertical * 4,
                            maxHeight: SizeConfig.blockSizeVertical * 4),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical * 1.5,
                            horizontal: SizeConfig.blockSizeHorizontal * 5),
                        hintText: "Enter Phone No.",
                        hintStyle: TextStyle(
                          color: Color(hintGrey),
                          fontWeight: FontWeight.w500,
                        ),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFFC4C4C4))),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFFC4C4C4))),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFFC4C4C4))),
                        disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFFC4C4C4))),
                        errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFFC4C4C4))),
                        focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFFC4C4C4))),
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
                      controller: otp,
                      focusNode: otpFn,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      cursorColor: Color(colorBlue),
                      onFieldSubmitted: (value) {
                        otpFn.unfocus();
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical * 1.5,
                            horizontal: SizeConfig.blockSizeHorizontal * 5),
                        hintText: "Enter OTP",
                        hintStyle: TextStyle(
                          color: Color(hintGrey),
                          fontWeight: FontWeight.w500,
                        ),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFFC4C4C4))),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFFC4C4C4))),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFFC4C4C4))),
                        disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFFC4C4C4))),
                        errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFFC4C4C4))),
                        focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFFC4C4C4))),
                      ),
                    ),
                  ),*/
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
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: MaterialButton(
                        onPressed: () async {
                          LoginViewModel loginViewModel = Get.find();
                          if (forgotFormKey.currentState.validate()) {
                            ForgotPasswordReq forgotPasswordReq =
                                ForgotPasswordReq();
                            forgotPasswordReq.email = emailController.text;
                            await loginViewModel
                                .forgotPassword(forgotPasswordReq);
                            if (loginViewModel
                                    .forgotPasswordApiResponse.status ==
                                Status.COMPLETE) {
                              ForgotPasswordResponseModel response =
                                  loginViewModel.forgotPasswordApiResponse.data;
                              if (response.status == '200') {
                                CommonSnackBar.snackBar(
                                    message: response.message);
                                Future.delayed(Duration(seconds: 2), () {
                                  Get.back();
                                  emailController.clear();
                                });
                              } else {
                                CommonSnackBar.snackBar(
                                    message: response.message);
                              }
                            } else {
                              CommonSnackBar.snackBar(message: 'Server error');
                            }
                          } else {
                            CommonSnackBar.snackBar(
                                message: 'Please enter email');
                          }
                          /* Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ForgotPassword2();
                          }));*/
                        },
                        child: Text(
                          "Forgot Now",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
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
}
