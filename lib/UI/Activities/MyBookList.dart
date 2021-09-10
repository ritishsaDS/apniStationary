import 'dart:convert';
import 'dart:developer';

import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/UI/Activities/BookDetails.dart';
import 'package:book_buy_and_sell/UI/Activities/SellBook.dart';
import 'package:book_buy_and_sell/Utils/ApiCall.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/Utils/commonLV.dart';
import 'package:book_buy_and_sell/Utils/constantString.dart';
import 'package:book_buy_and_sell/common/common_snackbar.dart';
import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:book_buy_and_sell/model/apiModel/responseModel/MyBooksModel.dart';
import 'package:flutter/material.dart';

class MyBookList extends StatefulWidget {
  const MyBookList({Key key}) : super(key: key);

  @override
  _MyBookListState createState() => _MyBookListState();
}

class _MyBookListState extends State<MyBookList> {

  List<MyBooksModel> myBooksModel;

  Future<Widget> getBookList() async {
    Map<String, dynamic> body = {
      "user_id": "${PreferenceManager.getUserId()}",
      "session_key": PreferenceManager.getSessionKey()
    };
    var res = await ApiCall.apiCall(myBookListURL, body);
    if (res.statusCode == 256) {
      var jsonDecoded = jsonDecode(res.body);
      if (jsonDecoded["status"] == "200") {
        var imageBaseUrl = jsonDecoded["image_url"];
        myBooksModel = (jsonDecoded["date"] as List)
            .map((e) => MyBooksModel.fromJson(e))
            .toList();
        if (myBooksModel.length > 0) {
          return ListView.builder(
            itemBuilder: (context, int index) {
              return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return BookDetail("");
                    }));
                  },
                  child: Container(
                      width: SizeConfig.screenWidth,
                      margin:
                          EdgeInsets.only(bottom: SizeConfig.blockSizeVertical),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200],
                                spreadRadius: 3.0,
                                blurRadius: 2.0)
                          ]),
                      child: Row(children: [
                        Container(
                            width: SizeConfig.screenWidth * 0.2,
                            height: SizeConfig.screenHeight * 0.15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                    imageBaseUrl +
                                        "/" +
                                        myBooksModel[index].image,
                                    fit: BoxFit.cover))),
                        Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 4),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    myBooksModel[index].name,
                                    style: TextStyle(
                                        color: Color(0XFF06070D),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    myBooksModel[index].price,
                                    style: TextStyle(
                                        color: Color(colorBlue),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.blockSizeVertical,
                                  ),
                                  Row(children: [
                                    Container(
                                        width: SizeConfig.screenWidth * 0.2,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Author: ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0XFF656565),
                                                    fontSize: SizeConfig
                                                            .blockSizeVertical *
                                                        1.5),
                                              ),
                                              SizedBox(
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    0.5,
                                              ),
                                              Text(
                                                "Edition Detail: ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0XFF656565),
                                                    fontSize: SizeConfig
                                                            .blockSizeVertical *
                                                        1.5),
                                              ),
                                              SizedBox(
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    0.5,
                                              ),
                                              Text(
                                                "Semester: ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0XFF656565),
                                                    fontSize: SizeConfig
                                                            .blockSizeVertical *
                                                        1.5),
                                              ),
                                              SizedBox(
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    0.5,
                                              ),
                                              Text(
                                                "Condition: ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0XFF656565),
                                                    fontSize: SizeConfig
                                                            .blockSizeVertical *
                                                        1.5),
                                              )
                                            ])),
                                    Container(
                                        width: SizeConfig.screenWidth * 0.3,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                myBooksModel[index].autherName,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0XFF656565),
                                                    fontSize: SizeConfig
                                                            .blockSizeVertical *
                                                        1.5),
                                              ),
                                              SizedBox(
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    0.5,
                                              ),
                                              Text(
                                                myBooksModel[index]
                                                    .edition_detail,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0XFF656565),
                                                    fontSize: SizeConfig
                                                            .blockSizeVertical *
                                                        1.5),
                                              ),
                                              SizedBox(
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    0.5,
                                              ),
                                              Text(
                                                myBooksModel[index].semester,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0XFF656565),
                                                    fontSize: SizeConfig
                                                            .blockSizeVertical *
                                                        1.5),
                                              ),
                                              SizedBox(
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    0.5,
                                              ),
                                              Text(
                                                  myBooksModel[index].condition,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0XFF656565),
                                                      fontSize: SizeConfig
                                                              .blockSizeVertical *
                                                          1.5))
                                            ]))
                                  ]),
                                  Container(
                                      width: SizeConfig.screenWidth * 0.6,
                                      alignment: Alignment.centerRight,
                                      child: PopupMenuButton(
                                          icon: Icon(Icons.more_vert),
                                          enabled: true,
                                          onSelected: (value) {
                                            log("message $value");

                                            // setState(() {
                                            //   selectedMenu = value;
                                            if (value == 1) {
                                              CommonSnackBar.snackBar(
                                                  message: 'Edit clicked');
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                        return SellBook(myBooksModel[index].id
                                                            .toString());
                                                      }));
                                            } else {
                                              deleteBookAPI(
                                                  myBooksModel[index].id,index);
                                            }

                                            // });
                                          },
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                              child: Text("Edit"),
                                              value: 1,
                                            ),
                                            PopupMenuItem(
                                              child: Text("Delete"),
                                              value: 2,
                                            )
                                          ]))
                                ]))
                      ])));
            },
            shrinkWrap: true,
            itemCount: 4,
            primary: false,
          );
        } else {
          return Text("No Data found");
        }
      } else {
        return Text(jsonDecoded['message']);
      }
    } else {
      return Text("No Data found");
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
                  vertical: SizeConfig.blockSizeVertical),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Color(colorBlue))),
              child: Row(
                children: [
                  Container(
                    width: SizeConfig.screenWidth * 0.8,
                    child: TextFormField(
                      textInputAction: TextInputAction.search,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: SizeConfig.blockSizeVertical * 1.5,
                              horizontal: SizeConfig.blockSizeHorizontal * 5),
                          hintText: "Search an item",
                          hintStyle: TextStyle(
                            color: Color(0XFF787878),
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                  Icon(
                    Icons.search,
                    color: Color(colorBlue),
                  ),
                ],
              ),
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.05,
                  vertical: SizeConfig.blockSizeVertical),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nearby Products",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Color(black)),
                      ),
                      Container(
                        width: SizeConfig.screenWidth * 0.3,
                        height: SizeConfig.blockSizeVertical * 0.2,
                        decoration: BoxDecoration(color: Color(colorBlue)),
                      ),
                    ],
                  ),
                  Container(
                    width: SizeConfig.screenWidth * 0.4,
                    height: SizeConfig.blockSizeVertical * 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Color(colorBlue),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: SizeConfig.screenWidth * 0.25,
                          height: SizeConfig.blockSizeVertical * 4,
                          alignment: Alignment.center,
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Nearby Products",
                                hintStyle: TextStyle(
                                  color: Color(hintGrey),
                                  fontSize: SizeConfig.blockSizeVertical * 1.25,
                                ),
                                contentPadding: EdgeInsets.only(
                                    bottom:
                                        SizeConfig.blockSizeVertical * 2.5)),
                            textAlign: TextAlign.center,
                            readOnly: true,
                          ),
                        ),
                        Container(
                          width: SizeConfig.screenWidth * 0.1,
                          height: SizeConfig.blockSizeVertical * 4,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(25),
                                  topRight: Radius.circular(25)),
                              color: Color(colorBlue)),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                            size: SizeConfig.blockSizeVertical * 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.05,
                  vertical: SizeConfig.blockSizeVertical),
              child: CommonLV(dataCallingMethod: getBookList()),
            ),
          ],
        ),
      ),
    ));
  }

  deleteBookAPI(int book_id, int index) async {
    Map<String, dynamic> body = {
      "user_id": "${PreferenceManager.getUserId()}",
      "session_key": PreferenceManager.getSessionKey(),
      "id": "$book_id",
    };

    var res = await ApiCall.apiCall(bookDeleteURL, body);
    log("message $res");

    setState(() {
      myBooksModel = List.from(myBooksModel)
        ..removeAt(index);
      CommonSnackBar.snackBar(
          message: 'Deleted successfully');
      getBookList();
    });

  }


}
