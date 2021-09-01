import 'dart:io';
import 'dart:typed_data';
import 'package:book_buy_and_sell/common/compress_image_function.dart';
import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/UI/Activities/Login.dart';
import 'package:book_buy_and_sell/UI/Activities/MainScreen.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/common/common_snackbar.dart';
import 'package:book_buy_and_sell/common/get_image_picker.dart';
import 'package:book_buy_and_sell/common/utility.dart';
import 'package:book_buy_and_sell/common/validation_widget.dart';
import 'package:book_buy_and_sell/model/apiModel/requestModel/register_request_model.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/register_response_model.dart';
import 'package:book_buy_and_sell/model/apis/api_response.dart';
import 'package:book_buy_and_sell/viewModel/image_upload_view_model.dart';
import 'package:book_buy_and_sell/viewModel/register_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phnController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController clgNameController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController cPwdController = TextEditingController();

  FocusNode fullNameFn;
  FocusNode emailFn;
  FocusNode phnFn;
  FocusNode dobFn;
  FocusNode genderFn;
  FocusNode clgNameFn;
  FocusNode pwdFn;
  FocusNode cPwdFn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fullNameFn = FocusNode();
    emailFn = FocusNode();
    phnFn = FocusNode();
    dobFn = FocusNode();
    genderFn = FocusNode();
    clgNameFn = FocusNode();
    pwdFn = FocusNode();
    cPwdFn = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    fullNameFn.dispose();
    emailFn.dispose();
    phnFn.dispose();
    dobFn.dispose();
    genderFn.dispose();
    clgNameFn.dispose();
    pwdFn.dispose();
    cPwdFn.dispose();
    super.dispose();
  }

  DateTime selectedDate = DateTime.now();
  selectDate(BuildContext context) async {
    // final DateTime picked = await showDatePicker(
    //   context: context,
    //   initialDate: selectedDate,
    //   firstDate: DateTime(1920),
    //   lastDate: DateTime(2050),
    // );

    var datePicked = await DatePicker.showSimpleDatePicker(
      context,
      // initialDate: DateTime(1994),
      firstDate: DateTime(1960),
      // lastDate: DateTime(2012),
      dateFormat: "dd-MMMM-yyyy",
      locale: DateTimePickerLocale.en_us,
      looping: true,
    );

    if (datePicked != null && datePicked != selectedDate)
      setState(() {
        selectedDate = datePicked;
      });
    dobController.text = DateFormat.yMd().format(selectedDate);
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
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(gradientColor1),
                    Color(gradientColor2),
                  ]),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/bg/logo.png',
                      scale: SizeConfig.blockSizeVertical * 0.6,
                    ),
                    Text(
                      "App Name",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: SizeConfig.blockSizeVertical * 2),
                    )
                  ],
                )),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 2),
              alignment: Alignment.center,
              child: Text(
                "Signup",
                style: TextStyle(
                    color: Color(colorBlue),
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.blockSizeVertical * 3),
              ),
            ),
            Stack(
              children: [
                GestureDetector(onTap: () async {
                  ImageUploadViewModel imageUpload = Get.find();
                  XFile file = await getImageFromGallery();

                  Uint8List uint8List = await compressFile(File(file.path));

                  imageUpload.addSelectedImg(uint8List);
                  print("image selected${uint8List}");
                }, child: GetBuilder<ImageUploadViewModel>(
                  builder: (controller) {
                    if (controller.selectedImg == null) {
                      return Container(
                        width: SizeConfig.screenWidth,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(colorBlue),
                                ),
                              ),
                              padding: EdgeInsets.all(8),
                              height: SizeConfig.blockSizeVertical * 14,
                              width: SizeConfig.screenWidth * 0.3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Upload Profile Pic",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return Container(
                      width: SizeConfig.screenWidth,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(colorBlue),
                                ),
                                image: DecorationImage(
                                    image: MemoryImage(controller.selectedImg),
                                    fit: BoxFit.cover)),
                            padding: EdgeInsets.all(8),
                            height: SizeConfig.blockSizeVertical * 14,
                            width: SizeConfig.screenWidth * 0.3,
                          ),
                        ],
                      ),
                    );
                  },
                )),
                Container(
                    margin: EdgeInsets.only(
                        top: SizeConfig.screenHeight * 0.1,
                        left: SizeConfig.screenWidth * 0.3),
                    width: SizeConfig.screenWidth,
                    child: ImageIcon(
                      AssetImage('assets/icons/edit.png'),
                      color: Color(colorBlue),
                    )),
              ],
            ),
            Stack(
              children: [
                Form(
                  key: signUpFormKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.08,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        CommanWidget.getTextFormField(
                          focusNode: fullNameFn,
                          function: (value) {
                            fullNameFn.unfocus();
                            FocusScope.of(context).requestFocus(emailFn);
                          },
                          textEditingController: fullNameController,
                          hintText: "Full Name",
                          inputLength: 30,
                          regularExpression:
                              Utility.alphabetSpaceValidationPattern,
                          validationMessage: Utility.nameEmptyValidation,
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        CommanWidget.getTextFormField(
                          focusNode: emailFn,
                          function: (String value) {
                            emailFn.unfocus();
                            FocusScope.of(context).requestFocus(phnFn);
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
                        CommanWidget.getTextFormField(
                          focusNode: phnFn,
                          function: (String value) {
                            phnFn.unfocus();
                            FocusScope.of(context).requestFocus(dobFn);
                          },
                          textEditingController: phnController,
                          inputLength: 10,
                          regularExpression: Utility.digitsValidationPattern,
                          validationMessage:
                              Utility.mobileNumberInValidValidation,
                          validationType: 'mobileno',
                          hintText: "Phone",
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        Container(
                          width: SizeConfig.screenWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: SizeConfig.screenWidth * 0.35,
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Color(colorBlue),
                                    ),
                                    borderRadius: BorderRadius.circular(25)),
                                child: Row(
                                  children: [
                                    Container(
                                      width: SizeConfig.screenWidth * 0.25,
                                      child: TextFormField(
                                        onTap: () {
                                          selectDate(context);
                                        },
                                        readOnly: true,
                                        decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding: EdgeInsets.zero,
                                            border: InputBorder.none,
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            hintText: "DOB",
                                            hintStyle: TextStyle(
                                              fontSize:
                                                  SizeConfig.blockSizeVertical *
                                                      1.50,
                                            ),
                                            errorStyle: TextStyle(
                                              color: Colors.red,
                                            )),
                                        controller: dobController,
                                        focusNode: dobFn,
                                      ),
                                    ),
                                    ImageIcon(
                                      AssetImage('assets/icons/calendar.png'),
                                      color: Color(colorBlue),
                                      size: SizeConfig.blockSizeVertical * 2,
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                  width: SizeConfig.screenWidth * 0.35,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Color(colorBlue),
                                      ),
                                      borderRadius: BorderRadius.circular(25)),
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                        border: InputBorder.none,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        errorStyle: TextStyle(
                                          color: Colors.red,
                                        )),
                                    hint: Text(
                                      "Gender",
                                      style: TextStyle(
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 1.50,
                                      ),
                                    ),
                                    items: <String>['Male', 'Female', 'Other']
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: new Text(
                                          value,
                                          style: TextStyle(
                                              fontSize:
                                                  SizeConfig.blockSizeVertical *
                                                      1.5,
                                              color: Color(hintGrey)),
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      genderController.text = val;
                                      print("gender${genderController.text}");
                                    },
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        CommanWidget.getTextFormField(
                          focusNode: clgNameFn,
                          function: (value) {
                            clgNameFn.unfocus();
                            FocusScope.of(context).requestFocus(pwdFn);
                          },
                          textEditingController: clgNameController,
                          hintText: "College Name",
                          inputLength: 30,
                          regularExpression:
                              Utility.alphabetSpaceValidationPattern,
                          validationMessage: Utility.nameEmptyValidation,
                          sIcon: Container(
                            width: Get.width * 0.06,
                            child: Center(
                              child: ImageIcon(
                                AssetImage(
                                  'assets/icons/location.png',
                                ),
                                color: Color(colorBlue),
                                size: Get.height * 0.03,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        CommanWidget.getTextFormField(
                          function: (value) {
                            pwdFn.unfocus();
                            FocusScope.of(context).requestFocus(cPwdFn);
                          },
                          focusNode: pwdFn,
                          textEditingController: pwdController,
                          inputLength: 6,
                          obscureValue: true,
                          regularExpression: Utility.password,
                          validationMessage: "Password is required",
                          validationType: 'password',
                          hintText: "Password",
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        CommanWidget.getTextFormField(
                          focusNode: cPwdFn,
                          function: (value) {
                            cPwdFn.unfocus();
                          },
                          textEditingController: cPwdController,
                          inputLength: 6,
                          obscureValue: true,
                          regularExpression: Utility.password,
                          validationMessage: "Password is required",
                          validationType: 'password',
                          hintText: "Re-enter Password",
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
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
                                  Color(gradientColor2).withOpacity(0.95),
                                ],
                                begin: Alignment(1.0, -3.0),
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: MaterialButton(
                              onPressed: () async {
                                if (signUpFormKey.currentState.validate()) {
                                  if (pwdController.text !=
                                      cPwdController.text) {
                                    CommonSnackBar.snackBar(
                                        message:
                                            "Password and Re-enter password does not match!");
                                    return;
                                  }
                                  if (dobController.text.isEmpty ||
                                      dobController.text == null) {
                                    CommonSnackBar.snackBar(
                                        message: "Please Select Date of Birth");
                                    return;
                                  }
                                  if (genderController.text.isEmpty ||
                                      genderController.text == null) {
                                    CommonSnackBar.snackBar(
                                        message: "Please Select Gender");
                                    return;
                                  }

                                  RegisterViewModel registerViewModel =
                                      Get.find();
                                  ImageUploadViewModel imaUploadViewModel =
                                      Get.find();
                                  print(
                                      "image selected${imaUploadViewModel.selectedImg}");
                                  RegisterReq registerReq = RegisterReq();
                                  registerReq.email = emailController.text;
                                  registerReq.password = pwdController.text;
                                  registerReq.name = fullNameController.text;
                                  registerReq.image =
                                      imaUploadViewModel.selectedImg;
                                  registerReq.number = phnController.text;
                                  registerReq.dob = dobController.text;
                                  registerReq.gender = genderController.text;
                                  registerReq.college_name =
                                      clgNameController.text;
                                  await registerViewModel.register(registerReq);
                                  if (registerViewModel.apiResponse.status ==
                                      Status.COMPLETE) {
                                    RegisterResponseModel response =
                                        registerViewModel.apiResponse.data;
                                    if (response.status == '200') {
                                      CommonSnackBar.snackBar(
                                          message: response.message);
                                      Future.delayed(Duration(seconds: 2), () {
                                        Get.back();
                                        fullNameController.clear();
                                        emailController.clear();
                                        pwdController.clear();
                                        genderController.clear();
                                        clgNameController.clear();
                                        phnController.clear();
                                        dobController.clear();
                                      });
                                    } else {
                                      CommonSnackBar.snackBar(
                                          message: response.message);
                                    }
                                  } else {
                                    CommonSnackBar.snackBar(
                                        message: "Server Errorrr");
                                  }
                                }
                              },
                              child: Text(
                                "Signup",
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
                              horizontal: SizeConfig.screenWidth * 0.1,
                              vertical: SizeConfig.blockSizeVertical),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account !",
                                style: TextStyle(
                                    color: Color(matteBlack),
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                        SizeConfig.blockSizeVertical * 1.75),
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 2,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return LoginScreen();
                                  }));
                                },
                                child: Text(
                                  "Signin Now",
                                  style: TextStyle(
                                      color: Color(colorBlue),
                                      fontWeight: FontWeight.w500,
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
                GetBuilder<RegisterViewModel>(
                  builder: (controller) {
                    if (controller.apiResponse.status == Status.LOADING) {
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
    ));
  }
}
