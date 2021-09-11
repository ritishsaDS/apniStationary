import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/Constants/StringConstants.dart';
import 'package:book_buy_and_sell/UI/Activities/BookDetails.dart';
import 'package:book_buy_and_sell/UI/Activities/Cart.dart';
import 'package:book_buy_and_sell/UI/Activities/WalletTrans.dart';
import 'package:book_buy_and_sell/Utils/ApiCall.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/model/ClassModel/TransactionModel.dart';
import 'package:flutter/material.dart';

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
                  if (snapshot.hasData) {
                    if (snapshot.data.date.length > 0) {
                      return ListView.builder(
                        itemBuilder: (context, int index) {
                          return Container(
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 10),
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
                                      Text(
                                        snapshot.data.date[index].created_at,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    1.5),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(child: Container()),
                                Container(
                                  child: Text(
                                      "${getSign(snapshot.data.date[index].type)} $rs ${snapshot.data.date[index].amount}"),
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
                      return getNodDataWidget();
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
}
