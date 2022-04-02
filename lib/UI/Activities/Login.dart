import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/UI/Activities/BookDetails.dart';
import 'package:book_buy_and_sell/UI/Activities/ForgotPassword.dart';
import 'package:book_buy_and_sell/UI/Activities/MainScreen.dart';
import 'package:book_buy_and_sell/UI/Activities/SignUp.dart';
import 'package:book_buy_and_sell/Utils/Dialog.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/Utils/helper/helperfunctions.dart';
import 'package:book_buy_and_sell/Utils/services/auth.dart';

import 'package:book_buy_and_sell/common/common_snackbar.dart';
import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:book_buy_and_sell/common/utility.dart';
import 'package:book_buy_and_sell/model/apiModel/requestModel/login_request_model.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/login_response_model.dart';
import 'package:book_buy_and_sell/model/apis/api_response.dart';
import 'package:book_buy_and_sell/viewModel/login_view_model.dart';
import 'package:book_buy_and_sell/viewModel/validation_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:overlay_support/overlay_support.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  bool showpwd = true;
  final GlobalKey<State> loginLoader = new GlobalKey<State>();
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
  FirebaseMessaging _fcm;
   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
   AndroidNotificationChannel channel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    //
    //   // notifpermission();
    //   print("message recieved"+event.notification.body);
    //   showSimpleNotification(
    //     Column(children: [
    //       Text( event.notification.title,),
    //       Text( event.notification.body,),
    //     ],),
    //     background: Colors.purple,
    //   );
    //
    // });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {

        flutterLocalNotificationsPlugin.show(

          notification.hashCode,
          notification.title,
          notification.body,

          NotificationDetails(

            android: AndroidNotificationDetails(
              "33",
              channel.name,
              channel.description,
              icon: 'launch_background',
            playSound: true,
              sound: RawResourceAndroidNotificationSound("a_long_cold_sting"),
              importance: Importance.high,

            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');

    });

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
    return WillPopScope(
      onWillPop: (){
        print("jvukj");

        // SystemNavigator.pop();
      },
      child: SafeArea(

          child: Scaffold(

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
                            Container(
                              height: SizeConfig.blockSizeVertical*10,
                              child: TextFormField(
                                controller:emailController ,
                                focusNode: usernameFn,
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
                                  hintText: "Enter Email",
                                  hintStyle: TextStyle(
                                    color: Color(hintGrey),
                                    fontWeight: FontWeight.w500,

                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   height: Get.height * 0.03,
                            // ),
                           Container(
                             height: SizeConfig.blockSizeVertical*10,
                             child: TextFormField(
                                 focusNode: pwdFn,
                                 controller: passwordController,
                                 textInputAction: TextInputAction.done,
                                 onFieldSubmitted: (val){
                                   signinapihit();
                                   //_fieldFocusChange(context);
                                 },
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
                           ),

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
                                    _fcm = FirebaseMessaging.instance;
                                    // _fcm(
                                    //   onMessage: (Map<String, dynamic> message) async {
                                    //     print("onMessage: $message");
                                    //     showOverlayNotification((context) {
                                    //       return Card(
                                    //         margin: const EdgeInsets.symmetric(horizontal: 4),
                                    //         child: SafeArea(
                                    //           child: ListTile(
                                    //             leading: SizedBox.fromSize(
                                    //                 size: const Size(40, 40),
                                    //                 child: ClipOval(
                                    //                     child: Container(
                                    //                       color: Colors.black,
                                    //                     ))),
                                    //             title: Text(message['notification']['title']),
                                    //             subtitle: Text(message['notification']['body']),
                                    //             trailing: IconButton(
                                    //                 icon: Icon(Icons.close),
                                    //                 onPressed: () {
                                    //                   OverlaySupportEntry.of(context).dismiss();
                                    //                 }),
                                    //           ),
                                    //         ),
                                    //       );
                                    //     }, duration: Duration(milliseconds: 4000));
                                    //
                                    //     print(message['notification']['title']);
                                    //   },
                                    //   onLaunch: (Map<String, dynamic> message) async {
                                    //     print("onLaunch: $message");
                                    //   },
                                    //   onResume: (Map<String, dynamic> message) async {
                                    //     print("onResume: $message");
                                    //   },
                                    // );
                                   signinapihit();
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
                        return  Container(

                        );
                        } else {
                          return SizedBox();
                        }
                      },
                    )
                  ],
                ),
               Expanded(child:  SizedBox())
              ],

          ),
        ),
      )),
    );
  }
  signinapihit() async {
    if (loginFormKey.currentState.validate()) {
      Dialogs.showLoadingDialog(context, loginLoader);
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
            await PreferenceManager.setfirebaseid(
                response.user.user_firebase_id);
           await PreferenceManager.setcollge(response.user.college_name);
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
            Navigator.of(loginLoader.currentContext, rootNavigator: true).pop();

            showAlert(context, response.message);
          }
        }
        else {
          Navigator.of(loginLoader.currentContext, rootNavigator: true).pop();

          showAlert(context,
              'Invalid Email and Password.');
        }
      } else {
        Navigator.of(loginLoader.currentContext, rootNavigator: true).pop();

        showAlert(context, 'Invalid Email and Password.');
      }
    } else {
      Navigator.of(loginLoader.currentContext, rootNavigator: true).pop();

      showAlert(context,
          'Please enter email and password');
    }
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
        print("jknfjkvnno");
        if(userCredential!=null){
          print("----------"+userCredential.user.uid.toString());
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
            PreferenceManager.getName());
          HelperFunctions.saveUserEmailSharedPreference(
              PreferenceManager.getEmailId());
          showAlert(context, message);
          Navigator.of(loginLoader.currentContext, rootNavigator: true).pop();
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>MainScreen()));
          // Future.delayed(Duration(milliseconds: 100),
          //         () {
          //       Get.offAll(MainScreen());
          //       emailController.clear();
          //       passwordController.clear();
          //     });
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print("jkndajon");
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
