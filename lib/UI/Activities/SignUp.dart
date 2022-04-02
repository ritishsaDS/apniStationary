import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:book_buy_and_sell/UI/Activities/BookDetails.dart';
import 'package:book_buy_and_sell/Utils/helper/helperfunctions.dart';
import 'package:book_buy_and_sell/Utils/services/auth.dart';
import 'package:book_buy_and_sell/Utils/services/database.dart';
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
import 'package:book_buy_and_sell/viewModel/searchcollege.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:textfield_search/textfield_search.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../Addressbar.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  AuthService authService = new AuthService();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  XFile file;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phnController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController clgNameController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController cPwdController = TextEditingController();
  TextEditingController gstcontroller = TextEditingController();
  TextEditingController profession = TextEditingController();
  String smsOTP;
  bool gstCheck = false;
  bool other = false;
  String verificationId;
  String errorMessage = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  bool showpwd = true;
  bool showcnfrmpwd = true;
  FocusNode fullNameFn;
  FocusNode emailFn;
  FocusNode phnFn;
  FocusNode dobFn;
  FocusNode genderFn;
  FocusNode clgNameFn;
  FocusNode pwdFn;
  FocusNode cPwdFn;
  GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];

  @override
  void initState() {
    String apiKey = "AIzaSyBFTBy9ZL9ZnchMJ6GWa_NKaN9FIy2mM3Y";
    googlePlace = GooglePlace(apiKey);
    // getfeaturedmatches();
    // TODO: implement i
    //  nitState
    super.initState();
    //autoCompleteSearch("DAV");
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

  bool show = false;
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(backgroundColor),
      body: LoaderOverlay(
        child: SingleChildScrollView(
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
                      Image.asset('assets/icons/applogo.png', scale: 8),
                    ],
                  )),
              Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical * 2),
                alignment: Alignment.center,
                child: Text(
                  "Sign up",
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
                    file = await getImageFromGallery();

                    Uint8List uint8List = await compressFile(File(file.path));

                    imageUpload.profileimage(uint8List);
                    print("image selected${uint8List}");
                  }, child: GetBuilder<ImageUploadViewModel>(
                    builder: (controller) {
                      if (file == null) {
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
                                    Icon(
                                      Icons.person_outline_rounded,
                                      size: 80,
                                      color: Color(colorBlue),
                                    )
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
                                      image: MemoryImage(
                                          controller.profilephoto ?? ""),
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
                  Container(
                    child: Form(
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
                              // validator: (value) {
                              //   if (value.length < 3) {
                              //     return "Please enter Full Name";
                              //   } else {
                              //     return null;
                              //   }
                              // },
                            ),
                            SizedBox(
                              height: Get.height * 0.03,
                            ),
                            TextFormField(
                              focusNode: emailFn,
                              controller: emailController,
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
                              validator: (value) {
                                if (value.length < 3) {
                                  return "Please Input email in right format";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: Get.height * 0.03,
                            ),
                            TextFormField(
                                focusNode: phnFn,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                controller: phnController,
                                keyboardType: TextInputType.number,
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
                                    hintText: "Phone",
                                    hintStyle: TextStyle(
                                      color: Color(hintGrey),
                                      fontWeight: FontWeight.w500,
                                    )),
                                validator: (value) {
                                  if (value.length < 10) {
                                    return "Phone Number can't be smaller then 10 Chracters";
                                  } else {
                                    return null;
                                  }
                                }),
                            SizedBox(
                              height: Get.height * 0.03,
                            ),
                            Container(
                              width: SizeConfig.screenWidth,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Color(colorBlue),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Row(
                                        children: [
                                          SizedBox(width: 10),
                                          Container(
                                            width:
                                                SizeConfig.screenWidth * 0.23,
                                            child: TextFormField(
                                              onTap: () {
                                                selectDate(context);
                                              },
                                              readOnly: true,
                                              decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  border: InputBorder.none,
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .always,
                                                  hintText: "DOB",
                                                  hintStyle: TextStyle(
                                                    fontSize: SizeConfig
                                                            .blockSizeVertical *
                                                        2,
                                                  ),
                                                  errorStyle: TextStyle(
                                                    color: Colors.red,
                                                  )),
                                              controller: dobController,
                                              focusNode: dobFn,
                                            ),
                                          ),
                                          ImageIcon(
                                            AssetImage(
                                                'assets/icons/calendar.png'),
                                            color: Color(colorBlue),
                                            size: SizeConfig.blockSizeVertical *
                                                3,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 15),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Color(colorBlue),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(25)),
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
                                                  SizeConfig.blockSizeVertical *
                                                      1.90,
                                            ),
                                          ),
                                          items: <String>[
                                            'Male',
                                            'Female',
                                            'Other'
                                          ].map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: new Text(
                                                value,
                                                style: TextStyle(
                                                    fontSize: SizeConfig
                                                            .blockSizeVertical *
                                                        2,
                                                    color: Color(hintGrey)),
                                                textAlign: TextAlign.center,
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (val) {
                                            genderController.text = val;
                                            print(
                                                "gender${genderController.text}");
                                          },
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.03,
                            ),
                            // TextFieldSearch(
                            //   label:cartdate[0]['name'],
                            // minStringLength: 2,
                            //
                            // initialList:cartdate,
                            //
                            // // focusNode: clgNameFn,
                            //  controller: clgNameController,
                            //  // onTap: () async {
                            //  //   // should show search screen here
                            //  //   showSearch(
                            //  //     context: context,
                            //  //     // we haven't created AddressSearch class
                            //  //     // this should be extending SearchDelegate
                            //  //     delegate: AddressSearch(),
                            //  //   );
                            //  // },
                            //  decoration: InputDecoration(
                            //    focusedBorder: outLineGrey,
                            //    enabledBorder: outLineGrey,
                            //    isDense: true,
                            //    isCollapsed: true,
                            //    contentPadding: EdgeInsets.only(
                            //        top: Get.height * 0.016,
                            //        bottom: Get.height * 0.016,
                            //        left: 20),
                            //    errorBorder: outLineRed,
                            //    focusedErrorBorder: outLineRed,
                            //    hintText: "College Name",
                            //    hintStyle: TextStyle(
                            //      color: Color(hintGrey),
                            //      fontWeight: FontWeight.w500,
                            //
                            //    ),
                            // ),
                            //   future: () {
                            //     return fetchComplexData();
                            //   },
                            //   getSelectedValue: (item) {
                            //     print(item);
                            //   },
                            //  ),
                            other == true
                                ? TextFormField(
                                    controller: profession,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(12),
                                    ],
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
                                      hintText: "Your Profession",
                                      hintStyle: TextStyle(
                                        color: Color(hintGrey),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value.length < 3) {
                                        return "Profession must be more than 3 characters";
                                      } else {
                                        return null;
                                      }
                                    })
                                : TypeAheadField(
                                    textFieldConfiguration:
                                        TextFieldConfiguration(
                                      controller: clgNameController,
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
                                          hintText:
                                              "College Name/School Name/Inst. Name",
                                          hintStyle: TextStyle(
                                            color: Color(hintGrey),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ),
                                    suggestionsCallback: (pattern) async {
                                      print(pattern + pattern);
                                      return getSuggestions(pattern);
                                    },
                                    //itemCount: predictions.length,
                                    itemBuilder: (context, suggestion) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(suggestion,
                                              style: TextStyle(fontSize: 14)),
                                          // Text(suggestion['state-province'],style: TextStyle(fontSize: 14)),
                                          Divider()
                                        ],
                                      );
                                    },
                                    onSuggestionSelected: (suggestion) {
                                      setState(() {
                                        print(suggestion);
                                        clgNameController =
                                            TextEditingController(
                                                text: suggestion);
                                      });
                                    },
                                  ),
                            // TextFieldSearch(
                            //   label: 'Complex Future List',
                            // controller: clgNameController,
                            //   future: () {
                            //     return autoCompleteSearch("value");
                            //   },
                            //   getSelectedValue: (item) {
                            //     print(item);
                            //   },
                            //   minStringLength: 1,
                            //   textStyle: TextStyle(color: Colors.red),
                            //   decoration: InputDecoration(hintText: 'Search For Something'),
                            // ),
                            // TextField(
                            //   controller: textEditingController,
                            //   decoration: InputDecoration(
                            //       focusedBorder: outLineGrey,
                            //       enabledBorder: outLineGrey,
                            //
                            //       isDense: true,
                            //       isCollapsed: true,
                            //       contentPadding: EdgeInsets.only(
                            //           top: Get.height * 0.016,
                            //           bottom: Get.height * 0.016,
                            //           left: 20),
                            //       errorBorder: outLineRed,
                            //
                            //       focusedErrorBorder: outLineRed,
                            //       hintText: "College Name/School Name/Inst. Name",
                            //       hintStyle: TextStyle(
                            //         color: Color(hintGrey),
                            //         fontWeight: FontWeight.w500,
                            //       )),
                            //   onChanged: (value) {
                            //     if (value.isNotEmpty) {
                            //       autoCompleteSearch(value);
                            //       setState(() {
                            //         show=true;
                            //       });
                            //     } else {
                            //       if (predictions.length > 0 && mounted) {
                            //         setState(() {
                            //           predictions = [];
                            //         });
                            //       }
                            //     }
                            //   },
                            // ),

                            // other == true ? SizedBox(height: 1,):
                            // SizedBox(
                            //   height: Get.height * 0.015,
                            // ),
                            Container(
                              width: SizeConfig.screenWidth,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    value: other,
                                    onChanged: (value) {
                                      setState(() {
                                        other = value;
                                      });
                                    },
                                    activeColor: Color(colorBlue),
                                  ),
                                  Text(
                                    "Not a Student",
                                    style: TextStyle(
                                      color: Color(hintGrey),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: Get.height * 0.03,
                            ),
                            TextFormField(
                                focusNode: pwdFn,
                                controller: pwdController,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(12),
                                ],
                                obscureText: showpwd,
                                decoration: InputDecoration(
                                  focusedBorder: outLineGrey,
                                  enabledBorder: outLineGrey,
                                  isDense: true,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.remove_red_eye_rounded,
                                      color:
                                          !showpwd ? Colors.blue : Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (showpwd == false) {
                                          showpwd = true;
                                        } else {
                                          showpwd = false;
                                        }
                                      });
                                    },
                                  ),
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
                                  ),
                                ),
                                validator: (value) {
                                  if (value.length < 5) {
                                    return "Password must be more than 5 characters";
                                  } else {
                                    return null;
                                  }
                                }),
                            SizedBox(
                              height: Get.height * 0.03,
                            ),
                            TextFormField(
                                focusNode: cPwdFn,
                                onFieldSubmitted: (val) {
                                  cPwdFn.unfocus();
                                },
                                controller: cPwdController,
                                obscureText: showcnfrmpwd,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(12),
                                ],
                                decoration: InputDecoration(
                                    focusedBorder: outLineGrey,
                                    enabledBorder: outLineGrey,
                                    isDense: true,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.remove_red_eye,
                                        color: !showcnfrmpwd
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          if (showcnfrmpwd == false) {
                                            showcnfrmpwd = true;
                                          } else {
                                            showcnfrmpwd = false;
                                          }
                                        });
                                      },
                                    ),
                                    isCollapsed: true,
                                    contentPadding: EdgeInsets.only(
                                        top: Get.height * 0.016,
                                        bottom: Get.height * 0.016,
                                        left: 20),
                                    errorBorder: outLineRed,
                                    focusedErrorBorder: outLineRed,
                                    hintText: "Re-enter Password",
                                    hintStyle: TextStyle(
                                      color: Color(hintGrey),
                                      fontWeight: FontWeight.w500,
                                    )),
                                validator: (value) {
                                  if (value.length < 5) {
                                    return "Confirm Password must be more than 5 characters";
                                  } else {
                                    return null;
                                  }
                                }),

                            Container(
                              width: SizeConfig.screenWidth,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    value: gstCheck,
                                    onChanged: (value) {
                                      setState(() {
                                        gstCheck = value;
                                      });
                                    },
                                    activeColor: Color(colorBlue),
                                  ),
                                  Text(
                                    "GST",
                                    style: TextStyle(
                                      color: Color(hintGrey),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    " (If You have Gst Number please enter)",
                                    style: TextStyle(
                                        color: Color(hintGrey), fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                            gstCheck == true
                                ? Container(
                                    width: SizeConfig.screenWidth,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey[200],
                                              spreadRadius: 2.0,
                                              blurRadius: 4.0),
                                        ]),
                                    child: TextFormField(
                                      controller: gstcontroller,
                                      //focusNode: gstFn,
                                      textInputAction: TextInputAction.done,
                                      keyboardType: TextInputType.text,
                                      onFieldSubmitted: (value) {
                                        //gstFn.unfocus();
                                      },
                                      decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical:
                                                  SizeConfig.blockSizeVertical *
                                                      1.5,
                                              horizontal: SizeConfig
                                                      .blockSizeHorizontal *
                                                  5),
                                          hintText: "Enter GST No.",
                                          hintStyle: TextStyle(
                                            color: Color(hintGrey),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          border: InputBorder.none),
                                    ),
                                  )
                                : Container(),
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
                                      // if(validateStructure()!=true){
                                      //   CommonSnackBar.snackBar(
                                      //       message:
                                      //       "Email Is not in right Format");
                                      //   return;
                                      // }
                                      if (pwdController.text.length < 6) {
                                        showAlert(context,
                                            "Enter minimum 6 digts password");
                                        return;
                                      }
                                      if (pwdController.text !=
                                          cPwdController.text) {
                                        showAlert(context,
                                            "Password and Re-enter password does not match!");
                                        return;
                                      }

                                      if (dobController.text.isEmpty ||
                                          dobController.text == null) {
                                        showAlert(context,
                                            "Please Select Date of Birth");
                                        return;
                                      }
                                      if (genderController.text.isEmpty ||
                                          genderController.text == null) {
                                        showAlert(
                                            context, "Please Select Gender");
                                        return;
                                      }
                                      ImageUploadViewModel imaUploadViewModel =
                                          Get.find();
                                      print(
                                          "image selected${imaUploadViewModel.profilephoto}");

                                      if (imaUploadViewModel.profilephoto ==
                                          null) {
                                        showAlert(context,
                                            "Please Upload Profile Picture ");
                                        return;
                                      }
                                      verifyPhone();
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
                                  horizontal: SizeConfig.screenWidth * 0.05,
                                  vertical: SizeConfig.blockSizeVertical),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account !",
                                    style: TextStyle(
                                        color: Color(matteBlack),
                                        fontWeight: FontWeight.w500,
                                        fontSize: SizeConfig.blockSizeVertical *
                                            1.75),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 1,
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
                                              SizeConfig.blockSizeVertical *
                                                  1.75),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  isLoading ? Container() : Container(),
                  GetBuilder<RegisterViewModel>(
                    builder: (controller) {
                      if (controller.apiResponse.status == Status.LOADING) {
                        return Container();
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
    ));
  }

  singUp(message) async {
    context.loaderOverlay.show();
    if (signUpFormKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService
          .signUpWithEmailAndPassword(emailController.text, pwdController.text)
          .then((result) {
        if (result != null) {
          Map<String, String> userDataMap = {
            "userName": fullNameController.text,
            "userEmail": emailController.text
          };

// print("Api result $result");
// Fluttertoast.showToast(
//         msg: result["message"],
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0
//     );
          databaseMethods.addUserInfo(userDataMap);

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(fullNameController.text);
          HelperFunctions.saveUserEmailSharedPreference(emailController.text);
          context.loaderOverlay.hide();
          //  CommonSnackBar.snackBar(message:"OTP Verified");
          Future.delayed(Duration(milliseconds: 20), () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
            fullNameController.clear();
            emailController.clear();
            pwdController.clear();
            genderController.clear();
            clgNameController.clear();
            phnController.clear();
            dobController.clear();
          });
          // Navigator.pushReplacement(context, MaterialPageRoute(
          //     builder: (context) => ChatRoom()
          // ));
        }
      });
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

  Future<void> verifyPhone() async {
    context.loaderOverlay.show();

    setState(() {
      isLoading = true;
    });
    print(phnController.text);
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;

      smsOTPDialog(context).then((value) {
        print('sign in');
      });
    };
    try {
      //   setState(() {
      //     isLoading = false;
      //   });
      // setState(() {
      //   isLoading = true;
      // });

      await _auth.verifyPhoneNumber(
          phoneNumber: "+91" + phnController.text, // PHONE NUMBER TO SEND OTP
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
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  callSignupApi() async {
    context.loaderOverlay.show();
    setState(() {
      isLoading = true;
    });

    // ImageUploadViewModel imaUploadViewModel = Get.find();

    final String baseURL = 'https://admin.apnistationary.com/api/';
    final String registerURL = 'sign-up';

    //create multipart request for POST or PATCH method
    var request =
        http.MultipartRequest("POST", Uri.parse(baseURL + registerURL));
    //add text fields
    request.fields['email'] = emailController.text;
    request.fields['password'] = pwdController.text;
    request.fields['name'] = fullNameController.text;
    request.fields["profession"] = profession.text;
    request.fields['number'] = phnController.text;
    request.fields['dob'] = dobController.text;
    request.fields['gender'] = genderController.text;
    request.fields['college_name'] = clgNameController.text;

    try {
      //create multipart using filepath, string or bytes
      var pic = await http.MultipartFile.fromPath("image", file.path);

      //add multipart to request
      request.files.add(pic);
      var response = await request.send();

      //Get the response from the server
      var responseData = await response.stream.toBytes();
      setState(() {
        isLoading = false;
      });

      var responseString = String.fromCharCodes(responseData);

      Map<String, dynamic> mapResponse = json.decode(responseString);
      RegisterResponseModel model = RegisterResponseModel.fromJson(mapResponse);

      if (model.status == 200 || model.status == "200") {
        Fluttertoast.showToast(
            msg: model.message, toastLength: Toast.LENGTH_LONG);
        singUp(model.message);
      } else {
        context.loaderOverlay.hide();
        showAlert(context, model.message);
      }
      print(responseString);
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  signupapi() async {
    context.loaderOverlay.show();
    ImageUploadViewModel imaUploadViewModel = Get.find();
    print("image selected${imaUploadViewModel.profilephoto}");

    if (imaUploadViewModel.profilephoto == null) {
      showAlert(context, "Please Upload Profile Picture ");
      return;
    }
    RegisterViewModel registerViewModel = Get.find();

    RegisterReq registerReq = RegisterReq();
    registerReq.email = emailController.text;
    registerReq.password = pwdController.text;
    registerReq.name = fullNameController.text;
    registerReq.image = imaUploadViewModel.profilephoto;
    registerReq.number = phnController.text;
    registerReq.dob = dobController.text;
    registerReq.profession = profession.text;
    registerReq.gender = genderController.text;
    registerReq.college_name = clgNameController.text;

    //create multipart request for POST or PATCH method
    // var request = http.MultipartRequest("POST", Uri.parse("<url>"));
    // request.fields['email'] = emailController.text;
    // request.fields['password'] = pwdController.text;
    // request.fields['name'] = fullNameController.text;
    // request.fields["profession"] = profession.text;
    // request.fields['number'] = phnController.text;
    // request.fields['dob'] = dobController.text;
    // request.fields['gender'] = genderController.text;
    // request.fields['college_name'] = clgNameController.text;

    // //create multipart using filepath, string or bytes
    // var pic = await http.MultipartFile.fromPath("image", file.path);

    // //add multipart to request
    // request.files.add(pic);
    // var response = await request.send();

    //Get the response from the server
    // var responseData = await response.stream.toBytes();
    // var responseString = String.fromCharCodes(responseData);
    // print(responseString);

    await registerViewModel.register(registerReq);
    setState(() {
      isLoading = false;
    });

    if (registerViewModel.apiResponse.status == Status.COMPLETE) {
      RegisterResponseModel response = registerViewModel.apiResponse.data;
      if (response.status == '200') {
        Fluttertoast.showToast(
            msg: response.message, toastLength: Toast.LENGTH_LONG);
        singUp(response.message);
      } else {
        context.loaderOverlay.hide();
        showAlert(context, response.message);
      }
    } else {
      context.loaderOverlay.hide();
      showAlert(context, "Server Error");
    }
  }

  Future<bool> smsOTPDialog(BuildContext context) {
    context.loaderOverlay.hide();

    setState(() {
      isLoading = false;
    });
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Enter OTP'),
            content: Container(
              height: 85,
              child: Column(children: [
                TextField(
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
                      hintText: "Enter Otp",
                      hintStyle: TextStyle(
                        color: Color(hintGrey),
                        fontWeight: FontWeight.w500,
                      )),
                  onChanged: (value) {
                    this.smsOTP = value;
                  },
                ),
                (errorMessage != ''
                    ? Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red),
                      )
                    : Container())
              ]),
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                child: Text('Done'),
                onPressed: () {
                  if (smsOTP.length != 6) {
                    CommonSnackBar.snackBar(
                        message: "Please Enter valid Otp First");
                  } else {
                    Navigator.pop(context);
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
              )
            ],
          );
        });
  }

  signIn() async {
    setState(() {
      isLoading = true;
    });
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final user = (await _auth.signInWithCredential(credential));
      final currentUser = await _auth.currentUser;
      assert(FirebaseAuth.instance.currentUser.uid == currentUser.uid);
      print("jkfnoonnjonn");

      callSignupApi();
      // signupapi();
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>NewPasswordCust(phone:phoneNo)));
      //  Navigator.of(context).pushReplacementNamed('/homepage');
    } catch (e) {
      CommonSnackBar.snackBar(message: e.toString());
      setState(() {
        isLoading = false;
      });

      print(e);
    }
  }

  bool validateStructure() {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(emailController.text);
  }

  dynamic cartdate = new List();
  List<String> namecolge = new List();
  List<String> statecolge = new List();
  void getfeaturedmatches() async {
    try {
      final response = await get(
        Uri.parse(
            "http://universities.hipolabs.com/search?name=&country=India"),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson);
        setState(() {
          cartdate = responseJson;

          ///print('setstate'+cartdata.toString());
        });
        for (int i = 0; i < cartdate.length; i++) {
          namecolge.add(cartdate[i]['name']);
          //print(namecolge);
          // statecolge.add(cartdate[i]['state-province']);
        }
      } else {
        setState(() {});
      }
    } catch (e) {
      print(e);
      setState(() {});
    }
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions;
        print("predictions");

        print(googlePlace.queryAutocomplete.proxyUrl);
        print(googlePlace.details.obs);

        for (int i = 0; i < result.predictions.length; i++) {
          // print(result.predictions
          //     .elementAt(i)
          //     .description);
          namecolge.add(result.predictions.elementAt(i).description);
        }
        // getSuggestions(value);
      });
    }
  }

  Future<List<String>> getSuggestions(String query) async {
    if (query == "") {
      List<String> matches = List();
      List<String> states = List();
      matches.addAll(namecolge);
      states.addAll(statecolge);
      matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
      return matches;
    } else {
      await autoCompleteSearch(query);
      List<String> matches = List();
      List<String> states = List();
      matches.addAll(namecolge);
      states.addAll(statecolge);
      matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
      return matches;
    }
  }
}
