import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/UI/Activities/ForgotPassword.dart';
import 'package:book_buy_and_sell/UI/Activities/MainScreen.dart';
import 'package:book_buy_and_sell/UI/Activities/SignUp.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/Utils/helper/helperfunctions.dart';
import 'package:book_buy_and_sell/Utils/services/auth.dart';
import 'package:book_buy_and_sell/Utils/services/database.dart';

import 'package:book_buy_and_sell/common/common_snackbar.dart';
import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:book_buy_and_sell/common/utility.dart';
import 'package:book_buy_and_sell/common/validation_widget.dart';
import 'package:book_buy_and_sell/model/apiModel/requestModel/login_request_model.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/login_response_model.dart';
import 'package:book_buy_and_sell/model/apis/api_response.dart';
import 'package:book_buy_and_sell/viewModel/login_view_model.dart';
import 'package:book_buy_and_sell/viewModel/validation_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading=false;
  bool showpwd=true;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController =
      TextEditingController();
  TextEditingController passwordController =
      TextEditingController();
  AuthService authService = new AuthService();

  ValidationViewModel validationController = Get.put(ValidationViewModel());
  FocusNode usernameFn = FocusNode();
  FocusNode pwdFn = FocusNode();
  bool rememberMe = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    usernameFn = FocusNode();
    pwdFn = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    validationController.loginPasswordObscure = true.obs;
    usernameFn.dispose();
    pwdFn.dispose();
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
                "Sign in",
                style: TextStyle(
                    color: Color(colorBlue),
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.blockSizeVertical * 3),
              ),
            ),
            Stack(
              children: [
                Form(
                  key: loginFormKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.08,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommanWidget.getTextFormField(
                          focusNode: usernameFn,
                          function: (value) {
                            usernameFn.unfocus();
                            FocusScope.of(context).requestFocus(pwdFn);
                          },
                          textEditingController: emailController,
                          validationType: Utility.emailText,
                          hintText: "Email",
                          inputLength: 50,
                          regularExpression:
                              Utility.emailAddressValidationPattern,
                          validationMessage: Utility.emailEmptyValidation,
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                       TextFormField(
                           focusNode: pwdFn,
                           controller: passwordController,
                           inputFormatters: [
                             LengthLimitingTextInputFormatter(12),

                           ],
                           obscureText:showpwd ,
                           decoration: InputDecoration(
                             focusedBorder: outLineGrey,
                             enabledBorder: outLineGrey,
                             isDense: true,
                             suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye_rounded,color: !showpwd?Colors.blue:Colors.grey,),onPressed: (){
                               setState(() {
                                 if( showpwd==false){
                                   showpwd=true;
                                 }
                                 else{
                                   showpwd=false;
                                 }
                               });
                             },),
                             isCollapsed: true,
                             contentPadding: EdgeInsets.only(
                                 top: Get.height * 0.016,
                                 bottom: Get.height * 0.016,
                                 left: 20),
                             errorBorder: outLineRed,
                             focusedErrorBorder: outLineRed,
                             hintText: "Enter Password",

                             hintStyle: TextStyle(
                               color: Color(hintGrey),
                               fontWeight: FontWeight.w500,
                             ),),
                           validator: (value) {
                             if (value.length<5) {
                               return "Password must be more than 5 characters";
                             } else {
                               return null;
                             }}),

                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (rememberMe == true)
                                    setState(() {
                                      rememberMe = false;
                                    });
                                  else
                                    setState(() {
                                      rememberMe = true;
                                    });
                                },
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: rememberMe,
                                      onChanged: (value) {
                                        setState(() {
                                          rememberMe = value;
                                        });
                                      },
                                      activeColor: Color(colorBlue),
                                      checkColor: Colors.white,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    Text(
                                      "Remember Me",
                                      style: TextStyle(
                                          color: Color(matteBlack),
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              SizeConfig.blockSizeVertical *
                                                  1.75),
                                    )
                                  ],
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ForgotPassword();
                                  }));
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      color: Color(colorBlue),
                                      fontWeight: FontWeight.w800,
                                      fontSize:
                                          SizeConfig.blockSizeVertical * 1.75),
                                ),
                              )
                            ],
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
                                if (loginFormKey.currentState.validate()) {
                                  LoginViewModel loginViewModel = Get.find();
                                  LoginReq loginReq = LoginReq();
                                  loginReq.email = emailController.text;
                                  loginReq.password = passwordController.text;
                                  /* loginReq.deviceType = "";
                                  loginReq.deviceId = "";*/
                                  await loginViewModel.login(loginReq);
                                  if (loginViewModel.apiResponse.status ==
                                      Status.COMPLETE) {
                                    LoginResponseModel response =
                                        loginViewModel.apiResponse.data;
                                    if (response.status == '200') {
                                      if (response.message ==
                                          'Successfully logged in') {
                                        await PreferenceManager.setEmailId(
                                            '${response.user.email}');
                                        print(response.user.email);
                                        await PreferenceManager.setName(
                                            response.user.name);
                                        await PreferenceManager.setUserId(
                                            response.user.id);
                                        await PreferenceManager.setSessionKey(
                                            response.user.sessionKey);
                                        await PreferenceManager.setPhoneNo(
                                            response.user.number);
                                        await PreferenceManager.setImage(
                                            response.user.image);
                                        print("image:${response.user.image}");
                                        var emailId =
                                            PreferenceManager.getEmailId();
                                       signIn(response.message);

                                        print("email:$emailId");
                                        // CommonSnackBar.snackBar(
                                        //     message: response.message);
                                        //
                                        // Future.delayed(Duration(seconds: 2),
                                        //     () {
                                        //   Get.offAll(MainScreen());
                                        //   emailController.clear();
                                        //   passwordController.clear();
                                        // });
                                      } else {
                                        CommonSnackBar.snackBar(
                                            message: response.message);
                                      }
                                    } else {
                                      CommonSnackBar.snackBar(
                                          message:
                                              'Invalid Email and Password.');
                                    }
                                  } else {
                                    CommonSnackBar.snackBar(
                                        message: 'Invalid Email and Password.');
                                  }
                                } else {
                                  CommonSnackBar.snackBar(
                                      message:
                                          'Please enter email and password');
                                }
                              },
                              child: Text(
                                "Signin",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                            ),
                          ),
                        ),
                        Container(
                          width: SizeConfig.screenWidth,
                          margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * 0.05,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                    color: Color(matteBlack),
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                        SizeConfig.blockSizeVertical * 1.75),
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 1,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SignUp();
                                  }));
                                },
                                child: Text(
                                  "Signup Now",
                                  style: TextStyle(
                                      color: Color(colorBlue),
                                      fontWeight: FontWeight.w800,
                                      fontSize:
                                          SizeConfig.blockSizeVertical * 1.75),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GetBuilder<LoginViewModel>(
                  builder: (controller) {
                    if (controller.apiResponse.status == Status.LOADING) {
                      return Center(
                        child: new Container(
                          color: Colors.grey[300],
                          width: 150.0,
                          height: 150.0,
                          child: new Padding(padding: const EdgeInsets.all(5.0),child: new Center(child: new CircularProgressIndicator())),
                        ),
                      );
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
    ));
  }
  signIn(message) async {
    if (loginFormKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        if(userCredential!=null){
          print(userCredential);
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
            PreferenceManager.getName());
          HelperFunctions.saveUserEmailSharedPreference(
              PreferenceManager.getEmailId());
          CommonSnackBar.snackBar(
              message: message);
          Future.delayed(Duration(seconds: 2),
                  () {
                Get.offAll(MainScreen());
                emailController.clear();
                passwordController.clear();
              });
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }

          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (context) => ChatRoom()));


    }
  }
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
}
