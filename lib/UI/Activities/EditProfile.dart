import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/Utils/helper/constants.dart';
import 'package:book_buy_and_sell/Utils/helper/helperfunctions.dart';
import 'package:book_buy_and_sell/common/common_snackbar.dart';
import 'package:book_buy_and_sell/common/compress_image_function.dart';
import 'package:book_buy_and_sell/common/get_image_picker.dart';
import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:book_buy_and_sell/model/apiModel/requestModel/Editprofile_request_model.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/register_response_model.dart';
import 'package:book_buy_and_sell/model/apis/api_response.dart';
import 'package:book_buy_and_sell/viewModel/Editprofile_view_model.dart';
import 'package:book_buy_and_sell/viewModel/image_upload_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'BookDetails.dart';
import 'MainScreen.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  ImageUploadViewModel imaUploadViewModel;
  TextEditingController fullName = TextEditingController(text: PreferenceManager.getName());
  TextEditingController email = TextEditingController(text: PreferenceManager.getEmailId());
  TextEditingController phn = TextEditingController(text: PreferenceManager.getPhoneNo());
  TextEditingController dob = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController clgName = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController gst = TextEditingController();

  bool gstCheck = false;

  FocusNode fullNameFn;
  FocusNode emailFn;
  FocusNode phnFn;
  FocusNode dobFn;
  XFile file;
  FocusNode genderFn;
  FocusNode clgNameFn;
  FocusNode cityFn;
  FocusNode gstFn;
  bool isLoading=false;
  bool isbtnLoading=false;
  var iamge;
  @override
  void initState() {
    // TODO: implement initState
     iamge= PreferenceManager.getImage();
     getprofile();
    super.initState();
    fullNameFn = FocusNode();
    emailFn = FocusNode();
    phnFn = FocusNode();
    dobFn = FocusNode();
    genderFn = FocusNode();
    clgNameFn = FocusNode();
    cityFn = FocusNode();
    gstFn = FocusNode();
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
    cityFn.dispose();
    gstFn.dispose();
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
    dob.text = DateFormat.yMd().format(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
      backgroundColor: Color(backgroundColor),
      body: SingleChildScrollView(
        child:isLoading?Center(child: CircularProgressIndicator(),): Column(
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
                    onTap: (){
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
                    ),
                    child: Row(
                      children: [
                        Text(
                          Constants.userlocation,
                          style: TextStyle(color: Color(black)),
                        ),
                        // SizedBox(
                        //   width: SizeConfig.blockSizeHorizontal * 2,
                        // ),
                        // ImageIcon(
                        //   AssetImage('assets/icons/current.png'),
                        //   color: Color(colorBlue),
                        //   size: SizeConfig.blockSizeVertical * 3,
                        // )
                      ],
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  ImageIcon(
                    AssetImage('assets/icons/notification.png'),
                    color: Color(colorBlue),
                    size: SizeConfig.blockSizeVertical * 4,
                  )
                ],
              ),
            ),
            Stack(
              children: [
                GestureDetector(onTap: () async {
                  ImageUploadViewModel imageUpload = Get.find();
                  file = await getImageFromGallery();
print("path-----"+file.path);
                  Uint8List uint8List = await compressFile(File(file.path));

                  imageUpload.addSelectedImg(uint8List);
                  print("image selected${uint8List}");

                 setState(() {
                   iamge=null;
                 });
                }, child: GetBuilder<ImageUploadViewModel>(
                  builder: (controller) {
                    if (controller.selectedImg == null&&PreferenceManager.getImage()==null) {
                      print("ifififif");
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
                                  Icon(Icons.person_outline_rounded,size: 80,color: Color(colorBlue),)
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
else if(iamge!=null){
                      print("elseeeifififif");
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
                                image: DecorationImage(image: NetworkImage(PreferenceManager.getImage()))
                              ),
                              padding: EdgeInsets.all(8),
                              height: SizeConfig.blockSizeVertical * 14,
                              width: SizeConfig.screenWidth * 0.3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                   else{
                     print('elselels');
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
                    }
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


            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.05,
                vertical: SizeConfig.blockSizeVertical * 2,
              ),
              child: Text("Personal Detail",
                style: TextStyle(
                    color: Color(black),
                    fontWeight: FontWeight.w500
                ),),
            ),
            Form(
              key: signUpFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.05,
                      right: SizeConfig.screenWidth * 0.05,
                      top: SizeConfig.blockSizeVertical * 2,
                      bottom: SizeConfig.blockSizeVertical,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200],
                              spreadRadius: 2.0,
                              blurRadius: 4.0
                          ),
                        ]
                    ),
                    child: TextFormField(
                      controller: fullName,
                      focusNode: fullNameFn,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (value) {
                        fullNameFn.unfocus();
                        FocusScope.of(context).requestFocus(emailFn);
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical * 1.5,
                            horizontal: SizeConfig.blockSizeHorizontal * 5),
                        hintText: "Full Name",
                        hintStyle: TextStyle(
                          color: Color(hintGrey),
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.05,
                      right: SizeConfig.screenWidth * 0.05,
                      top: SizeConfig.blockSizeVertical * 2,
                      bottom: SizeConfig.blockSizeVertical,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[200],
                          spreadRadius: 2.0,
                          blurRadius: 4.0
                        ),
                      ]
                    ),
                    child: TextFormField(
                      controller: email,
                      focusNode: emailFn,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      onFieldSubmitted: (value) {
                        emailFn.unfocus();
                        FocusScope.of(context).requestFocus(phnFn);
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical * 1.5,
                            horizontal: SizeConfig.blockSizeHorizontal * 5),
                        hintText: "Email",
                        hintStyle: TextStyle(
                          color: Color(hintGrey),
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.05,
                      right: SizeConfig.screenWidth * 0.05,
                      top: SizeConfig.blockSizeVertical * 2,
                      bottom: SizeConfig.blockSizeVertical,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200],
                              spreadRadius: 2.0,
                              blurRadius: 4.0
                          ),
                        ]
                    ),
                    child: TextFormField(
                      controller: phn,
                      focusNode: phnFn,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      onFieldSubmitted: (value) {
                        phnFn.unfocus();
                        FocusScope.of(context).requestFocus(dobFn);
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical * 1.5,
                            horizontal: SizeConfig.blockSizeHorizontal * 5),
                        hintText: "Phone",
                        hintStyle: TextStyle(
                          color: Color(hintGrey),
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.05,
                      right: SizeConfig.screenWidth * 0.05,
                      top: SizeConfig.blockSizeVertical * 2,
                      bottom: SizeConfig.blockSizeVertical,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            
                            padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[200],
                                      spreadRadius: 2.0,
                                      blurRadius: 4.0
                                  ),
                                ]
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 20,),
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
                                        hintText: userdetail['user']['dob'],
                                        hintStyle: TextStyle(
                                          fontSize:
                                          SizeConfig.blockSizeVertical * 2,
                                        ),
                                        errorStyle: TextStyle(
                                          color: Colors.red,
                                        )),
                                    controller: dob,
                                    focusNode: dobFn,
                                  ),
                                ),
                                ImageIcon(
                                  AssetImage('assets/icons/calendar.png'),
                                  color: Color(colorBlue),
                                  size: SizeConfig.blockSizeVertical * 3,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        Expanded(
                          child: Container(
                              width: SizeConfig.screenWidth * 0.35,
                              padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[200],
                                        spreadRadius: 2.0,
                                        blurRadius: 4.0
                                    ),
                                  ]
                              ),
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
                                  "${userdetail['user']['gender']}",
                                  style: TextStyle(
                                    fontSize: SizeConfig.blockSizeVertical * 2,
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
                                          SizeConfig.blockSizeVertical * 1.75,
                                          color: Color(hintGrey)),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  gender.text = val;
                                  print("gender${gender.text}");
                                },
                              )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.05,
                      right: SizeConfig.screenWidth * 0.05,
                      top: SizeConfig.blockSizeVertical * 2,
                      bottom: SizeConfig.blockSizeVertical,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200],
                              spreadRadius: 2.0,
                              blurRadius: 4.0
                          ),
                        ]
                    ),
                    child: TextFormField(
                      controller: clgName,
                      focusNode: clgNameFn,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (value) {
                        clgNameFn.unfocus();
                        FocusScope.of(context).requestFocus(cityFn);
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical * 1.5,
                            horizontal: SizeConfig.blockSizeHorizontal * 5),
                        hintText: "College Name",
                        hintStyle: TextStyle(
                          color: Color(hintGrey),
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.05,
                      right: SizeConfig.screenWidth * 0.05,
                      top: SizeConfig.blockSizeVertical * 2,
                      bottom: SizeConfig.blockSizeVertical,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200],
                              spreadRadius: 2.0,
                              blurRadius: 4.0
                          ),
                        ]
                    ),
                    child: TextFormField(
                      controller: city,
                      focusNode: cityFn,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (value) {
                        cityFn.unfocus();
                        FocusScope.of(context).requestFocus(gstFn);
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical * 1.5,
                            horizontal: SizeConfig.blockSizeHorizontal * 5),
                        hintText: "City/State",
                        hintStyle: TextStyle(
                          color: Color(hintGrey),
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.05,
                      right: SizeConfig.screenWidth * 0.05,
                      top: SizeConfig.blockSizeVertical,
                      bottom: SizeConfig.blockSizeVertical,
                    ),
                    child: Row(
                      children: [
                        Checkbox(value: gstCheck, onChanged: (value){
                          setState(() {
                            gstCheck = value;
                          });
                        },
                        activeColor: Color(colorBlue),
                        ),
                        Text("GST",
                        style: TextStyle(
                          color: Color(hintGrey),
                          fontWeight: FontWeight.w500,
                        ),),
                      ],
                    ),
                  ),
                  gstCheck == true ?
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.05,
                      right: SizeConfig.screenWidth * 0.05,
                      top: SizeConfig.blockSizeVertical,
                      bottom: SizeConfig.blockSizeVertical,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200],
                              spreadRadius: 2.0,
                              blurRadius: 4.0
                          ),
                        ]
                    ),
                    child: TextFormField(
                      controller: gst,
                      focusNode: gstFn,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (value) {
                        gstFn.unfocus();
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical * 1.5,
                            horizontal: SizeConfig.blockSizeHorizontal * 5),
                        hintText: "Enter GST No.",
                        hintStyle: TextStyle(
                          color: Color(hintGrey),
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none),
                    ),
                  ) : Container(),

                  Center(
                    child: Container(
                      width: SizeConfig.screenWidth * 0.5,
                      height: SizeConfig.blockSizeVertical * 5,
                      margin: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.05,
                          right: SizeConfig.screenWidth * 0.05,
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
      // if (dob.text.isEmpty ||
      //     dob.text == null) {
      //   CommonSnackBar.snackBar(
      //       message: "Please Select Date of Birth");
      //   return;
      // }
      // if (gender.text.isEmpty ||
      //     gender.text == null) {
      //   CommonSnackBar.snackBar(
      //       message: "Please Select Gender");
      //   return;
      // }

       imaUploadViewModel =
      Get.find();
      print(
          "image selected${imaUploadViewModel.selectedImg}");

      // if (imaUploadViewModel.selectedImg == null) {
      //   CommonSnackBar.snackBar(
      //       message: "Please Upload Profile Picture ");
      //   return;
      // }
      update();
//       EditProfileViewModel registerViewModel =
//       Get.find();
//
//       EditReq registerReq = EditReq();
//       registerReq.email = email.text;
// registerReq.user_id=PreferenceManager.getUserId().toString();
// registerReq.session_key=PreferenceManager.getSessionKey();
//       registerReq.name = fullName.text;
//       registerReq.image =
//           imaUploadViewModel.selectedImg;
//       registerReq.number = phn.text;
//       registerReq.dob = dob.text;
//       registerReq.gender = gender.text;
//       registerReq.college_name =
//           clgName.text;
//       await registerViewModel.register(registerReq);
//       if (registerViewModel.apiResponse.status ==
//           Status.COMPLETE) {
//         RegisterResponseModel response =
//             registerViewModel.apiResponse.data;
//         if (response.status == '200') {
//           CommonSnackBar.snackBar(
//               message: response.message);
//
//           //singUp(response.message);
//
//         } else {
//           CommonSnackBar.snackBar(
//               message: response.message);
//         }
//       } else {
//         CommonSnackBar.snackBar(
//             message: "Server Error");
//       }
    }},

    // Navigator.push(context, MaterialPageRoute(builder: (context){
    //                         return MainScreen();
    //                       }));

                        child:isbtnLoading?CircularProgressIndicator(): Text(
                          "Save Changes",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
  dynamic userdetail=new List();
  Future<void> getprofile() async {
    isLoading=true;
    try {
      final response = await http.post(Uri.parse("https://buysell.powerdope.com/api/user-data"),
         body: {"user_id":PreferenceManager.getUserId().toString(),
          "session_key":PreferenceManager.getSessionKey().toString()});

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
setState(() {
  isLoading=false;
  print(responseJson);
  userdetail=responseJson;
  print(userdetail['user']['dob']);
  clgName = TextEditingController(text: userdetail['user']['college_name']);});

      } else {
        print("bjkb" + response.statusCode.toString());

        setState(() {
          // isError = true;
          // isLoading = false;
        });
      }
    } catch (e) {
      print("uhdfuhdfuh"+e.toString());
      setState(() {
        // isError = true;
        // isLoading = false;
      });
    }
  }
  Future<void> update() async {
    setState(() {
      isbtnLoading=true;
    });
if(file==null){
  var url = "https://buysell.powerdope.com/api/edit-profile";

  var request = http.MultipartRequest('POST', Uri.parse(url));



  request.fields['user_id'] = PreferenceManager.getUserId().toString();
  request.fields['session_key'] = PreferenceManager.getSessionKey().toString();
  request.fields['name'] = fullName.text;
  request.fields['email'] = email.text;
  request.fields['gender'] = gender.text==""?userdetail['user']['gender']:gender.text;
  request.fields['dob'] = dob.text==""?userdetail['user']['dob']:dob.text;
  request.fields['number'] = phn.text;
  request.fields['college_name'] = clgName.text;
  request.fields['city'] = city.text;


  var res = await request.send();
  print(res.statusCode);
  if (res.statusCode == 200) {
    await PreferenceManager.setEmailId(
        '${email.text}');

    await PreferenceManager.setName(
        fullName.text);


    await PreferenceManager.setPhoneNo(
        phn.text);
    setState(() {
      isbtnLoading= false;
    });
    showAlert(context,"Profile Updated Succesfully");

    Future.delayed(Duration(seconds: 2),
            () {
          Get.offAll(MainScreen());

        });

    // Navigator.pop(context);
  } else {
    setState(() {
      isbtnLoading= false;
    });

  }
  return res.reasonPhrase;


}
    else{
  var url = "https://buysell.powerdope.com/api/edit-profile";

  var request = http.MultipartRequest('POST', Uri.parse(url));

  print(file.path);
  request.files.add(await http.MultipartFile.fromPath(
    'image',
    file.path,
  ));

  request.fields['user_id'] = PreferenceManager.getUserId().toString();
  request.fields['session_key'] = PreferenceManager.getSessionKey().toString();
  request.fields['name'] = fullName.text;
  request.fields['email'] = email.text;
  request.fields['gender'] = gender.text==null?userdetail['user']['gender']:gender.text;
  request.fields['dob'] = dob.text==null?userdetail['user']['dob']:dob.text;
  request.fields['number'] = phn.text;
  request.fields['college_name'] = clgName.text;
  request.fields['city'] = city.text;


  var res = await request.send();
  print(res.statusCode);

  if (res.statusCode == 200) {
    print(res);
    await PreferenceManager.setEmailId(
        '${email.text}');

    await PreferenceManager.setName(
        fullName.text);


    await PreferenceManager.setPhoneNo(
       phn.text);
    // await PreferenceManager.setImage(
    //     response.user.image);
   // print("image:${response.user.image}");
    var emailId =
    PreferenceManager.getEmailId();
   // signIn(response.message);
    HelperFunctions.saveUserLoggedInSharedPreference(true);
    HelperFunctions.saveUserNameSharedPreference(
        PreferenceManager.getName());
    HelperFunctions.saveUserEmailSharedPreference(
        PreferenceManager.getEmailId());
    setState(() {
      isbtnLoading= false;
    });
CommonSnackBar.snackBar(
        message:"Profile Updated Succesfully");

    Future.delayed(Duration(seconds: 2),
        () {
      Get.offAll(MainScreen());

    });    // Navigator.pop(context);
  } else {
    setState(() {
      isbtnLoading= false;
    });

  }
  return res.reasonPhrase;

}

}
//     try {
//       final response = await http.post(Uri.parse("https://buysell.powerdope.com/api/edit-profile"),
//           body: {
//         "user_id":PreferenceManager.getUserId().toString(),
//             "session_key":PreferenceManager.getSessionKey().toString(),
//             'name':fullName.text,
//             'dob':dob.text==null?userdetail['user']['dob']:dob.text==""?userdetail['user']['dob']:dob.text,
//             'number':phn.text,
//             'image': 12,
//                 'gender':gender.text==null?userdetail['user']['gender']:gender.text==""?userdetail['user']['dob']:gender.text,
//           'college_name':clgName.text
//           },
//
//       );
// print(response.request.toString());
// print(response.body.toString());
//       if (response.statusCode == 200) {
//         final responseJson = json.decode(response.body);
//        setState(() {
//          dob = TextEditingController(text: responseJson['user']['dob']);
//          print(responseJson);
//        });
//       } else {
//         print("bjkb" + response.statusCode.toString());
//
//         setState(() {
//           // isError = true;
//           // isLoading = false;
//         });
//       }
//     } catch (e) {
//       print("uhdfuhdfuh"+e.toString());
//       setState(() {
//         // isError = true;
//         // isLoading = false;
//       });
//     }
  }
