import 'dart:convert';
import 'dart:developer';
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
import 'package:book_buy_and_sell/common/utility.dart';
import 'package:book_buy_and_sell/model/ClassModel/BookDataModel.dart';
import 'package:book_buy_and_sell/model/apiModel/requestModel/BookAdd.dart';
import 'package:book_buy_and_sell/model/apiModel/requestModel/BookEdit.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/register_response_model.dart';
import 'package:book_buy_and_sell/viewModel/book_add_view_model.dart';
import 'package:book_buy_and_sell/viewModel/image_upload_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Donescreen.dart';

class SellBook extends StatefulWidget {
  String catId = "", bookId = "";

  SellBook({this.catId, this.bookId});

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
bool isLoading=false;
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
                      child: Row(children: [
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
                            child: Row(children: [
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
                            ])),
                        ImageIcon(AssetImage('assets/icons/notification.png'),
                            color: Color(colorBlue),
                            size: SizeConfig.blockSizeVertical * 4)
                      ])),
                  _editCheck(),

                  /* GetBuilder<BookAddViewModel>(
                builder: (controller) {
                  if (controller.apiResponse.status == Status.LOADING) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return SizedBox();
                  }
                },
              )*/
                ]))));
  }

  Widget _editCheck() {
    if (!Utility.isNullOrEmpty(widget.bookId)) {
      return FutureBuilder<BookDataModel>(
          future: _callBookDataAPI(),
          builder: (context, AsyncSnapshot<BookDataModel> snapshot) {
            if (snapshot.hasData) {
              return _commonWidget(snapshot.data.image_url, snapshot.data.date);
            } else {
              BookDataDetailsModel bookDataDetailsModel =
                  new BookDataDetailsModel(
                      name: "",
                      auther_name: "",
                      edition_detail: "",
                      price: "",
                      conditions: "",
                      category_id: "",
                      description: "",
                      semester: "",
                      image1: "",
                      image2: "",
                      image3: "",
                      image4: "");
              return _commonWidget("", bookDataDetailsModel);
            }
          });
    } else {
      BookDataDetailsModel bookDataDetailsModel = new BookDataDetailsModel(
          name: "",
          auther_name: "",
          edition_detail: "",
          price: "",
          conditions: "",
          category_id: "",
          description: "",
          semester: "",
          image1: "",
          image2: "",
          image3: "",
          image4: "");
      return _commonWidget("", bookDataDetailsModel);
    }
  }

  Widget _commonWidget(String image_url, BookDataDetailsModel data) {
    log("DeepakData ${data.toString()}");
    return Column(children: [
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
                  color: Colors.grey[200], blurRadius: 4.0, spreadRadius: 1.0),
            ],
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(onTap: () =>  showAlertDialog(context,1),
                     child:
                        GetBuilder<ImageUploadViewModel>(builder: (controller) {
                      if (controller.selectedImg == null) {
                        if (data.image1 != "") {
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
                                      image: NetworkImage(
                                          image_url + "/" + data.image1),
                                      fit: BoxFit.cover)));
                        } else {
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
                                  ]));
                        }
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
                    })),
                    GestureDetector(onTap: () async {
                      showAlertDialog2(context,2);
                    }, child: GetBuilder<ImageUploadViewModel>(
                      builder: (controller) {
                        if (controller.selectedImg2 == null) {
                          if (data.image2 != "") {
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
                                      image: NetworkImage(
                                          image_url + "/" + data.image2),
                                      fit: BoxFit.cover)),
                            );
                          } else {
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_circle,
                                        color: Color(colorBlue),
                                        size: SizeConfig.blockSizeVertical * 6,
                                      ),
                                      Text("Add Book Pic")
                                    ]));
                          }
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
                      GestureDetector(onTap:()=>showAlertDialog3(context,3),

                        child: GetBuilder<ImageUploadViewModel>(
                        builder: (controller) {
                          if (controller.selectedImg3 == null) {
                            if (data.image3 != "") {
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
                                        image: NetworkImage(
                                            image_url + "/" + data.image3),
                                        fit: BoxFit.cover)),
                              );
                            } else {
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_circle,
                                          color: Color(colorBlue),
                                          size:
                                              SizeConfig.blockSizeVertical * 6,
                                        ),
                                        Text("Add Book Pic")
                                      ]));
                            }
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
                                      image:
                                          MemoryImage(controller.selectedImg3),
                                      fit: BoxFit.cover)));
                        },
                      )),
                      GestureDetector(onTap:()=>showAlertDialog4(context,4)
                       , child: GetBuilder<ImageUploadViewModel>(
                        builder: (controller) {
                          if (controller.selectedImg4 == null) {
                            if (data.image4 != "") {
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
                                        image: NetworkImage(
                                            image_url + "/" + data.image4),
                                        fit: BoxFit.cover)),
                              );
                            } else {
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_circle,
                                          color: Color(colorBlue),
                                          size:
                                              SizeConfig.blockSizeVertical * 6,
                                        ),
                                        Text("Add Book Pic")
                                      ]));
                            }
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
                                        blurRadius: 2.0)
                                  ],
                                  image: DecorationImage(
                                      image:
                                          MemoryImage(controller.selectedImg4),
                                      fit: BoxFit.cover)));
                        },
                      ))
                    ])
              ])),
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
                                        blurRadius: 4.0)
                                  ]),
                              child: DropdownButtonFormField<String>(
                                // value: Utility.checkNSetData(data.semester),
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
                                        SizeConfig.blockSizeVertical *2,
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
                                      ));
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
                                // value: Utility.checkNSetData(data.conditions),
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
                                        SizeConfig.blockSizeVertical * 2,
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
                        ])),
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
                              onChanged: (val){
                                setState(() {
                                  data.price=val;
                                });

                              },
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
                                  ImageUploadViewModel imaUploadViewModel =
                                  Get.put(ImageUploadViewModel());
                                  if (profileForm.currentState.validate()) {
                                    if (bookName.text.isEmpty ||
                                        bookName.text == null) {
                                      CommonSnackBar.snackBar(
                                          message: "Please enter book name");
                                      return;
                                    }

                                    if (author.text.isEmpty ||
                                        author.text == null) {
                                      CommonSnackBar.snackBar(
                                          message: "Please enter author name");
                                      return;
                                    }

                                    if (price.text.isEmpty ||
                                        price.text == null) {
                                      CommonSnackBar.snackBar(
                                          message: "Please enter price");
                                      return;
                                    }
                                    if (desc.text.isEmpty ||
                                        desc.text == null) {
                                      CommonSnackBar.snackBar(
                                          message: "Please enter Description");
                                      return;
                                    }
                                    if (edition.text.isEmpty ||
                                        edition.text == null) {
                                      CommonSnackBar.snackBar(
                                          message: "Please enter Edition deatil");
                                      return;
                                    }

                                    if( imaUploadViewModel.selectedImg==null||imaUploadViewModel.selectedImg==""){
                                      CommonSnackBar.snackBar(
                                          message: "Please enter image");
                                      return;
                                    }
if(semester.text.isEmpty||semester.text==null){
  CommonSnackBar.snackBar(
      message: "Please enter Semester");
  return;
}
                                    if(conditions.text.isEmpty||conditions.text==null){
                                      CommonSnackBar.snackBar(
                                          message: "Please enter conditions");
                                      return;
                                    }
                                    if( imaUploadViewModel.selectedImg2==null||imaUploadViewModel.selectedImg2==""){
                                      CommonSnackBar.snackBar(
                                          message: "Please enter image");
                                      return;
                                    }
                                    if( imaUploadViewModel.selectedImg3==null||imaUploadViewModel.selectedImg3==""){
                                      CommonSnackBar.snackBar(
                                          message: "Please enter image");
                                      return;
                                    }
                                    if( imaUploadViewModel.selectedImg4==null||imaUploadViewModel.selectedImg4==""){
                                      CommonSnackBar.snackBar(
                                          message: "Please enter image");
                                      return;
                                    }

                                    if (widget.bookId !=null) {

                                      print(BookAddViewModel().apiResponse);
                                      BookAddViewModel bookAddViewModel =
                                          Get.put(BookAddViewModel());
                                      ImageUploadViewModel imaUploadViewModel =
                                          Get.put(ImageUploadViewModel());
                                      print(
                                          "image selected${imaUploadViewModel.selectedImg}");
                                      BookEdit bookEditReq = BookEdit();
                                      bookEditReq.id = widget.bookId;
                                      bookEditReq.user_id =
                                          "${PreferenceManager.getUserId()}";
                                      bookEditReq.session_key =
                                          "${PreferenceManager.getSessionKey()}";
                                      bookEditReq.category_id = widget.catId;
                                      bookEditReq.name = bookName.text;
                                      bookEditReq.auther_name = author.text;
                                      bookEditReq.edition_detail = edition.text;
                                      bookEditReq.semester = semester.text;
                                      bookEditReq.conditions = conditions.text;
                                      bookEditReq.description = desc.text;
                                      bookEditReq.price = price.text;
                                      bookEditReq.image1 =
                                          imaUploadViewModel.selectedImg;
                                      bookEditReq.image2 =
                                          imaUploadViewModel.selectedImg2;
                                      bookEditReq.image3 =
                                          imaUploadViewModel.selectedImg3;
                                      bookEditReq.image4 =
                                          imaUploadViewModel.selectedImg4;

                                      await bookAddViewModel
                                          .bookEdit(bookEditReq);

                                      // if (bookAddViewModel.apiResponse.status ==
                                      //     Status.COMPLETE) {
                                      RegisterResponseModel response =
                                          bookAddViewModel.apiResponse.data;

                                      if (response.status == '200') {
                                        CommonSnackBar.snackBar(
                                            message: response.message);

                                        Future.delayed(Duration(seconds: 2),
                                            () {
                                          Get.back();
                                        });
                                        Navigator.pop(context);
                                      } else {
                                        CommonSnackBar.snackBar(
                                            message: response.message);
                                      }
                                    }
                                    else {
setState(() {
  isLoading=true;
});
                                      BookAddViewModel bookAddViewModel =
                                          Get.put(BookAddViewModel());
                                      ImageUploadViewModel imaUploadViewModel =
                                          Get.put(ImageUploadViewModel());
                                      print(
                                          "image selected${imaUploadViewModel.selectedImg}");
                                      BookAdd bookAddReq = BookAdd();
                                      bookAddReq.user_id =
                                          "${PreferenceManager.getUserId()}";
                                      bookAddReq.session_key =
                                          "${PreferenceManager.getSessionKey()}";
                                      bookAddReq.category_id = widget.catId;
                                      bookAddReq.name = bookName.text;
                                      bookAddReq.auther_name = author.text;
                                      bookAddReq.edition_detail = edition.text;
                                      bookAddReq.semester = semester.text;
                                      bookAddReq.conditions = conditions.text;
                                      bookAddReq.description = desc.text;
                                      bookAddReq.price = price.text;
                                      bookAddReq.image1 =
                                          imaUploadViewModel.selectedImg;
                                      bookAddReq.image2 =
                                          imaUploadViewModel.selectedImg2;
                                      bookAddReq.image3 =
                                          imaUploadViewModel.selectedImg3;
                                      bookAddReq.image4 =
                                          imaUploadViewModel.selectedImg4;

                                      await bookAddViewModel
                                          .bookAdd(bookAddReq);
                                      // if (bookAddViewModel.apiResponse.status ==
                                      //     Status.COMPLETE) {
                                      print(bookAddViewModel.toString());

                                      RegisterResponseModel response =
                                          bookAddViewModel.apiResponse.data;
                                      Future.delayed(Duration(seconds: 1),
                                              () {
                                               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CheckAnimation()));
                                           // Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckAnimation()));
                                          });
                                      //print("jksdajn"+response.status);
                                      if (response.status == '256') {
                                        CommonSnackBar.snackBar(
                                            message: response.message);

                                        Future.delayed(Duration(seconds: 2),
                                            () {
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
                                    }
                                  }
                                },
                                child:isLoading?
                                    CircularProgressIndicator(color: Colors.white,): Text("Sell Now",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                              ))
                        ]))
              ]))
    ]);
  }

  Future<BookDataModel> _callBookDataAPI() async {
    Map<String, dynamic> body = {
      "user_id": "${PreferenceManager.getUserId()}",
      "session_key": PreferenceManager.getSessionKey(),
      "id": widget.bookId,
    };

    var res = await ApiCall.post(bookDetailURL, body);
    var jsonResponse = json.decode(json.encode(res).toString());
    var data = new BookDataModel.fromJson(jsonResponse);

    return data;
  }
    showAlertDialog(BuildContext context,number)  {

      // set up the button
      Widget Camera =Column(children: [
        GestureDetector(child: Container(height: SizeConfig.blockSizeVertical*14,width: SizeConfig.blockSizeVertical*10,child: CircleAvatar(backgroundColor: Colors.white70,backgroundImage: AssetImage("assets/icons/camera.jpeg",))),
            onTap: () async {
              Navigator.pop(context);
              ImageUploadViewModel imageUpload = Get.find();
              XFile file = await getImageFromCamera();

              Uint8List uint8List =
              await compressFile(File(file.path));

              imageUpload.addSelectedImg(uint8List);
              print("image selected${uint8List}");
            }

        ),
        Text("Camera")
      ],);
      Widget gallery = Column(children: [
        GestureDetector(child: Container(height: SizeConfig.blockSizeVertical*14,width: SizeConfig.blockSizeVertical*14,child: CircleAvatar(
            backgroundColor: Colors.white38,
            backgroundImage: AssetImage("assets/icons/gallery.jpeg",))),
            onTap: ()  async {
              Navigator.pop(context);
              ImageUploadViewModel imageUpload = Get.find();
              XFile file = await getImageFromGallery();

              Uint8List uint8List =
              await compressFile(File(file.path));

              imageUpload.addSelectedImg(uint8List);
              print("image selected${uint8List}");
            }

        ),
        Text("Gallery")
      ],);

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                25.0
            )),


        content: Container(
            height: SizeConfig.screenHeight*0.20,
            child: Column(
              children: [
                Text("Upload Image "),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ Camera,
                    SizedBox(width: 30,),
                    gallery,],)
              ],
            )),

      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  showAlertDialog2(BuildContext context,number)  {

    // set up the button
    Widget Camera =Column(children: [
      GestureDetector(child: Container(height: SizeConfig.blockSizeVertical*14,width: SizeConfig.blockSizeVertical*10,child: CircleAvatar(backgroundColor: Colors.white70,backgroundImage: AssetImage("assets/icons/camera.jpeg",))),
          onTap: () async {
            Navigator.pop(context);
            ImageUploadViewModel imageUpload = Get.find();
            XFile file = await getImageFromCamera();

            Uint8List uint8List =
            await compressFile(File(file.path));

            imageUpload.addSelectedImg2(uint8List);
            print("image selected${uint8List}");
          }

      ),
      Text("Camera")
    ],);
    Widget gallery = Column(children: [
      GestureDetector(child: Container(height: SizeConfig.blockSizeVertical*14,width: SizeConfig.blockSizeVertical*14,child: CircleAvatar(
          backgroundColor: Colors.white38,
          backgroundImage: AssetImage("assets/icons/gallery.jpeg",))),
          onTap: ()  async {
            Navigator.pop(context);
            ImageUploadViewModel imageUpload = Get.find();
            XFile file = await getImageFromGallery();

            Uint8List uint8List =
            await compressFile(File(file.path));

            imageUpload.addSelectedImg2(uint8List);
            print("image selected${uint8List}");
          }

      ),
      Text("Gallery")
    ],);

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              25.0
          )),


      content: Container(
          height: SizeConfig.screenHeight*0.20,
          child: Column(
            children: [
              Text("Upload Image "),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ Camera,
                  SizedBox(width: 30,),
                  gallery,],)
            ],
          )),

    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  showAlertDialog3(BuildContext context,number) {

    // set up the button
    Widget Camera =Column(children: [
      GestureDetector(child: Container(height: SizeConfig.blockSizeVertical*14,width: SizeConfig.blockSizeVertical*10,child: CircleAvatar(backgroundColor: Colors.white70,backgroundImage: AssetImage("assets/icons/camera.jpeg",))),
          onTap: () async {
            Navigator.pop(context);
            ImageUploadViewModel imageUpload = Get.find();
            XFile file = await getImageFromCamera();

            Uint8List uint8List =
            await compressFile(File(file.path));

            imageUpload.addSelectedImg3(uint8List);
            print("image selected${uint8List}");
          }

      ),
      Text("Camera")
    ],);
    Widget gallery = Column(children: [
      GestureDetector(child: Container(height: SizeConfig.blockSizeVertical*14,width: SizeConfig.blockSizeVertical*14,child: CircleAvatar(
          backgroundColor: Colors.white38,
          backgroundImage: AssetImage("assets/icons/gallery.jpeg",))),
          onTap: ()  async {
            Navigator.pop(context);
            ImageUploadViewModel imageUpload = Get.find();
            XFile file = await getImageFromGallery();

            Uint8List uint8List =
            await compressFile(File(file.path));

            imageUpload.addSelectedImg3(uint8List);
            print("image selected${uint8List}");
          }

      ),
      Text("Gallery")
    ],);

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              25.0
          )),


      content: Container(
          height: SizeConfig.screenHeight*0.20,
          child: Column(
            children: [
              Text("Upload Image "),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ Camera,
                  SizedBox(width: 30,),
                  gallery,],)
            ],
          )),

    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  showAlertDialog4(BuildContext context,number) {

    // set up the button
    Widget Camera =Column(children: [
      GestureDetector(child: Container(height: SizeConfig.blockSizeVertical*14,width: SizeConfig.blockSizeVertical*10,child: CircleAvatar(backgroundColor: Colors.white70,backgroundImage: AssetImage("assets/icons/camera.jpeg",))),
          onTap: () async {
            Navigator.pop(context);
            ImageUploadViewModel imageUpload = Get.find();
            XFile file = await getImageFromCamera();

            Uint8List uint8List =
            await compressFile(File(file.path));

            imageUpload.addSelectedImg4(uint8List);
            print("image selected${uint8List}");
          }

      ),
      Text("Camera")
    ],);
    Widget gallery = Column(children: [
      GestureDetector(child: Container(height: SizeConfig.blockSizeVertical*14,width: SizeConfig.blockSizeVertical*14,child: CircleAvatar(
          backgroundColor: Colors.white38,
          backgroundImage: AssetImage("assets/icons/gallery.jpeg",))),
          onTap: ()  async {
            Navigator.pop(context);
            ImageUploadViewModel imageUpload = Get.find();
            XFile file = await getImageFromGallery();

            Uint8List uint8List =
            await compressFile(File(file.path));

            imageUpload.addSelectedImg4(uint8List);
            print("image selected${uint8List}");
          }

      ),
      Text("Gallery")
    ],);

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                 25.0
                )),


      content: Container(
          height: SizeConfig.screenHeight*0.20,
          child: Column(
        children: [
          Text("Upload Image "),
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [ Camera,
           SizedBox(width: 30,),
           gallery,],)
        ],
      )),

    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

// void _showBottomSheet(){
  //   showModalBottomSheet(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(
  //           top: Radius.circular(80),
  //         ),
  //       ),
  //       context: context,
  //       builder: (builder){
  //         return new Container(
  //           height: 350.0,
  //           color: Colors.transparent, //could change this to Color(0xFF737373),
  //           //so you don't have to change MaterialApp canvasColor
  //           child: new Container(
  //               decoration: new BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: new BorderRadius.only(
  //                       topLeft: const Radius.circular(10.0),
  //                       topRight: const Radius.circular(10.0))),
  //               child: new Center(
  //                 child: new Text("This is a modal sheet"),
  //               )),
  //         );
  //       }
  //   );
  // }
}
