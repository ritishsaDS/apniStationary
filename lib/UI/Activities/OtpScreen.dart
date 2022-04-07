import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:book_buy_and_sell/UI/Activities/SignUp.dart';
import 'package:book_buy_and_sell/Utils/Dialog.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/Utils/helper/helperfunctions.dart';
import 'package:book_buy_and_sell/Utils/services/auth.dart';
import 'package:book_buy_and_sell/Utils/services/database.dart';
import 'package:book_buy_and_sell/common/common_snackbar.dart';
import 'package:book_buy_and_sell/model/apiModel/requestModel/register_request_model.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/register_response_model.dart';
import 'package:book_buy_and_sell/model/apis/api_response.dart';
import 'package:book_buy_and_sell/model/services/AppNotification.dart';
import 'package:book_buy_and_sell/viewModel/image_upload_view_model.dart';
import 'package:book_buy_and_sell/viewModel/register_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import 'BookDetails.dart';
import 'Login.dart';

class Otp extends StatefulWidget {
  var email;
  var phone;
  var name;
  var college;
  var gender;
  var dob;
  var pass;
  var profession;
  File image;

  Otp(
      {this.name,
      this.phone,
      this.profession,
      this.college,
      this.gender,
      this.dob,
      this.pass,
      this.email,
      this.image});
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  Timer _timer;
  int _start = 120;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            verifyPhone();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final GlobalKey<State> loginLoader = new GlobalKey<State>();
  AuthService authService = new AuthService();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  String verificationId;
  String errorMessage = '';
  String smsOTP;
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    verifyPhone();
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        height: SizeConfig.screenHeight * 1,
        child: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: SizeConfig.screenHeight * 0.3,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/bg/clouds.png'),
                          fit: BoxFit.fitWidth)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.08,
                      ),
                      Text(
                        "Enter Verification Code",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 4,
                ),
                Center(
                    child: Text(
                  "Enter OTP ",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                )),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                Center(
                    child: Text(
                  "We have  sent an OTP on +91 ${widget.phone}",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                )),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 4,
                ),
//                 OtpTextField(
//                   numberOfFields: 6,
//                   borderColor: Color(0xFF512DA8),
//                   //set to true to show as box or false to show as dash
//                   showFieldAsBox: true,
// textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),
// filled: true,
//                   fillColor: Colors.blue,//runs when a code is typed in
//                   onCodeChanged: (String code) {
//                     setState(() {
//
//                     });
//                     //handle validation or checks here
//                   },
//                   //runs when every textfield is filled
//                   onSubmit: (String verificationCode){
//                     print("smsOTP");
//                     setState(() {
//                       smsOTP=verificationCode;
//                       print(smsOTP);
//                     });
//                     if (verificationCode.length != 6) {
//                             CommonSnackBar.snackBar(
//                                 message: "Please Enter valid Otp First");
//                           } else {
//                             signIn();
//
//                             if (_auth.currentUser != null) {
//                               // Navigator.push(context, MaterialPageRoute(builder: (context)=>NewPasswordCust(phone:phoneNo)));
//
//                               print("-------------------");
//                               // Navigator.of(context).pop();
//                               // Navigator.of(context).pushReplacementNamed('/homepage');
//                             } else {
//                               // Navigator.push(context, MaterialPageRoute(builder: (context)=>NewPasswordCust(phone:phoneNo)));
//
//                             }
//                           }
//
//                     ;
//                   }, // end onSubmit
//                 ),
                OTPTextField(
                  length: 6,
                  width: MediaQuery.of(context).size.width,
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldWidth: 50,
                  fieldStyle: FieldStyle.box,
                  outlineBorderRadius: 10,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    // color: Colors.white
                  ),
                  onChanged: (pin) {
                    print("Changed: " + pin);
                  },
                  onCompleted: (pin) {
                    print("Completed: " + pin);

                    smsOTP = pin;
                    print(smsOTP);
                    if (smsOTP.length != 6) {
                      CommonSnackBar.snackBar(
                          message: "Please Enter valid Otp First");
                    } else {
                      signIn();

                      if (_auth.currentUser != null) {
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>NewPasswordCust(phone:phoneNo)));

                        print("-------------------");
                        // Navigator.of(context).pop();
                        // Navigator.of(context).pushReplacementNamed('/homepage');
                      } else {
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>NewPasswordCust(phone:phoneNo)));

                      }
                    }
                  },
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 5,
                ),
                Container(
                    alignment: Alignment.center,
                    child: Text(
                        "OTP auto resend  ${_start.toString() == "0" ? "" : "in"} ${_start.toString() == "0" ? "" : _start.toString()} ${_start.toString() == "0" ? "" : "sec"}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold))),
                SizedBox(
                  height: 50,
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    if (smsOTP.length != 6) {
                      CommonSnackBar.snackBar(
                          message: "Please Enter valid Otp First");
                    } else {
                      signIn();

                      if (_auth.currentUser != null) {
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>NewPasswordCust(phone:phoneNo)));

                        print("-------------------");
                        // Navigator.of(context).pop();
                        // Navigator.of(context).pushReplacementNamed('/homepage');
                      } else {
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>NewPasswordCust(phone:phoneNo)));

                      }
                    }
                  },
                  child: Center(
                    child: Container(
                      width: 180,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0XFF5AD5F2)),
                      padding: EdgeInsets.only(right: 10),
                      child: Center(
                          child: Text(
                        "Verify",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      )),
                    ),
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Future<void> verifyPhone() async {
    // setState(() {
    //   isLoading=true;
    // });
    print(widget.phone);
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;

      // smsOTPDialog(context).then((value) {
      //   print('sign in');
      // });
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: "+91" + widget.phone, // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            this.verificationId = verId;
          },
          codeSent:
              smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 120),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential);
          },
          verificationFailed: (FirebaseAuthException exceptio) {
            print('${exceptio.message}');
          });
    } catch (e) {
      //handleError(e);
    }
  }

  callSignupApi(result, fcmToken) async {
    // context.loaderOverlay.show();
    setState(() {
      // isLoading = true;
    });

    // ImageUploadViewModel imaUploadViewModel = Get.find();

    final String baseURL = 'https://admin.apnistationary.com/api/';
    final String registerURL = 'sign-up';

    //create multipart request for POST or PATCH method
    var request =
        http.MultipartRequest("POST", Uri.parse(baseURL + registerURL));
    //add text fields
    request.fields['email'] = widget.email;
    request.fields['password'] = widget.pass;
    request.fields['name'] = widget.name;
    request.fields["profession"] = widget.profession;
    request.fields['number'] = widget.phone;
    request.fields['dob'] = widget.dob;
    request.fields['gender'] = widget.gender;
    request.fields['college_name'] = widget.college;
    request.fields['user_firebase_id'] = result + "," + fcmToken;

    try {
      if (widget.image != null) {
        //create multipart using filepath, string or bytes
        var pic = await http.MultipartFile.fromPath("image", widget.image.path);

        //add multipart to request
        request.files.add(pic);
      }
      var response = await request.send();

      //Get the response from the server
      var responseData = await response.stream.toBytes();
      Navigator.of(loginLoader.currentContext, rootNavigator: true).pop();

      setState(() {
        // isLoading = false;
      });

      var responseString = String.fromCharCodes(responseData);

      Map<String, dynamic> mapResponse = json.decode(responseString);
      RegisterResponseModel model = RegisterResponseModel.fromJson(mapResponse);

      if (model.status == '200') {
        print("jhbwefjhbeli");
        Navigator.of(loginLoader.currentContext, rootNavigator: true).pop();
        CommonSnackBar.snackBar(message: "SignUp Successfully");
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        });
      } else {
        showOtpAlert(context, model.message);
      }

      print(responseString);
    } catch (e) {
      Navigator.of(loginLoader.currentContext, rootNavigator: true).pop();

      print(e);
      setState(() {
        // isLoading = false;
      });
    }
  }

  signupapi(uid, fmc) async {
    ImageUploadViewModel imaUploadViewModel = Get.find();
    print("image selected${imaUploadViewModel.profilephoto}");

    // if (imaUploadViewModel.profilephoto == null) {
    //   showOtpAlert(context, "Please Upload Profile Picture ");
    //   return;
    // }
    RegisterViewModel registerViewModel = Get.find();

    RegisterReq registerReq = RegisterReq();
    registerReq.email = widget.email;
    registerReq.password = widget.pass;
    registerReq.name = widget.name;
    // registerReq.image = imaUploadViewModel.profilephoto==null?Uint8List.fromList('https://gnws.org/wp-content/uploads/2019/07/placeholder-1400x775.jpg'.codeUnits):imaUploadViewModel.profilephoto;
    registerReq.number = widget.phone;
    registerReq.dob = widget.dob;
    registerReq.profession = "profession.text";
    registerReq.user_firebase_id = uid + "," + fmc;
    registerReq.gender = widget.gender;
    registerReq.college_name = widget.college;
    await registerViewModel.register(registerReq);
    if (registerViewModel.apiResponse.status == Status.COMPLETE) {
      RegisterResponseModel response = registerViewModel.apiResponse.data;
      if (response.status == '200') {
        print("jhbwefjhbeli");
        Navigator.of(loginLoader.currentContext, rootNavigator: true).pop();
        CommonSnackBar.snackBar(message: "SignUp Successfully");
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        });
      } else {
        showOtpAlert(context, response.message);
      }
    } else {
      showOtpAlert(context, "Server Error");
    }
  }

  // Future<bool> smsOTPDialog(BuildContext context) {
  //   setState(() {});
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return new Dialog(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //           elevation: 0,
  //           backgroundColor: Colors.transparent,
  //           child: contentBox(context),
  //           // content: Container(
  //           //   height: 85,
  //           //   child: Column(children: [
  //           //     TextField(
  //           //       decoration: InputDecoration(
  //           //           focusedBorder: outLineGrey,
  //           //           enabledBorder: outLineGrey,
  //           //           isDense: true,
  //           //           isCollapsed: true,
  //           //           contentPadding: EdgeInsets.only(
  //           //               top: Get.height * 0.016,
  //           //               bottom: Get.height * 0.016,
  //           //               left: 20),
  //           //           errorBorder: outLineRed,
  //           //           focusedErrorBorder: outLineRed,
  //           //           hintText: "Enter Otp",
  //           //           hintStyle: TextStyle(
  //           //             color: Color(hintGrey),
  //           //             fontWeight: FontWeight.w500,
  //           //           )),
  //           //       onChanged: (value) {
  //           //         this.smsOTP = value;
  //           //       },
  //           //     ),
  //           //     (errorMessage != ''
  //           //         ? Text(
  //           //       errorMessage,
  //           //       style: TextStyle(color: Colors.red),
  //           //     )
  //           //         : Container())
  //           //   ]),
  //           // ),
  //           // contentPadding: EdgeInsets.all(10),
  //           // actions: <Widget>[
  //           //   FlatButton(
  //           //     child: Text('Done'),
  //           //     onPressed: () {
  //           //       if(smsOTP.length!=6){
  //           //        CommonSnackBar.snackBar(message:"Please Enter valid Otp First");
  //           //       }
  //           //     else{
  //           //         Navigator.pop(context);
  //           //         signIn();
  //           //
  //           //         if (_auth.currentUser != null) {
  //           //           // Navigator.push(context, MaterialPageRoute(builder: (context)=>NewPasswordCust(phone:phoneNo)));
  //           //
  //           //
  //           //           print("-------------------");
  //           //           // Navigator.of(context).pop();
  //           //           // Navigator.of(context).pushReplacementNamed('/homepage');
  //           //         } else {
  //           //           // Navigator.push(context, MaterialPageRoute(builder: (context)=>NewPasswordCust(phone:phoneNo)));
  //           //
  //           //
  //           //         }
  //           //       }
  //           //
  //           //     },
  //           //   )
  //           // ],
  //         );
  //       });
  // }

  // contentBox(context) {
  //   return Stack(
  //     children: <Widget>[
  //       Container(
  //         height: 220,
  //         padding: EdgeInsets.symmetric(vertical: 10),
  //         decoration: BoxDecoration(
  //             shape: BoxShape.rectangle,
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(15),
  //             boxShadow: [
  //               BoxShadow(
  //                   color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
  //             ]),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Container(
  //                 padding: EdgeInsets.only(left: 10, top: 20),
  //                 child: Text(
  //                   "Enter OTP",
  //                   style: TextStyle(fontSize: 20),
  //                 )),
  //             OTPTextField(
  //               length: 6,
  //               width: MediaQuery.of(context).size.width,
  //               textFieldAlignment: MainAxisAlignment.spaceAround,
  //               fieldWidth: 40,
  //               fieldStyle: FieldStyle.underline,
  //
  //               outlineBorderRadius: 30,
  //               style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
  //               onChanged: (pin) {
  //                 print("Changed: " + pin);
  //               },
  //               onCompleted: (pin) {
  //                 print("Completed: " + pin);
  //                 smsOTP = pin;
  //                 print(smsOTP);
  //               },
  //             ),
  //             SizedBox(
  //               height: 50,
  //             ),
  //             Container(
  //               padding: EdgeInsets.only(right: 10),
  //               alignment: Alignment.centerRight,
  //               child: RaisedButton(
  //                 color: Colors.blue,
  //                 onPressed: () {
  //                   if (smsOTP.length != 6) {
  //                     CommonSnackBar.snackBar(
  //                         message: "Please Enter valid Otp First");
  //                   } else {
  //                     // Navigator.pop(context);
  //                     signIn();
  //
  //                     if (_auth.currentUser != null) {
  //                       // Navigator.push(context, MaterialPageRoute(builder: (context)=>NewPasswordCust(phone:phoneNo)));
  //
  //                       print("-------------------");
  //                       // Navigator.of(context).pop();
  //                       // Navigator.of(context).pushReplacementNamed('/homepage');
  //                     } else {
  //                       // Navigator.push(context, MaterialPageRoute(builder: (context)=>NewPasswordCust(phone:phoneNo)));
  //
  //                     }
  //                   }
  //                 },
  //                 child: Text(
  //                   "Done",
  //                   style: TextStyle(color: Colors.white),
  //                 ),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  signIn() async {
    Dialogs.showLoadingDialog(context, loginLoader);
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final user = (await _auth.signInWithCredential(credential));
      final currentUser = await _auth.currentUser;
      assert(FirebaseAuth.instance.currentUser.uid == currentUser.uid);
      print("jkfnoonnjonn" + currentUser.toString());
      // _timer.stop();
      singUp();

      // Navigator.push(context, MaterialPageRoute(builder: (context)=>NewPasswordCust(phone:phoneNo)));
      //  Navigator.of(context).pushReplacementNamed('/homepage');
    } catch (e) {
      Navigator.of(loginLoader.currentContext, rootNavigator: true).pop();

      CommonSnackBar.snackBar(message: "Please Enter Correct OTP");

      print(e);
    }
  }

  singUp() async {
    Dialogs.showLoadingDialog(context, loginLoader);

    await authService
        .signUpWithEmailAndPassword(widget.email, widget.pass)
        .then((result) async {
      if (result != null) {
        print("+++++++++++" + result);

        Map<String, String> userDataMap = {
          "userName": widget.name,
          "userEmail": widget.email
        };

        databaseMethods.addUserInfo(userDataMap);
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        HelperFunctions.saveUserNameSharedPreference(widget.name);
        HelperFunctions.saveUserEmailSharedPreference(widget.email);
        String fmcToken = await AppNotificationHandler.getFcmToken();
        callSignupApi(result, fmcToken);
        // signupapi(result,fmcToken);

        // Navigator.pushReplacement(context, MaterialPageRoute(
        //     builder: (context) => ChatRoom()
        // ));
      } else {
        Navigator.of(loginLoader.currentContext, rootNavigator: true).pop();
        Navigator.of(loginLoader.currentContext, rootNavigator: true).pop();
        showOtpAlert(
            context, "The email address is already in use by another account");
      }
    });
  }

  showOtpAlert(BuildContext context, String msg) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
                return;
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SignUp(
                            email: widget.email,
                            pass: widget.pass,
                            college: widget.college,
                            name: widget.name,
                            dob: widget.dob,
                            gender: widget.gender,
                            phone: widget.phone)));
              },
            ),
          ],
        );
      },
    );
  }
}
