import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/Utils/ApiCall.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/Utils/constantString.dart';
import 'package:book_buy_and_sell/common/common_snackbar.dart';
import 'package:book_buy_and_sell/common/compress_image_function.dart';
import 'package:book_buy_and_sell/common/get_image_picker.dart';
import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:book_buy_and_sell/model/ClassModel/BookDataModel.dart';
import 'package:book_buy_and_sell/model/apiModel/requestModel/BookAdd.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/register_response_model.dart';
import 'package:book_buy_and_sell/model/apis/api_response.dart';
import 'package:book_buy_and_sell/viewModel/book_add_view_model.dart';
import 'package:book_buy_and_sell/viewModel/image_upload_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SellBook extends StatefulWidget {
  final String catId;

  SellBook(this.catId);



  @override
  _SellBookState createState() => _SellBookState();
}

class _SellBookState extends State<SellBook> {
  TextEditingController bookName = TextEditingController();
  TextEditingController author = TextEditingController();
  TextEditingController edition = TextEditingController();
  TextEditingController semester = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController price = TextEditingController();

  TextEditingController conditions = TextEditingController();
  GlobalKey<FormState> profileForm = GlobalKey<FormState>();

  FocusNode bookNameFn;
  FocusNode authorFn;
  FocusNode editionFn;
  FocusNode semesterFn;
  FocusNode descFn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookNameFn = FocusNode();
    authorFn = FocusNode();
    editionFn = FocusNode();
    semesterFn = FocusNode();
    descFn = FocusNode();

    if(widget.catId.isNotEmpty) {
      Future<BookDataModel> bookData = _callBookDataAPI();

      bookName.text = bookData.;
      mobileNoController.text = user.mobile_no;
      addressController.text = user.address;
    }
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
                      child: Row(
                        children: [
                          Text(
                            "Current Location",
                            style: TextStyle(color: Color(black)),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 2,
                          ),
                          ImageIcon(
                            AssetImage('assets/icons/current.png'),
                            color: Color(colorBlue),
                            size: SizeConfig.blockSizeVertical * 3,
                          )
                        ],
                      ),
                    ),
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
                margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.05,
                  vertical: SizeConfig.blockSizeVertical,
                ),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[200],
                        blurRadius: 4.0,
                        spreadRadius: 1.0),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(onTap: () async {
                          ImageUploadViewModel imageUpload = Get.find();
                          XFile file = await getImageFromGallery();

                          Uint8List uint8List =
                              await compressFile(File(file.path));

                          imageUpload.addSelectedImg(uint8List);
                          print("image selected${uint8List}");
                        }, child: GetBuilder<ImageUploadViewModel>(
                          builder: (controller) {
                            if (controller.selectedImg == null) {
                              return Container(
                                width: SizeConfig.screenWidth * 0.4,
                                height: SizeConfig.screenHeight * 0.15,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[200],
                                          spreadRadius: 1.0,
                                          blurRadius: 2.0),
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_circle,
                                      color: Color(colorBlue),
                                      size: SizeConfig.blockSizeVertical * 6,
                                    ),
                                    Text("Add Book Pic")
                                  ],
                                ),
                              );
                            }

                            return Container(
                              width: SizeConfig.screenWidth * 0.4,
                              height: SizeConfig.screenHeight * 0.15,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[200],
                                        spreadRadius: 1.0,
                                        blurRadius: 2.0),
                                  ],
                                  image: DecorationImage(
                                      image: MemoryImage(controller.selectedImg),
                                      fit: BoxFit.cover)),
                            );
                          },
                        )),

                        GestureDetector(onTap: () async {
                          ImageUploadViewModel imageUpload = Get.find();
                          XFile file = await getImageFromGallery();

                          Uint8List uint8List =
                          await compressFile(File(file.path));

                          imageUpload.addSelectedImg2(uint8List);
                          print("image selected${uint8List}");
                        }, child: GetBuilder<ImageUploadViewModel>(
                          builder: (controller) {
                            if (controller.selectedImg2 == null) {
                              return Container(
                                width: SizeConfig.screenWidth * 0.4,
                                height: SizeConfig.screenHeight * 0.15,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[200],
                                          spreadRadius: 1.0,
                                          blurRadius: 2.0),
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_circle,
                                      color: Color(colorBlue),
                                      size: SizeConfig.blockSizeVertical * 6,
                                    ),
                                    Text("Add Book Pic")
                                  ],
                                ),
                              );
                            }

                            return Container(
                              width: SizeConfig.screenWidth * 0.4,
                              height: SizeConfig.screenHeight * 0.15,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[200],
                                        spreadRadius: 1.0,
                                        blurRadius: 2.0),
                                  ],
                                  image: DecorationImage(
                                      image: MemoryImage(controller.selectedImg2),
                                      fit: BoxFit.cover)),
                            );
                          },
                        )),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(onTap: () async {
                          ImageUploadViewModel imageUpload = Get.find();
                          XFile file = await getImageFromGallery();

                          Uint8List uint8List =
                          await compressFile(File(file.path));

                          imageUpload.addSelectedImg3(uint8List);
                          print("image selected${uint8List}");
                        }, child: GetBuilder<ImageUploadViewModel>(
                          builder: (controller) {
                            if (controller.selectedImg3 == null) {
                              return Container(
                                width: SizeConfig.screenWidth * 0.4,
                                height: SizeConfig.screenHeight * 0.15,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[200],
                                          spreadRadius: 1.0,
                                          blurRadius: 2.0),
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_circle,
                                      color: Color(colorBlue),
                                      size: SizeConfig.blockSizeVertical * 6,
                                    ),
                                    Text("Add Book Pic")
                                  ],
                                ),
                              );
                            }

                            return Container(
                              width: SizeConfig.screenWidth * 0.4,
                              height: SizeConfig.screenHeight * 0.15,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[200],
                                        spreadRadius: 1.0,
                                        blurRadius: 2.0),
                                  ],
                                  image: DecorationImage(
                                      image: MemoryImage(controller.selectedImg3),
                                      fit: BoxFit.cover)),
                            );
                          },
                        )),
                        GestureDetector(onTap: () async {
                          ImageUploadViewModel imageUpload = Get.find();
                          XFile file = await getImageFromGallery();

                          Uint8List uint8List =
                          await compressFile(File(file.path));

                          imageUpload.addSelectedImg4(uint8List);
                          print("image selected${uint8List}");
                        }, child: GetBuilder<ImageUploadViewModel>(
                          builder: (controller) {
                            if (controller.selectedImg4 == null) {
                              return Container(
                                width: SizeConfig.screenWidth * 0.4,
                                height: SizeConfig.screenHeight * 0.15,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[200],
                                          spreadRadius: 1.0,
                                          blurRadius: 2.0),
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_circle,
                                      color: Color(colorBlue),
                                      size: SizeConfig.blockSizeVertical * 6,
                                    ),
                                    Text("Add Book Pic")
                                  ],
                                ),
                              );
                            }

                            return Container(
                              width: SizeConfig.screenWidth * 0.4,
                              height: SizeConfig.screenHeight * 0.15,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[200],
                                        spreadRadius: 1.0,
                                        blurRadius: 2.0),
                                  ],
                                  image: DecorationImage(
                                      image: MemoryImage(controller.selectedImg4),
                                      fit: BoxFit.cover)),
                            );
                          },
                        )),
                      ],
                    ),
                  ],
                ),
              ),
              Form(
                key: profileForm,
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
                                blurRadius: 4.0),
                          ]),
                      child: TextFormField(
                        controller: bookName,
                        focusNode: bookNameFn,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (value) {
                          bookNameFn.unfocus();
                          FocusScope.of(context).requestFocus(authorFn);
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: SizeConfig.blockSizeVertical * 1.5,
                              horizontal: SizeConfig.blockSizeHorizontal * 5),
                          hintText: "Book Name",
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
                                blurRadius: 4.0),
                          ]),
                      child: TextFormField(
                        controller: author,
                        focusNode: authorFn,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (value) {
                          authorFn.unfocus();
                          FocusScope.of(context).requestFocus(editionFn);
                        },
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical * 1.5,
                                horizontal: SizeConfig.blockSizeHorizontal * 5),
                            hintText: "Author Name",
                            hintStyle: TextStyle(
                              color: Color(hintGrey),
                              fontWeight: FontWeight.w500,
                            ),
                            border: InputBorder.none),
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
                                blurRadius: 4.0),
                          ]),
                      child: TextFormField(
                        controller: edition,
                        focusNode: editionFn,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (value) {
                          editionFn.unfocus();
                          FocusScope.of(context).requestFocus(semesterFn);
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: SizeConfig.blockSizeVertical * 1.5,
                              horizontal: SizeConfig.blockSizeHorizontal * 5),
                          hintText: "Edition Detail",
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
                          Container(
                              width: SizeConfig.screenWidth * 0.35,
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[200],
                                        spreadRadius: 2.0,
                                        blurRadius: 4.0),
                                  ]),
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
                                  "Semester",
                                  style: TextStyle(
                                    fontSize:
                                        SizeConfig.blockSizeVertical * 1.50,
                                  ),
                                ),
                                items: <String>[
                                  'Semester 1',
                                  'Semester 2',
                                  'Semester 3',
                                  'Semester 4',
                                  'Semester 5',
                                  'Semester 6',
                                  'Semester 7',
                                  'Semester 8'
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(
                                      value,
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeVertical *
                                                  1.75,
                                          color: Color(hintGrey)),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  semester.text = val;
                                },
                              )),
                          Container(
                              width: SizeConfig.screenWidth * 0.35,
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[200],
                                        spreadRadius: 2.0,
                                        blurRadius: 4.0),
                                  ]),
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
                                  "Condition",
                                  style: TextStyle(
                                    fontSize:
                                        SizeConfig.blockSizeVertical * 1.50,
                                  ),
                                ),
                                items:
                                    <String>['Good', 'Bad'].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(
                                      value,
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeVertical *
                                                  1.75,
                                          color: Color(hintGrey)),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  conditions.text = val;
                                },
                              )),
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
                                blurRadius: 4.0),
                          ]),
                      child: TextFormField(
                        controller: desc,
                        focusNode: descFn,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (value) {
                          descFn.unfocus();
                        },
                        maxLength: 50,
                        maxLines: 3,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: SizeConfig.blockSizeVertical * 1.5,
                              horizontal: SizeConfig.blockSizeHorizontal * 5),
                          hintText: "Description",
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: SizeConfig.screenWidth * 0.4,
                            height: SizeConfig.blockSizeVertical * 5,
                            margin: EdgeInsets.only(
                                left: SizeConfig.screenWidth * 0.05,
                                right: SizeConfig.screenWidth * 0.05,
                                top: SizeConfig.blockSizeVertical * 3,
                                bottom: SizeConfig.blockSizeVertical),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(colorBlue),
                                ),
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.white),
                            child: TextFormField(
                              controller: price,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Price",
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  contentPadding: EdgeInsets.only(top: 8),
                                  isDense: true),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                            ),
                          ),
                          Container(
                            width: SizeConfig.screenWidth * 0.4,
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
                                if(profileForm.currentState.validate()){
                                  if(bookName.text.isEmpty || bookName.text == null){
                                    CommonSnackBar.snackBar(
                                        message:
                                        "Please enter book name");
                                    return;
                                  }

                                  if(author.text.isEmpty || author.text == null){
                                    CommonSnackBar.snackBar(
                                        message:
                                        "Please enter author name");
                                    return;
                                  }

                                  if(price.text.isEmpty || price.text == null){
                                    CommonSnackBar.snackBar(
                                        message:
                                        "Please enter price");
                                    return;
                                  }

                                  BookAddViewModel bookAddViewModel =
                                  Get.put(BookAddViewModel());
                                  ImageUploadViewModel imaUploadViewModel =
                                  Get.put(ImageUploadViewModel());                                  print(
                                      "image selected${imaUploadViewModel.selectedImg}");
                                  BookAdd bookAddReq = BookAdd();
                                  bookAddReq.user_id = "${PreferenceManager.getUserId()}";
                                  bookAddReq.session_key = "${PreferenceManager.getSessionKey()}";
                                  bookAddReq.category_id = "1";
                                  bookAddReq.name = bookName.text;
                                  bookAddReq.auther_name = author.text;
                                  bookAddReq.edition_detail = edition.text;
                                  bookAddReq.semester = semester.text;
                                  bookAddReq.conditions = conditions.text;
                                  bookAddReq.description = desc.text;
                                  bookAddReq.price = price.text;
                                  bookAddReq.image1 = imaUploadViewModel.selectedImg;
                                  bookAddReq.image2 = imaUploadViewModel.selectedImg2;
                                  bookAddReq.image3 = imaUploadViewModel.selectedImg3;
                                  bookAddReq.image4 = imaUploadViewModel.selectedImg4;

                                  await bookAddViewModel.bookAdd(bookAddReq);
                                  // if (bookAddViewModel.apiResponse.status ==
                                  //     Status.COMPLETE) {
                                    RegisterResponseModel response =
                                        bookAddViewModel.apiResponse.data;
                                    if (response.status == '200') {
                                      CommonSnackBar.snackBar(
                                          message: response.message);

                                      Future.delayed(Duration(seconds: 2), () {
                                        Get.back();
                                        bookName.clear();
                                        author.clear();
                                        price.clear();
                                        desc.clear();
                                        edition.clear();
                                      });
                                      Navigator.pop(context);
                                    } else {
                                      CommonSnackBar.snackBar(
                                          message: response.message);
                                    }
                                  // } else {
                                  //   CommonSnackBar.snackBar(
                                  //       message: "Server Errorrr");
                                  // }
                                }
                              },
                              child: Text(
                                "Sell Now",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
             /* GetBuilder<BookAddViewModel>(
                builder: (controller) {
                  if (controller.apiResponse.status == Status.LOADING) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return SizedBox();
                  }
                },
              )*/
            ],
          ),
        ),
      ),
    );
  }

  Future<BookDataModel> _callBookDataAPI() async {
    Map<String, dynamic> body = {
      "user_id": "${PreferenceManager.getUserId()}",
      "session_key": PreferenceManager.getSessionKey(),
      "id": widget.catId,
    };

    var res = await ApiCall.post(bookDetailURL, body);
    var jsonResponse = json.decode(json.encode(res).toString());
    var data = new BookDataModel.fromJson(jsonResponse);


    return data;
  }
}
