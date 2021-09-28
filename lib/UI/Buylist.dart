import 'dart:convert';

import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/Constants/StringConstants.dart';
import 'package:book_buy_and_sell/Utils/ApiCall.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/Utils/constantString.dart';
import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:book_buy_and_sell/model/ClassModel/BuyerOrderModel.dart';
import 'package:flutter/material.dart';

class buylist extends StatefulWidget{
  @override
  _buylistState createState() => _buylistState();
}

class _buylistState extends State<buylist> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return SafeArea(child: _getBuyerOrdersList());
  }
  Widget _getBuyerOrdersList() {
    return FutureBuilder<BookOrderModel>(
        future: _callBuyerAPI(),
        builder: (context, AsyncSnapshot<BookOrderModel> snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.05,
                  vertical: SizeConfig.blockSizeVertical),
              child: ListView.builder(
                itemBuilder: (context, int index) {
                  return InkWell(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) {
                      //   return BookDetail("");
                      // }));
                    },
                    child: Container(
                      width: SizeConfig.screenWidth,
                      margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200],
                                spreadRadius: 3.0,
                                blurRadius: 2.0),
                          ]),
                      child: Row(
                        children: [
                          Container(
                            width: SizeConfig.screenWidth * 0.2,
                            height: SizeConfig.screenHeight * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(snapshot.data.image_url +
                                  "/" +
                                  snapshot.data.date[index].book_image),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data.date[index].book_name,
                                  style: TextStyle(
                                      color: Color(0XFF06070D),
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  "$rs ${snapshot.data.date[index].pay_amount}",
                                  style: TextStyle(
                                      color: Color(colorBlue),
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: SizeConfig.screenWidth * 0.2,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Status :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Color(0XFF656565),
                                                fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    1.5),
                                          ),

                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: SizeConfig.screenWidth * 0.3,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data.date[index].order_status,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Color(0XFF656565),
                                                fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    1.5),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                /* Container(
                              width: SizeConfig.screenWidth * 0.6,
                              alignment: Alignment.centerRight,
                              child: Text(
                                "More Info",
                                style: TextStyle(
                                    color: Color(colorBlue),
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                        SizeConfig.blockSizeVertical * 1.35),
                              ),
                            ),*/
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                shrinkWrap: true,
                itemCount: snapshot.data.date.length,
                primary: false,
              ),
            );
          } else {
            return getNotDataWidget(

            );
          }
        });
  }

  Widget getNotDataWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.info_outline,size: 100,color: Colors.blue.withOpacity(0.6),),
          SizedBox(height: 10,),
          Text("No Data Found",style: TextStyle(fontSize: 20),),
        ],
      ),
    );
  }
  Future<BookOrderModel> _callBuyerAPI() async {
    Map<String, dynamic> body = {
      "user_id": "${PreferenceManager.getUserId()}",
      "session_key": PreferenceManager.getSessionKey(),
    };

    var res = await ApiCall.post(buyerOrderListURL, body);
    var jsonResponse = json.decode(json.encode(res).toString());

    try {
      var data = new BookOrderModel.fromJson(jsonResponse);
      return data;
    } catch (e) {
      return null;
    }
  }
}