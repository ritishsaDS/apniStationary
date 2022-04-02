import 'package:book_buy_and_sell/UI/Activities/MainScreen.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:book_buy_and_sell/Constants/Colors.dart';

class ForgotPassword2 extends StatefulWidget {
  const ForgotPassword2({Key key}) : super(key: key);

  @override
  _ForgotPassword2State createState() => _ForgotPassword2State();
}

class _ForgotPassword2State extends State<ForgotPassword2> {
  GlobalKey<FormState> forgotFormKey = GlobalKey<FormState>();
  TextEditingController pwd = TextEditingController();
  TextEditingController cpwd = TextEditingController();

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
                      controller: pwd,
                      focusNode: pwdFn,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      cursorColor: Color(colorBlue),
                      onFieldSubmitted: (value) {
                        pwdFn.unfocus();
                        FocusScope.of(context).requestFocus(cPwdFn);
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical * 1.5,
                            horizontal: SizeConfig.blockSizeHorizontal * 5),
                        hintText: "Enter New Password",
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
                      controller: cpwd,
                      focusNode: cPwdFn,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      cursorColor: Color(colorBlue),
                      onFieldSubmitted: (value) {
                        cPwdFn.unfocus();
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical * 1.5,
                            horizontal: SizeConfig.blockSizeHorizontal * 5),
                        hintText: "Re-enter New Password",
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
                        onPressed: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context){
                          //   return MainScreen();
                          // }));
                        },
                        child: Text(
                          "Change Password",
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

  void _resetPassword() async {
    String newPassword = pwd.text;

    var _auth = await FirebaseAuth.instance;

    _auth.confirmPasswordReset(code: "code", newPassword: newPassword);
  }

  void _changePassword() async {
    var user = await FirebaseAuth.instance.currentUser;
    String email = user.email;

    //Create field for user to input old password

    //pass the password here
    // String password = pwd.text;
    String newPassword = pwd.text;

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: newPassword,
      );

      user.updatePassword(newPassword).then((_) {
        print("Successfully changed password");
      }).catchError((error) {
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
