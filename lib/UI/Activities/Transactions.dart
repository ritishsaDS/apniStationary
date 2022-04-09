import 'dart:typed_data';
import 'package:book_buy_and_sell/common/preference_manager.dart';

import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'mobile.dart' if (dart.library.html) 'web.dart';
import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/Constants/StringConstants.dart';
import 'package:book_buy_and_sell/UI/Activities/BookDetails.dart';
import 'package:book_buy_and_sell/UI/Activities/Cart.dart';
import 'package:book_buy_and_sell/UI/Activities/WalletTrans.dart';
import 'package:book_buy_and_sell/Utils/ApiCall.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/model/ClassModel/TransactionModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key key}) : super(key: key);

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Transactions",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Color(black)),
                  ),
                  Container(
                    width: SizeConfig.screenWidth * 0.23,
                    height: SizeConfig.blockSizeVertical * 0.2,
                    decoration: BoxDecoration(color: Color(colorBlue)),
                  ),
                ],
              ),
            ),
            FutureBuilder<TransactionModel>(
                future: ApiCall.callTransactionAPI(),
                builder: (context, AsyncSnapshot<TransactionModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: EdgeInsets.only(top:200),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (snapshot.hasData) {
                    if (snapshot.data.date.length > 0) {
                      return ListView.builder(
                        itemBuilder: (context, int index) {
                          return Container(
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 10),
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
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child:
                                        Image.asset('assets/icons/debit.png'),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot
                                                .data.date[index].created_at,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: SizeConfig
                                                        .blockSizeVertical *
                                                    1.5),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(child: Container()),
                                Column(
                                  children: [
                                    Container(
                                      child: Text(
                                          "${getSign(snapshot.data.date[index].type)} $rs ${snapshot.data.date[index].amount}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize:
                                                  SizeConfig.blockSizeVertical *
                                                      2)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        primary: false,
                        itemCount: snapshot.data.date.length,
                        shrinkWrap: true,
                      );
                    } else {
                      return getNotWidget();
                    }
                  } else {
                    return Container();
                  }
                }),
          ],
        ),
      ),
    ));
  }

  Widget getNotWidget() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
            "No Transaction Found",
            style: TextStyle(fontSize: 20),
          )),
        ],
      ),
    );
  }
}

Future<Uint8List> _readImageData(String name) async {
  final data = await rootBundle.load('assets/icons/applogo.png');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}
