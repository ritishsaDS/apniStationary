import 'dart:convert';

import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/Constants/StringConstants.dart';
import 'package:book_buy_and_sell/Utils/ApiCall.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/Utils/constantString.dart';
import 'package:book_buy_and_sell/common/common_snackbar.dart';
import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:book_buy_and_sell/common/utility.dart';
import 'package:book_buy_and_sell/model/ClassModel/CartListModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

class Cart extends StatefulWidget {
  const Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
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
                  /* Container(
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
                      ), */
                  /* ImageIcon(
                        AssetImage('assets/icons/notification.png'),
                        color: Color(colorBlue),
                        size: SizeConfig.blockSizeVertical * 4,
                      )*/
                ],
              ),
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.05,
                  vertical: SizeConfig.blockSizeVertical),
              child: Text(
                "My Cart",
                style: TextStyle(
                    color: Color(black),
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.blockSizeVertical * 2),
              ),
            ),
            _getCartData(),
            /*  SizedBox(
                  height: SizeConfig.screenHeight * 0.15,
                ),
                Container(
                  width: SizeConfig.screenWidth,
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.05),
                  height: SizeConfig.blockSizeVertical * 7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color.fromRGBO(212, 247, 255, 0.45)),
                  child: MaterialButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        ImageIcon(
                          AssetImage('assets/icons/offer.png'),
                          color: Color(colorBlue),
                          size: SizeConfig.blockSizeVertical * 4,
                        ),
                        Text(
                          "Get 10% off on 1st Purchase.",
                          style: TextStyle(
                              color: Color(black),
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig.blockSizeVertical * 1.65),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 4,
                        ),
                        MaterialButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          color: Colors.white,
                          child: Text(
                            "Apply Now",
                            style: TextStyle(
                                color: Color(colorBlue),
                                fontWeight: FontWeight.w600),
                          ),
                          minWidth: SizeConfig.screenWidth * 0.25,
                          padding: EdgeInsets.zero,
                        )
                      ],
                    ),
                  ),
                ),*/
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.blockSizeVertical * 7,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.05,
                  vertical: SizeConfig.blockSizeVertical * 2),
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
                onPressed: () {},
                child: Text(
                  "Buy All",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: SizeConfig.blockSizeVertical * 2),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
          ],
        ),
      ),
    ));
  }

  Widget _getCartData() {
    return FutureBuilder<CartListModel>(
        future: _callCartAPI(),
        builder: (context, AsyncSnapshot<CartListModel> snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.05,
                  vertical: SizeConfig.blockSizeVertical),
              child: ListView.builder(
                itemBuilder: (context, int index) {
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              colors: [
                                Color(gradientColor1),
                                Color(gradientColor2),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[200],
                                  spreadRadius: 2.0,
                                  blurRadius: 5.0),
                            ]),
                        margin: EdgeInsets.only(
                          bottom: SizeConfig.blockSizeVertical,
                        ),
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight * 0.13,
                        child: Container(
                          margin: EdgeInsets.only(
                              right: SizeConfig.blockSizeHorizontal * 2),
                          child: RotatedBox(
                            child: Text(
                              "Remove",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: SizeConfig.blockSizeVertical * 2),
                            ),
                            quarterTurns: 1,
                          ),
                        ),
                        alignment: Alignment.centerRight,
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight * 0.13,
                        margin: EdgeInsets.only(
                            right: SizeConfig.screenWidth * 0.09),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: SizeConfig.screenWidth * 0.25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.network(snapshot.data.image_url +
                                    "/" +
                                    snapshot.data.date[index].image1),
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth * 0.5,
                              margin: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        snapshot.data.date[index].name,
                                        style: TextStyle(
                                            color: Color(black),
                                            fontWeight: FontWeight.w500,
                                            fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    2),
                                      ),
                                      Text(
                                        snapshot.data.date[index].created_at,
                                        style: TextStyle(
                                            color: Color(0XFF656565),
                                            fontWeight: FontWeight.w500,
                                            fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    1.25),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    snapshot.data.date[index].auther_name,
                                    style: TextStyle(
                                        color: Color(0XFF656565),
                                        fontWeight: FontWeight.w500,
                                        fontSize: SizeConfig.blockSizeVertical *
                                            1.75),
                                  ),
                                  Text(
                                    "Condition: ${snapshot.data.date[index].conditions}",
                                    style: TextStyle(
                                        color: Color(0XFF656565),
                                        fontWeight: FontWeight.w500,
                                        fontSize: SizeConfig.blockSizeVertical *
                                            1.75),
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth * 0.5,
                                    height: SizeConfig.blockSizeVertical * 4,
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(gradientColor1),
                                            Color(gradientColor2),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: MaterialButton(
                                        onPressed: () {},
                                        child: Text(
                                          "$rs ${snapshot.data.date[index].price}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(8),
                      ),
                    ],
                  );
                },
                primary: false,
                shrinkWrap: true,
                itemCount: snapshot.data.date.length,
              ),
            );
          } else {
            return Container();
          }
        });
  }

  Future<CartListModel> _callCartAPI() async {
    Map<String, dynamic> body = {
      "user_id": "${PreferenceManager.getUserId()}",
      "session_key": PreferenceManager.getSessionKey(),
    };

    var res = await ApiCall.post(cartListURL, body);
    var jsonResponse = json.decode(json.encode(res).toString());

    try {
      var data = new CartListModel.fromJson(jsonResponse);
      return data;
    } catch (e) {
      return null;
    }
  }

  removeCart(BuildContext context, String orderId) async {
    Utility.showLoading(context);

    var res = await ApiCall.apiCall(cartRemoveURL, {
      "user_id": "${PreferenceManager.getUserId()}",
      "session_key": PreferenceManager.getSessionKey(),
    });

    var decode = jsonDecode(res.body);
    if (decode["status"] == "200") {
      Utility.hideLoading(context);
    } else {
      CommonSnackBar.snackBar(message: decode["message"]);
    }
  }
}
