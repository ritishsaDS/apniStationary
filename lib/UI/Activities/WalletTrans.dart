import 'dart:convert';

import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/Constants/StringConstants.dart';
import 'package:book_buy_and_sell/Utils/ApiCall.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/Utils/constantString.dart';
import 'package:book_buy_and_sell/Utils/helper/constants.dart';
import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:book_buy_and_sell/model/ClassModel/TransactionModel.dart';
import 'package:book_buy_and_sell/model/ClassModel/WalletModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WalletTrans extends StatefulWidget {
  const WalletTrans({Key key}) : super(key: key);

  @override
  _WalletTransState createState() => _WalletTransState();
}

class _WalletTransState extends State<WalletTrans> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
          backgroundColor: Color(backgroundColor),
          body: FutureBuilder<WalletModel>(
            future: _callWalletAPI(),
            builder: (context,AsyncSnapshot<WalletModel> snapshot){
              if (snapshot.hasData){
                return SingleChildScrollView(
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
                      Container(
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight * 0.17,
                        margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * 0.05,
                            vertical: SizeConfig.blockSizeVertical),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                                colors: [Color(gradientColor1), Color(gradientColor2)])),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Wallet Money",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, color: Colors.white),
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical,
                            ),
                            Text(
                              "$rs ${snapshot.data.date.wallet_amount}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: SizeConfig.blockSizeVertical * 2.5),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                MaterialButton(
                                  onPressed: () {},
                                  height: SizeConfig.blockSizeVertical * 4,
                                  minWidth: SizeConfig.screenWidth * 0.4,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Text("Top Up"),
                                ),

                                MaterialButton(
                                  onPressed: () {},
                                  height: SizeConfig.blockSizeVertical * 4,
                                  minWidth: SizeConfig.screenWidth * 0.4,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Text("Withdraw"),
                                )
                              ],
                            ),


                          ],
                        ),
                      ),

                      Container(
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * 0.05,
                            vertical: SizeConfig.blockSizeVertical),
                        child: Text(
                          "Holding Payment",
                          style: TextStyle(
                              color: Color(black),
                              fontWeight: FontWeight.w600,
                              fontSize: SizeConfig.blockSizeVertical * 2),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20,right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Container(
                                
                                height: 100,
                               
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: LinearGradient(
                                        colors: [Color(gradientColor1), Color(gradientColor2)])),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Received",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500, color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical,
                                    ),
                                    Text(
                                      "$rs ${snapshot.data.date.received_hold_amount}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontSize: SizeConfig.blockSizeVertical * 2.5),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Container(
                                height: 100,
                           
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: LinearGradient(
                                        colors: [Color(gradientColor1), Color(gradientColor2)])),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Paid",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500, color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical,
                                    ),
                                    Text(
                                      "$rs ${snapshot.data.date.paid_hold_amount}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontSize: SizeConfig.blockSizeVertical * 2.5),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                    /*  Container(
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * 0.05,
                            vertical: SizeConfig.blockSizeVertical),
                        child: Text(
                          "Transactions",
                          style: TextStyle(
                              color: Color(black),
                              fontWeight: FontWeight.w600,
                              fontSize: SizeConfig.blockSizeVertical * 2),
                        ),
                      ),
                      FutureBuilder<TransactionModel>(
                          future: ApiCall.callTransactionAPI(),
                          builder: (context,AsyncSnapshot<TransactionModel> snapshot){
                        if(snapshot.hasData){
                          return ListView.builder(
                            itemBuilder: (context, int index) {
                              return Container(

                                margin: EdgeInsets.only(left: 20,right: 20,bottom: 10),

                                padding: EdgeInsets.all(8),
                                height: SizeConfig.screenHeight * 0.15,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[200],
                                      spreadRadius: 2.0,
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.asset('assets/icons/axis.png'),
                                      ),
                                    ),
                                    Container(

                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 150,
                                            child: Text(
                                              snapshot.data.date[index].message,

                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5,),

                                          Text(
                                            snapshot.data.date[index].created_at,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: SizeConfig.blockSizeVertical * 1.5),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    Container(

                                      child: Text("${getSign(snapshot.data.date[index].type)} $rs ${snapshot.data.date[index].amount}"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            primary: false,
                            itemCount: snapshot.data.date.length,
                            shrinkWrap: true,
                          );
                        }else{
                          return Container();
                        }
                      }),*/
                   /*   Container(
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * 0.05,
                            vertical: SizeConfig.blockSizeVertical),
                        child: Text(
                          "Other Options",
                          style: TextStyle(
                              color: Color(black),
                              fontWeight: FontWeight.w600,
                              fontSize: SizeConfig.blockSizeVertical * 2),
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * 0.05,
                            vertical: SizeConfig.blockSizeVertical),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[200],
                              spreadRadius: 2.0,
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: SizeConfig.screenWidth * 0.25,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset('assets/icons/debit.png',
                                    width: SizeConfig.screenWidth * 0.2,),
                                  Text("Debit / Credit Card",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: SizeConfig.blockSizeVertical * 1.5

                                    ),)
                                ],
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth * 0.25,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset('assets/icons/net banking.png',
                                    width: SizeConfig.screenWidth * 0.2,),
                                  Text("Net Banking",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: SizeConfig.blockSizeVertical * 1.5

                                    ),)
                                ],
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth * 0.25,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset('assets/icons/upi.png',
                                      width: SizeConfig.screenWidth * 0.2,
                                      height: SizeConfig.screenHeight * 0.1),
                                  Text("UPI Payments",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: SizeConfig.blockSizeVertical * 1.5

                                    ),)
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
                        child: Text(
                          "Transactions",
                          style: TextStyle(
                              color: Color(black),
                              fontWeight: FontWeight.w600,
                              fontSize: SizeConfig.blockSizeVertical * 2),
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * 0.05,
                            vertical: SizeConfig.blockSizeVertical),
                        padding: EdgeInsets.all(8),
                        height: SizeConfig.screenHeight * 0.15,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[200],
                              spreadRadius: 2.0,
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: SizeConfig.screenWidth * 0.25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset('assets/icons/book.png'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 2),
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width:SizeConfig.screenWidth * 0.25,
                                        child: Text(
                                          "Book Name",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: SizeConfig.screenWidth * 0.15
                                        ),
                                        child: Text(
                                          "10/07/2021",
                                          style: TextStyle(
                                              color: Color(black),
                                              fontWeight: FontWeight.w500,
                                              fontSize: SizeConfig.blockSizeVertical * 1.25
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Axis Bank",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "**** **** **** 0230",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: SizeConfig.blockSizeHorizontal * 10
                                        ),
                                        width: SizeConfig.screenWidth * 0.15,
                                        child: Image.asset(
                                            'assets/icons/mastercard.png'),
                                      ),
                                    ],
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
                            horizontal: SizeConfig.screenWidth * 0.05
                        ),
                        height: SizeConfig.blockSizeVertical * 7,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Color.fromRGBO(212,247,255,0.45)
                        ),
                        child: MaterialButton(
                          onPressed: (){},
                          child: Row(
                            children: [
                              ImageIcon(AssetImage('assets/icons/offer.png'),color: Color(colorBlue),size: SizeConfig.blockSizeVertical * 4,),
                              Text("Get 10% off on 1st Wallet Topup",
                                style: TextStyle(
                                    color: Color(black),
                                    fontWeight: FontWeight.w500,
                                    fontSize: SizeConfig.blockSizeVertical * 1.65
                                ),),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 4,
                              ),
                              MaterialButton(onPressed: (){},
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)
                                ),
                                color: Colors.white,
                                child: Text("Apply Now",
                                  style: TextStyle(
                                      color: Color(colorBlue),
                                      fontWeight: FontWeight.w600,
                                      fontSize: SizeConfig.blockSizeVertical * 1.5
                                  ),),
                                minWidth: SizeConfig.screenWidth * 0.2,
                                padding: EdgeInsets.zero,)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 4,
                      ),*/

                    ],
                  ),
                );
              }else{
                return Container();
              }
            },
          ),
        ));
  }
  


  Future<WalletModel> _callWalletAPI() async {

    Map<String, dynamic> body = {
      "user_id": "${PreferenceManager.getUserId()}",
      "session_key": PreferenceManager.getSessionKey(),
    };

    var res = await ApiCall.post(walletURL, body);
    var jsonResponse = json.decode(json.encode(res).toString());
    var data = new WalletModel.fromJson(jsonResponse);

    return data;
  }


}
String getSign(String type){
  if(type == "Dr"){
    return "-";
  }else{
    return  "+";
  }
}